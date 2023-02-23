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

class ggFFeaturePlot(FeaturePlot):

    target_kls = law.CSVParameter(default=("1",), description="kls to be used "
        "in the HH model, default=1")
    target_kts = law.CSVParameter(default=("1",), description="kts to be used "
        "in the HH model, default=1")

    dataset_names = ['ggf_sm', 'ggf_2p45_1', 'ggf_5_1']

    parameters = [(1, 1), (2.45, 1), (5, 1)]

    do_qcd = False
    blinded = False

    process_group_name = "ggf"

    def __init__(self, *args, **kwargs):
        super(ggFFeaturePlot, self).__init__(*args, **kwargs)
        self.target_kls = [float(value) for value in self.target_kls]
        self.target_kts = [float(value) for value in self.target_kts]

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
        from tasks.ggFReweightModules import InputSample, ggFReweight

        ROOT.gStyle.SetOptStat(0)

        # create root tchains for inputs
        inputs = self.input()

        self.nevents = self.get_nevents()

        self.data_names = []
        self.signal_names = []
        self.background_names = []

        samples = [InputSample(kl, kt, dataset.xs)
            for ((kl, kt), dataset) in zip(self.parameters, self.datasets)]

        ggf_reweight = ggFReweight(samples)

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

            for i, (t_kl, t_kt) in enumerate(
                    itertools.product(self.target_kls, self.target_kts)):
                _, signal_histo = ggf_reweight.modelSignal(t_kl, t_kt, dataset_histos)

                if int(t_kl) - t_kl == 0:
                    t_kl = int(t_kl)
                if int(t_kt) - t_kt == 0:
                    t_kt = int(t_kt)

                self.setup_signal_hist(signal_histo, 2 + i)
                signal_histo.process_label = str(Label("$HH_{ggF}^{(%s,%s)}$" % (t_kl, t_kt)))
                signal_histo.cmt_process_name = "ggf_%s_%s" % (t_kl, t_kt)
                self.histos["signal"].append(signal_histo)
                self.histos["all"].append(signal_histo)

            self.plot(feature)


