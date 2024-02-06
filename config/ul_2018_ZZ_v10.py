from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZZ import Config as base_config_ZZ
from config.ul_2018_v9 import get_2018_weights, get_common_datasets_v9
from config.ul_2018_v10 import setupBtagDeeptau, get_common_datasets_v10

class Config_ul_2018_ZZ_v10(base_config_ZZ):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_weights()
        weights.ZZ_elliptical_cut_80_sr = weights.mutau
        weights.ZZ_elliptical_cut_80_etau = weights.mutau
        weights.ZZ_elliptical_cut_80_mutau = weights.mutau
        weights.ZZ_elliptical_cut_80_tautau = weights.mutau

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
            # "zz_sl_signal", "zz_sl_background",
            # "zh_htt", "zh_hbb_zll",
            # "zz_bbtt"
            ]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )

        # ZZ datasets
        # ZZ_SL is split in 2 processes :
        # - zz_sl_signal (with filter for bbtautau decay) 
        # - zz_sl_background (with inverted filter)
        # ZHToTauTau is considered as background
        # ZH_Hbb_Zll is considered as background

        p = "/data_CMS/cms/vernazza/FrameworkNanoAOD/HHbbtautau_NanoAODv10/"
        datasets += ObjectCollection([

            ###################################### ZZ Signal ##############################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_signal",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=5.52,
                secondary_dataset="zz_sl_signal_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_signal_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul", "secondary"]),

            ###################################### ZZ Background ##########################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_background",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_background"),
                xs=5.52,
                secondary_dataset="zz_sl_background_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_background_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
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

            #### ZH_Hbb_Zll
            Dataset("zh_hbb_zll",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_hbb"),
                xs=0.052,
                secondary_dataset="zh_hbb_zll_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_hbb_zll_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),

            #### ZZ_SL but considered as background for the resonant analysis
            Dataset("zz_bbtt",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_bbtt"),
                xs=5.52,
                secondary_dataset="zz_bbtt_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_bbtt_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_bbtt"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul", "secondary"]),

            ###################################### ZZ Resonant ############################################
            ###############################################################################################

            #### ZZ Resonance high mass
            Dataset("ggXZZbbtt_M200",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M200/Step_4",
                process=self.processes.get("ggXZZbbtt_M200"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M300",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M300/Step_4",
                process=self.processes.get("ggXZZbbtt_M300"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M400",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M400/Step_4",
                process=self.processes.get("ggXZZbbtt_M400"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M500",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M500/Step_4",
                process=self.processes.get("ggXZZbbtt_M500"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M600",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M600/Step_4",
                process=self.processes.get("ggXZZbbtt_M600"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M700",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M700/Step_4",
                process=self.processes.get("ggXZZbbtt_M700"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M800",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M800/Step_4",
                process=self.processes.get("ggXZZbbtt_M800"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M900",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M900/Step_4",
                process=self.processes.get("ggXZZbbtt_M900"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1000",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1000/Step_4",
                process=self.processes.get("ggXZZbbtt_M1000"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1100",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1100/Step_4",
                process=self.processes.get("ggXZZbbtt_M1100"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1200",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1200/Step_4",
                process=self.processes.get("ggXZZbbtt_M1200"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1300",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1300/Step_4",
                process=self.processes.get("ggXZZbbtt_M1300"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1400",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1400/Step_4",
                process=self.processes.get("ggXZZbbtt_M1400"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1500",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M1500/Step_4",
                process=self.processes.get("ggXZZbbtt_M1500"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M2000",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M2000/Step_4",
                process=self.processes.get("ggXZZbbtt_M2000"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M3000",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
                    "gg_X_ZZbbtautau_M3000/Step_4",
                process=self.processes.get("ggXZZbbtt_M3000"),
                xs=1,
                tags=["ul", "nanoV10"]),

            ###################################### Other ##################################################
            ###############################################################################################

            #### Test ULv12
            # Dataset("zz_sl_signal_test",
            #     folder="/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2018/ZZTo2Q2L",
            #     process=self.processes.get("zz_sl_signal"),
            #     xs=5.52,
            #     secondary_dataset="zz_sl_signal_aux",
            #     tags=["ul", "nanoV10"]),

        ])
            
        return datasets

    # if I don't want to specify the version every time
    # def add_version(self):
    #     versions = {"MergeCategorizationStats": "prod_503"}
    #     return versions

config = Config_ul_2018_ZZ_v10("ul_2018_ZZ_v10", year=2018, ecm=13, lumi_pb=59741, isUL=True, AnalysisType="Zbb_Ztautau")
