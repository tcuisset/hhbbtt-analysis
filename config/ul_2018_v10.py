from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2018 import Config_ul_2018 as base_config


class Config_ul_2018(base_config):
    def __init__(self, *args, **kwargs):
        super(Config_ul_2018, self).__init__(*args, **kwargs)
        self.deeptau=DotDict(
            vsjet=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vse=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vsmu=DotDict(VLoose=1, Loose=1, Medium=3, Tight=4),
        )

    def add_datasets(self):
        datasets = [
            Dataset("ggf_sm",
                folder="/eos/user/g/goylopez/Jaime/nanoaod/260922/GluGluToHHTo2B2Tau_node_SM/",
                process=self.processes.get("ggf_sm"),
                xs=0.03105,
                tags=["ul", "nanoV10"], 
                secondary_dataset="ggf_sm_aux"),
            Dataset("ggf_sm_aux",
                dataset="/GluGluToHHTo2B2Tau_TuneCP5_PSWeights_node_SM_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ggf_sm"),
                xs=0.03105,
                tags=["ul", "secondary"]),
        ]
        return ObjectCollection(datasets)

config = Config_ul_2018("ul_2018_v10", year=2018, ecm=13, lumi_pb=59741)
