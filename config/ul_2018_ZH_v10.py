from types import MethodType
import copy
import itertools

from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZH import Config as Base_config_ZH
from config.ul_2018_v9 import get_2018_weights, get_common_datasets_v9
from config.ul_2018_v10 import setupBtagDeeptau, get_common_datasets_v10

class Config_ul_2018_ZH_v10(Base_config_ZH):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_weights()
        
        for baseEllipticalCut in ["ZH_elliptical_cut_zbb_htt_v1", "ZH_elliptical_cut_ztt_hbb_v1"]:
            weights[baseEllipticalCut] = weights.mutau
            for channelName, pairType in {"mutau":0, "etau": 1, "tautau":2}.items():
                weights[baseEllipticalCut + "_" + channelName] = weights.mutau
        return weights

    #@override
    def add_datasets(self):
        v9_datasets = get_common_datasets_v9(self)
        datasets = get_common_datasets_v10(self)

        for name in [
            "wjets", "dy", "ewk_z", "ewk_wplus", "ewk_wminus", "tt_dl", "tt_sl", "tt_fh",
            "st_tw_antitop", "st_tw_top", "st_antitop", "st_top",
            "zz_dl", 
            #"zz_sl_background", 
            "zz_fh", "zz_lnu", "zz_qnu",
            "wz_lllnu", "wz_lnuqq", "wz_lnununu", "wz_llqq", "ww_llnunu", "ww_lnuqq", "ww_qqqq",
            "zzz", "wzz", "www", "wwz", 
            "ttw_lnu", "ttw_qq", "ttww", "ttwz", "ttwh", "ttzh", "ttz_llnunu", "ttz_qq", "ttzz", 
            # "zh_hbb_zll", "zh_htt",
            "wminush_htt", "wplush_htt", "vbf_htt", 
            "tth_bb", "tth_nonbb", "tth_tautau", "ggH_ZZ", "ggf_sm", 
            # "zz_sl_signal", "zz_bbtt"
            ]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )
        
        datasets += ObjectCollection([
            ## Zprime -> ZH resonance high mass
            Dataset("ggZpZHttbb_M600",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobsPilots/gg_X_ZZbbtautau_M600/Step_4",
                process=self.processes.get("ggZpZHttbb_M600"),
                xs=1,
                tags=["ul", "nanoV10"])
        ])

        # ZH datasets
        # ZH_HToBB_ZToLL is split in 2 : process zh_zbbhtt_sl_signal (with genMatching for bbtautau decay) 
        # and for process zh_sl_background (with inverted genMatching)
        p = "/data_CMS/cms/vernazza/FrameworkNanoAOD/HHbbtautau_NanoAODv10/"
        datasets += ObjectCollection([
            #### ZH_hbb
            Dataset("zh_hbb_zll_background",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_sl_background"),
                xs=0.052,
                secondary_dataset="zh_hbb_zll_background_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_hbb_zll_background_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_sl_background"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),
            
            Dataset("zh_ztt_hbb_sl_signal",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_ztt_hbb_sl_signal"),
                xs=0.052,
                secondary_dataset="zh_ztt_hbb_sl_signal_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_ztt_hbb_sl_signal_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_ztt_hbb_sl_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),
            
            ##### ZH_Hbb_Zqq
            Dataset("zh_htt_background",
                folder=p + "ZH_Hbb_Zqq",
                process=self.processes.get("zh_sl_background"),
                xs=0.36,
                secondary_dataset="zh_htt_background_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_htt_background_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8_ext1/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_sl_background"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),
            
            Dataset("zh_zbb_htt_sl_signal",
                folder=p + "ZH_Hbb_Zqq",
                process=self.processes.get("zh_zbb_htt_sl_signal"),
                xs=0.36,
                secondary_dataset="zh_zbb_htt_sl_signal_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_zbb_htt_sl_signal_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8_ext1/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_zbb_htt_sl_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),  
        ])

        ### ZH background
        datasets += ObjectCollection([
            Dataset("zh_hbb_zqq",
                folder=p + "ZH_Hbb_Zqq",
                process=self.processes.get("zh_sl_background"), # replaced from zh_hbb compared to ZZ
                xs=0.36,
                secondary_dataset="zh_hbb_zqq_aux", # the actual secondary 
                tags=["ul", "nanoV10"]),
            
            # not sure why the aux dataset is commented out (it was already the case for ZZ)

            # Dataset("zh_hbb_zqq",
            #     dataset="/ZH_HToBB_ZToQQ_M-125_TuneCP5_13TeV-powheg-pythia8/"
            #         "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
            #     process=self.processes.get("zh_hbb"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.36, # AN
            #     # xs=0.5612, # XSDB NLO
            #     splitting=200000,
            #     tags=["ul"]),
        ])

        return datasets

config = Config_ul_2018_ZH_v10("ul_2018_ZH_v10", year=2018, ecm=13, lumi_pb=59741, isUL=True)