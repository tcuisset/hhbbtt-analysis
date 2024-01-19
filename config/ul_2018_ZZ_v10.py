from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZZ import Config as base_config_ZZ
from config.ul_2018_v9 import get_2018_weights, get_common_datasets_v9
from config.ul_2018_v10 import setupBtagDeeptau, get_common_datasets_v10

class Config_ul_2018_v10(base_config_ZZ):
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
    
    def get_datasets_v9(self):
        """ Computes v9 datasets. You need to add _aux to the end of the returned datasets names"""
        datasets = get_common_datasets_v9(self)

        datasets += ObjectCollection([
            Dataset("zz_sl_background",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul"]),
            

            ###################################### ZZ Signal ##############################################
            ###############################################################################################
            
            # ZZ Signal
            Dataset("zz_sl_signal",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul"]),
            Dataset("zz_bbtt",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_bbtt"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                splitting=200000,
                tags=["ul"]),
            
            ######################################## Higgs ###############################################
            ###############################################################################################      

            # ZH_hbb
            Dataset("zh_hbb_zll",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                splitting=200000,
                tags=["ul"]),
            # Dataset("zh_hbb_zqq",
            #     dataset="/ZH_HToBB_ZToQQ_M-125_TuneCP5_13TeV-powheg-pythia8/"
            #         "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
            #     process=self.processes.get("zh_hbb"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.36, # AN
            #     # xs=0.5612, # XSDB NLO
            #     splitting=200000,
            #     tags=["ul"]),

            # ZH_htt
            Dataset("zh_htt",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8_ext1/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul"]),   
                
        ])

        return datasets
    
    def add_datasets(self):
        v9_datasets = self.get_datasets_v9()
        datasets = get_common_datasets_v10(self)

        p = "/data_CMS/cms/vernazza/FrameworkNanoAOD/HHbbtautau_NanoAODv10/"
        datasets += ObjectCollection([
            Dataset("zz_sl_background", # ZZ semileptonic that will be gen-filtered to remove ZZ->bbtautau events
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_background"),
                xs=5.52,
                secondary_dataset="zz_sl_background_aux",
                tags=["ul", "nanoV10"]),
            

            ###################################### ZZ Signal ##############################################
            ###############################################################################################

            # ZZ Signal
            Dataset("zz_sl_signal",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=5.52,
                secondary_dataset="zz_sl_signal_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_bbtt", # background for ZZ resonant analysis
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_bbtt"),
                xs=5.52,
                secondary_dataset="zz_bbtt_aux",
                tags=["ul", "nanoV10"]),

            Dataset("zz_sl_signal_test",
                folder="/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2018/ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=5.52,
                secondary_dataset="zz_sl_signal_aux",
                tags=["ul", "nanoV10"]),
            


            ###################################### X ZZ 2L2Q ##############################################
            ###############################################################################################

            # ZZ Resonance high mass
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
            
            ######################################## Higgs ###############################################
            ###############################################################################################      
            # ZH_hbb
            Dataset("zh_hbb_zll",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_hbb"),
                xs=0.052,
                secondary_dataset="zh_hbb_zll_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zh_hbb_zqq",
                folder=p + "ZH_Hbb_Zqq",
                process=self.processes.get("zh_hbb"),
                xs=0.36,
                secondary_dataset="zh_hbb_zqq_aux",
                tags=["ul", "nanoV10"]),
            # ZH_htt
            Dataset("zh_htt",
                folder=p + "ZHToTauTau",
                process=self.processes.get("zh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554,
                secondary_dataset="zh_htt_aux",
                tags=["ul", "nanoV10"]),    

        ])

        for name in [
            "wjets", "dy", "ewk_z", "ewk_wplus", "ewk_wminus", "tt_dl", "tt_sl", "tt_fh",
            "st_tw_antitop", "st_tw_top", "st_antitop", "st_top",
            "zz_dl", "zz_sl_background", "zz_fh", "zz_lnu", "zz_qnu",
            "wz_lllnu", "wz_lnuqq", "wz_lnununu", "wz_llqq", "ww_llnunu", "ww_lnuqq", "ww_qqqq",
            "zzz", "wzz", "www", "wwz", 
            "ttw_lnu", "ttw_qq", "ttww", "ttwz", "ttwh", "ttzh", "ttz_llnunu", "ttz_qq", "ttzz", 
            "zh_hbb_zll", "zh_htt", "wminush_htt", "wplush_htt", "vbf_htt", 
            "tth_bb", "tth_nonbb", "tth_tautau", "ggH_ZZ", "ggf_sm", "zz_sl_signal", "zz_bbtt"]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )

        return datasets

    # if I don't want to specify the version every time
    # def add_version(self):
    #     versions = {
    #         "MergeCategorizationStats": "prod_503"
    #     }
    #     return versions

config = Config_ul_2018_v10("ul_2018_v10", year=2018, ecm=13, lumi_pb=59741, isUL=True)
