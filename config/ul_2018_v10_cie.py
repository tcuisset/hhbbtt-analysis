from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2018 import Config_ul_2018 as base_config


class Config_ul_2018_cie(base_config):
    def __init__(self, *args, **kwargs):
        super(Config_ul_2018_cie, self).__init__(*args, **kwargs)
        self.deeptau=DotDict(
            vsjet=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vse=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vsmu=DotDict(VLoose=1, Loose=1, Medium=3, Tight=4),
        )
        self.regions = self.add_regions()

    def add_datasets(self):
        p = "/pnfs/ciemat.es/data/cms/store/user/cepeda/HH/bbtautauV10/" 
        #p = "/store/user/cepeda/HH/bbtautauV10/" 
        v9_datasets = super(Config_ul_2018_cie, self).add_datasets()
        datasets = [
            Dataset("ggf_sm",
                folder=p + "GluGluToHHTo2B2Tau_node_SM",
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
            Dataset("dy",
                folder=p+"DYJetsToLL_M-50",
                process=self.processes.get("dy_high"),
                # prefix="xrootd-cms.infn.it//",
                prefix="xrootd-es-cie.ciemat.es:1096/",
                xs=6077.22,
                merging={
                    "tautau": 10,
                    "etau": 10,
                    "mutau": 10,
                },
                secondary_dataset="dy_nlo_aux",
                tags=["ul", "nanoV10"]),

            # TT
            Dataset("tt_dl",
                folder= p+"TTTo2L2Nu",
                process=self.processes.get("tt_dl"),
		prefix="xrootd-es-cie.ciemat.es:1096/",
                xs=88.29,
                merging={
                    "tautau": 20,
                    "mutau": 20,
                    "etau": 40,
                },
                scaling=(0.96639, 0.00863),
                secondary_dataset="tt_dl_aux",
                tags=["ul", "nanoV10"]),
            Dataset("tt_sl",
                folder=p + "TTToSemiLeptonic",
                process=self.processes.get("tt_sl"),
                prefix="xrootd-es-cie.ciemat.es:1096/",
                # prefix="xrootd-cms.infn.it//",
                xs=365.34,
                merging={
                    "tautau": 20,
                    "mutau": 60,
                    "etau": 40,
                },
                scaling=(0.96639, 0.00863),
                secondary_dataset="tt_sl_aux",
                tags=["ul", "nanoV10"]),
            Dataset("tt_fh",
                folder=p+"TTToHadronic",
                process=self.processes.get("tt_fh"),
                prefix="xrootd-es-cie.ciemat.es:1096//",
                # prefix="xrootd-cms.infn.it//",
                xs=377.96,
                scaling=(0.96639, 0.00863),
                secondary_dataset="tt_fh_aux",
                tags=["ul", "nanoV10"]),
	]	
        datasets = ObjectCollection(datasets)

        for name in ["tt_dl", "tt_sl", "tt_fh"]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )

        return datasets

config = Config_ul_2018_cie("ul_2018_v10_cie", year=2018, ecm=13, lumi_pb=59741)
