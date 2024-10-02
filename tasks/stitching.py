""" Drell-Yan stitching weights computation """
import os
from collections import OrderedDict

import law
from law.contrib.root import GuardedTFile
import luigi
import numpy as np

from analysis_tools.utils import DotDict, join_root_selection as jrs
from analysis_tools.utils import import_root, create_file_dir

from cmt.base_tasks.base import (
    DatasetTaskWithCategory, DatasetWrapperTask, HTCondorWorkflow, SGEWorkflow, SlurmWorkflow,
    InputData, ConfigTaskWithCategory, SplittedTask, DatasetTask, RDFModuleTask
)


class StitchSkim(DatasetTask, law.LocalWorkflow, HTCondorWorkflow, SGEWorkflow, SlurmWorkflow,
        SplittedTask):
    """ Skims NanoAOD to keep only genWeight & LHE branches for stitching """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def create_branch_map(self):
        """
        :return: number of files for the selected dataset
        :rtype: int
        """
        return len(self.dataset.get_files(
            os.path.expandvars("$CMT_TMP_DIR/%s/" % self.config_name), add_prefix=False,
            check_empty=False))
        
    def workflow_requires(self):
        """
        """
        return {"data": InputData.req(self)}

    def requires(self):
        """
        Each branch requires one input file
        """
        return InputData.req(self, file_index=self.branch)

    def output(self):
        return self.local_target(f"data_{self.branch}.root")


    @law.decorator.notify
    @law.decorator.localize(input=False)
    def run(self):
        ROOT = import_root()
        ROOT.ROOT.EnableImplicitMT(self.request_cpus)
        verbosity = ROOT.Experimental.RLogScopedVerbosity(ROOT.Detail.RDF.RDFLogChannel(), ROOT.Experimental.ELogLevel.kInfo)

        # create RDataFrame
        inp = self.input()
        print(inp[0].path)
        df = ROOT.RDataFrame(self.tree_name, inp[0].path)
        
        # For Drell-Yan stitching : 
        # the int conversion is necessary for numpy export
        df.Define("LHE_NpNLOInt", "(int)LHE_NpNLO").Snapshot(self.tree_name, create_file_dir(self.output().path), ["genWeight", "LHE_NpNLOInt", "LHE_Vpt"])
        
        # .AsNumpy(["genWeight", "LHE_NpNLOInt", "LHE_Vpt"])

        # with open(create_file_dir(self.output().path), "wb") as handle:
        #     #pickle.dump(ar, handle)
        #     np.savez_compressed(handle, **ar)


class MergeStitchSkim(DatasetTask, law.tasks.ForestMerge):
    """ hadd the files from StitchSkim """
    merge_factor = 50
    n_files_after_merging = 1

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.input_task_cls = StitchSkim

    def merge_workflow_requires(self):
        return self.input_task_cls.vreq(self, _prefer_cli=["workflow"])

    def merge_requires(self, start_leaf, end_leaf):
        return self.input_task_cls.vreq(self, workflow="local",
            branches=((start_leaf, end_leaf),), _exclude={"branch"})

    def trace_merge_inputs(self, inputs):
        return [inp for inp in inputs["collection"].targets.values()]

    def merge_output(self):
        return law.SiblingFileCollection([
            self.local_target("data_{}.root".format(i))
            for i in range(self.n_files_after_merging)
        ])

    def merge(self, inputs, output):
        ROOT = import_root()
        # with output.localize("w") as tmp_out:
        with output.localize("w") as tmp_out:
            good_inputs = []
            for inp in inputs:  # merge only files with a filled tree
                # inp = inp.targets["root"]
                try:
                    tf = ROOT.TFile.Open(inp.path)
                except:
                    inp = inp.targets["root"]
                    tf = ROOT.TFile.Open(inp.path)
                try:
                    tree = tf.Get(self.tree_name)
                    if tree.GetEntries() > 0:
                        good_inputs.append(inp)
                except:
                    print("File %s not used" % inp.path)
            if len(good_inputs) != 0:
                print("Merging with hadd...")
                law.root.hadd_task(self, good_inputs, tmp_out, local=True)
            else:  # if all input files are empty, create an empty file as output
                tf = ROOT.TFile.Open(create_file_dir(tmp_out.path), "RECREATE")
                tf.Close()


class MergeStitchSkimWrapper(DatasetWrapperTask, law.WrapperTask):
    def requires(self):
        return OrderedDict(
            (dataset_name, MergeStitchSkim.vreq(self, dataset_name=dataset_name))
            for dataset_name in self.dataset_names
        )

class StichWeights(DatasetWrapperTask):
    """ Computes correctionlib with stitching weights for Drell-Yan """
    inclusive_dataset_name = luigi.Parameter(description="Inclusive dataset name (to compute the fraction of events in each phase space region), ususally 'dy' or 'dy_aux'")
    
    def requires(self):
        return OrderedDict(
            (dataset_name, MergeStitchSkim.vreq(self, dataset_name=dataset_name))
            for dataset_name in self.dataset_names
        )
    
    def output(self):
        return self.local_target(f"stich_weights.json")

    @law.decorator.notify
    @law.decorator.localize(input=False)
    def run(self):
        inp = self.input()
        dataset_names = inp.keys()

        import uproot
        from tqdm import tqdm
        import correctionlib.schemav2 as cs
        import hist
        import sys

        ars = {}
        for dataset, merge_skim in tqdm(inp.items()):
            ars[dataset] = uproot.open(merge_skim[0].path + ":Events").arrays(library="np")
        
        
        def make_hist():
            return hist.Hist(
                hist.axis.Integer(0, 5, name="LHE_NpNLO"),
                hist.axis.Variable([sys.float_info.epsilon, 50, 100, 250, 400, 650], name="LHE_Vpt", underflow=True, overflow=True),
                storage="weight"
            )

        hs = {}
        for dataset, ar in ars.items():
            h = make_hist()
            h.fill(LHE_NpNLO=ar["LHE_NpNLOInt"], LHE_Vpt=ar["LHE_Vpt"], weight=ar["genWeight"]/np.average(ar["genWeight"]))
            hs[dataset] = h

        s_matrix = np.zeros((3, 7)) # x  NpNLO 0 to 2, y : PtZ 0, 0to50, 50to100, 100to250, 250to400, 400to650, GreaterThan650

        def Pij(LHE_NpNLO, LHE_Vpt_bin, dataset):
            """ LHE_NpNLO (actual nb), LHE_Vpt_bin (bin number) = i, dataset = j"""
            h = hs[dataset]
            return h[dict(LHE_NpNLO=hist.loc(LHE_NpNLO), LHE_Vpt=LHE_Vpt_bin)].value / h.sum(flow=True).value

        def s_i(LHE_NpNLO, LHE_Vpt_bin):
            """ WITHOUT lumi & incl cross-section """
            try:
                return Pij(LHE_NpNLO, LHE_Vpt_bin, self.inclusive_dataset_name) / sum((Pij(LHE_NpNLO, LHE_Vpt_bin, dataset) * hs[dataset].sum(flow=True).value for dataset in dataset_names))
            except ZeroDivisionError:
                return 0
        
        for LHE_NpNLO in range(3):
            s_matrix[LHE_NpNLO, 0] = s_i(LHE_NpNLO, hist.underflow)
            for LHE_Vpt_bin in range(0, 4+1):
                s_matrix[LHE_NpNLO, LHE_Vpt_bin+1] = s_i(LHE_NpNLO, LHE_Vpt_bin)
            s_matrix[LHE_NpNLO, 6] = s_i(LHE_NpNLO, hist.overflow)
        

        corr = cs.Correction(
            name="drellYanStitchWeight",
            description=f"Drell-Yan stitching weights for {self.config_name} (computed from {', '.join(self.dataset_names)})",
            version=1,
            inputs=[
                cs.Variable(name="LHE_NpNLO", type="int"),
                cs.Variable(name="LHE_Vpt", type="real", description="Z boson pT at LHE (can be zero)")
            ],
            output=cs.Variable(name="weight", type="real", description="Stitching weight"),
            data=cs.Category(
                nodetype='category',
                input='LHE_NpNLO',
                content=[
                    cs.CategoryItem(
                        key=LHE_NpNLO,
                        value=cs.Binning(
                            nodetype='binning',
                            input='LHE_Vpt',
                            # the PtZ=0 needs to be included
                            edges=[-1e-10, 1e-10, 50.0, 100.0, 250.0, 400.0, 650.0],
                            content=s_matrix[LHE_NpNLO, :-1].tolist(),
                            flow=s_matrix[LHE_NpNLO, -1] # for greater than 650
                        )
                    )
                    for LHE_NpNLO in range(0, 2+1)
                ]
            )
        )
        
        self.output().dump(corr.json(exclude_unset=True), formatter="json")

