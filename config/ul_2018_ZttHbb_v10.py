from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZH import Config as base_config_ZH
from config.ul_2018_v9 import get_2018_weights, get_common_datasets_v9
from config.ul_2018_v10 import setupBtagDeeptau, get_common_datasets_v10

class Config_ul_2018_ZH_v10(base_config_ZH):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_weights()
        weights.ZH_elliptical_cut_ztt_hbb_v1 = weights.mutau
        weights.ZH_elliptical_cut_ztt_hbb_v1_mutau = weights.mutau
        weights.ZH_elliptical_cut_ztt_hbb_v1_etau = weights.mutau
        weights.ZH_elliptical_cut_ztt_hbb_v1_tautau = weights.mutau
        return weights

    #@override
    def add_datasets(self):
        v9_datasets = get_common_datasets_v9(self)
        datasets = get_common_datasets_v10(self)

        for name in [
            "wjets", "dy", "ewk_z", "ewk_wplus", "ewk_wminus", "tt_dl", "tt_sl", "tt_fh",
            "st_tw_antitop", "st_tw_top", "st_antitop", "st_top",
            "zz_dl", "zz_fh", "zz_lnu", "zz_qnu",
            "wz_lllnu", "wz_lnuqq", "wz_lnununu", "wz_llqq", "ww_llnunu", "ww_lnuqq", "ww_qqqq",
            "zzz", "wzz", "www", "wwz", 
            "ttw_lnu", "ttw_qq", "ttww", "ttwz", "ttwh", "ttzh", "ttz_llnunu", "ttz_qq", "ttzz", 
            "wminush_htt", "wplush_htt", 
            "tth_bb", "tth_tautau", "ggH_ZZ", "ggf_sm", 
            # "tth_nonbb", "vbf_htt" # removed
            # the following datasets are directly added below
            # "zh_ztt_hbb_signal", "zh_ztt_hbb_background",
            # "zh_zbb_htt",
            # "zz_sl"
            ]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )

        # ZH datasets
        # ZH_HToBB_ZToTT is split in 2 processes :
        # - zh_ztt_hbb_signal (with filter for bbtautau decay) 
        # - zh_ztt_hbb_background (with inverted filter)
        # ZH_HToTT_ZToBB is considered as background
        # ZZ_SL is considered as background

        p = "/data_CMS/cms/vernazza/FrameworkNanoAOD/HHbbtautau_NanoAODv10/"

        datasets += ObjectCollection([

            ###################################### ZH Signal ##############################################
            ###############################################################################################

            #### ZH_Hbb_Zll
            Dataset("zh_ztt_hbb_signal",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_ztt_hbb_signal"),
                xs=0.052,
                secondary_dataset="zh_ztt_hbb_signal_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_ztt_hbb_signal_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_ztt_hbb_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]), 

            ###################################### ZH Background ##########################################
            ###############################################################################################

            #### ZH_Hbb_Zll
            Dataset("zh_ztt_hbb_background",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_ztt_hbb_background"),
                xs=0.052,
                secondary_dataset="zh_ztt_hbb_background_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_ztt_hbb_background_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_ztt_hbb_background"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),

            #### ZHToTauTau
            Dataset("zh_htt",
                folder=p + "ZHToTauTau",
                process=self.processes.get("zh_htt"),
                xs=0.0554,
                secondary_dataset="zh_htt_aux",
                categorization_max_events=30000,
                tags=["ul", "nanoV10"]),
            Dataset("zh_htt_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8_ext1/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),

            ###################################### ZZ Background ##########################################
            ###############################################################################################
            # ZZ semileptonic (added here since ZZ analysis uses this dataset with genfilter for bbtautau, whilst in ZH we use the full dataset)
            Dataset("zz_sl",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl"),
                xs=5.52,
                secondary_dataset="zz_sl_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul", "secondary"]),

            ###################################### ZH Resonant ############################################
            ###############################################################################################

            #### ZH Resonance high mass

        ])

        return datasets

config = Config_ul_2018_ZH_v10("ul_2018_ZttHbb_v10", year=2018, ecm=13, lumi_pb=59741, isUL=True, AnalysisType="Ztautau_Hbb")