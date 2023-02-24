import json
import law
import itertools
from collections import OrderedDict
from copy import deepcopy as copy

from analysis_tools.utils import import_root, randomize
ROOT = import_root()

from cmt.base_tasks.preprocessing import MergeCategorizationStats
from cmt.base_tasks.plotting import FeaturePlot, PrePlot

from plotting_tools import Label

class VBFFeaturePlot(FeaturePlot):

    target_kvs = law.CSVParameter(default=("1",), description="kvs to be used "
        "in the HH model, default=1")
    target_k2vs = law.CSVParameter(default=("1",), description="k2vs to be used "
        "in the HH model, default=1")
    target_kls = law.CSVParameter(default=("1",), description="kls to be used "
        "in the HH model, default=1")

    dataset_names = ['vbf_sm', 'vbf_1_1_0', 'vbf_1_1_2', 'vbf_1_0_1',
        'vbf_1_2_1', 'vbf_1p5_1_1']

    parameters = [(1, 1, 1), (1, 1, 0), (1, 1, 2), (1, 0, 1), (1, 2, 1), (1.5, 1, 1)]

    do_qcd = False
    blinded = False

    process_group_name = "vbf"

    def __init__(self, *args, **kwargs):
        super(VBFFeaturePlot, self).__init__(*args, **kwargs)
        self.target_kvs = [float(value) for value in self.target_kvs]
        self.target_k2vs = [float(value) for value in self.target_k2vs]
        self.target_kls = [float(value) for value in self.target_kls]

    def requires(self):
        reqs = {}
        reqs["data"] = OrderedDict(
            ((dataset.name, category.name), PrePlot.vreq(self,
                dataset_name=dataset.name, category_name=self.get_data_category(category).name))
            for dataset, category in itertools.product(
                self.datasets_to_run, self.expand_category())
        )
        reqs["stats"] = OrderedDict(
            (dataset.name, MergeCategorizationStats.vreq(self, dataset_name=dataset.name))
            for dataset in self.datasets_to_run if not dataset.process.isData
        )
        return reqs

    def run(self):
        from tasks.VBFReweightModules import InputSample, VBFReweight

        ROOT.gStyle.SetOptStat(0)

        # create root tchains for inputs
        inputs = self.input()

        self.nevents = self.get_nevents()

        self.data_names = []
        self.signal_names = []
        self.background_names = []

        samples = [InputSample(kv, k2v, kl, dataset.xs)
            for ((kv, k2v, kl), dataset) in zip(self.parameters, self.datasets)]

        vbf_reweight = VBFReweight(samples)
        
        for feature in self.features:
            self.histos = {}
            feature_name = feature.name
            self.histos = {"background": [], "signal": [], "data": [], "all": []}

            binning_args, y_axis_adendum = self.get_binning(feature)
            x_title = (str(feature.get_aux("x_title"))
                + (" [%s]" % feature.get_aux("units") if feature.get_aux("units") else ""))
            y_title = ("Events" if self.stack else "Normalized Events") + y_axis_adendum
            hist_title = "; %s; %s" % (x_title, y_title)

            if self.plot_systematics:
                self.histos["bkg_histo_syst"] = ROOT.TH1D(
                    randomize("syst"), hist_title, *binning_args)

            dataset_histos = []
            for dataset in self.datasets:
                dataset_histo = ROOT.TH1D(randomize("tmp"), hist_title, *binning_args)
                dataset_histo.Sumw2()
                for category in self.expand_category():
                    inp = inputs["data"][
                        (dataset.name, category.name)].collection.targets.values()
                    for elem in inp:
                        rootfile = ROOT.TFile.Open(elem.path)
                        histo = copy(rootfile.Get(feature_name))
                        rootfile.Close()
                        dataset_histo.Add(histo)
                if self.nevents[dataset.name] != 0:
                    dataset_histo.Scale(self.get_normalization_factor(dataset))

                dataset_histos.append(dataset_histo)

            for i, (t_kv, t_k2v, t_kl) in enumerate(
                    itertools.product(self.target_kvs, self.target_k2vs, self.target_kls)):
                _, signal_histo = vbf_reweight.modelSignal(t_kv, t_k2v, t_kl, dataset_histos)

                self.setup_signal_hist(signal_histo, 2 + i)

                if int(t_kv) - t_kv == 0:
                    t_kv = int(t_kv)
                if int(t_k2v) - t_k2v == 0:
                    t_k2v = int(t_k2v)
                if int(t_kl) - t_kl == 0:
                    t_kl = int(t_kl)

                signal_histo.process_label = str(Label("$HH_{VBF}^{(%s,%s,%s)}$" % (t_kv, t_k2v, t_kl)))
                cmt_process_name = "vbf_%s_%s_%s" % (t_kv, t_k2v, t_kl)
                signal_histo.cmt_process_name = cmt_process_name.replace(".", "p")
                self.histos["signal"].append(signal_histo)
                self.histos["all"].append(signal_histo)

            self.plot(feature)


