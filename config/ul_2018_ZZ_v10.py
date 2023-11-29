from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2018_ZZ import Config_ul_2018_ZZ as Config_ul_2018_ZZ_v9


class Config_ul_2018_v10(Config_ul_2018_ZZ_v9):
    def __init__(self, *args, **kwargs):
        super(Config_ul_2018_v10, self).__init__(*args, **kwargs)
        self.deeptau=DotDict(
            vsjet=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vse=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vsmu=DotDict(VLoose=1, Loose=1, Medium=3, Tight=4),
        )
        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_datasets(self):
        # p = "/eos/home-k/kandroso/cms-hh-bbtautau/nanoAOD/Run2_2018/"
        p = "/data_CMS/cms/vernazza/FrameworkNanoAOD/HHbbtautau_NanoAODv10/"
        v9_datasets = super(Config_ul_2018_v10, self).add_datasets()
        datasets = [
            
            ######################################## Single boson #########################################
            ###############################################################################################

            # W
            Dataset("wjets",
                folder=p + "WJetsToLNu",
                process=self.processes.get("wjets"),
                selection="event != 198018547",
                xs=61526.7,
                merging={
                    "tautau": 2,
                    "etau": 2,
                },
                splitting=200000,
                secondary_dataset="wjets_aux",
                tags=["ul", "nanoV10"]),

            # DY
            Dataset("dy",
                folder=p + "DYJetsToLL_M-50",
                process=self.processes.get("dy"),
                xs=6077.22,
                merging={
                    "tautau": 10,
                    "etau": 10,
                    "mutau": 10,
                },
                secondary_dataset="dy_aux",
                tags=["ul", "nanoV10"]),

            # EWK
            Dataset("ewk_z",
                folder=p + "EWKZ2Jets_ZToLL_M-50",
                process=self.processes.get("ewk_z"),
                xs=6.215,
                splitting=200000,
                secondary_dataset="ewk_z_aux",
                tags=["ul"]),
            Dataset("ewk_wplus",
                folder=p + "EWKWPlus2Jets_WToLNu_M-50",
                process=self.processes.get("ewk_wplus"),
                xs=39.05,
                splitting=200000,
                secondary_dataset="ewk_wplus_aux",
                tags=["ul"]),
            Dataset("ewk_wminus",
                folder=p + "EWKWMinus2Jets_WToLNu_M-50",
                process=self.processes.get("ewk_wminus"),
                xs=32.05,
                splitting=200000,
                secondary_dataset="ewk_wminus_aux",
                tags=["ul"]),

            ######################################## Top ##################################################
            ###############################################################################################

            # TT
            Dataset("tt_dl",
                folder=p + "TTTo2L2Nu",
                process=self.processes.get("tt_dl"),
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
                folder=p + "TTToHadronic",
                process=self.processes.get("tt_fh"),
                xs=377.96,
                scaling=(0.96639, 0.00863),
                secondary_dataset="tt_fh_aux",
                tags=["ul", "nanoV10"]),

            # TW
            Dataset("st_tw_antitop",
                folder=p + "ST_tW_antitop_5f_inclusiveDecays",
                process=self.processes.get("tw"),
                xs=35.85,
                secondary_dataset="st_tw_antitop_aux",
                tags=["ul", "nanoV10"]),
            Dataset("st_tw_top",
                folder=p + "ST_tW_top_5f_inclusiveDecays",
                process=self.processes.get("tw"),
                xs=35.85,
                secondary_dataset="st_tw_top_aux",
                tags=["ul", "nanoV10"]),

            # singleT
            Dataset("st_antitop",
                folder=p + "ST_t-channel_antitop_4f_InclusiveDecays",
                process=self.processes.get("singlet"),
                xs=80.95,
                secondary_dataset="st_antitop_aux",
                tags=["ul", "nanoV10"]),
            Dataset("st_top",
                folder=p + "ST_t-channel_top_4f_InclusiveDecays",
                process=self.processes.get("singlet"),
                xs=136.02,
                secondary_dataset="st_top_aux",
                tags=["ul", "nanoV10"]),

            ######################################## Di- and Tri-boson ####################################
            ###############################################################################################

            # VV
            Dataset("zz_dl",
                folder=p + "ZZTo4L",
                process=self.processes.get("zz"),
                xs=1.26,
                secondary_dataset="zz_dl_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_background",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz"),
                xs=5.52,
                secondary_dataset="zz_sl_background_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_fh",
                folder=p + "ZZTo4Q",
                process=self.processes.get("zz"),
                xs=3.262,
                secondary_dataset="zz_fh_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_lnu",
                folder=p + "ZZTo2L2Nu",
                process=self.processes.get("zz"),
                xs=0.564,
                secondary_dataset="zz_lnu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("zz_qnu",
                folder=p + "ZZTo2Q2Nu",
                process=self.processes.get("zz"),
                xs=4.07,
                secondary_dataset="zz_qnu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wz_lllnu",
                folder=p + "WZTo3LNu",
                process=self.processes.get("wz"),
                xs=4.43,
                secondary_dataset="wz_lllnu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wz_lnuqq",
                folder=p + "WZTo1L1Nu2Q",
                process=self.processes.get("wz"),
                xs=10.71,
                secondary_dataset="wz_lnuqq_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wz_lnununu",
                folder=p + "WZTo1L3Nu",
                process=self.processes.get("wz"),
                xs=3.414,
                secondary_dataset="wz_lnununu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wz_llqq",
                folder=p + "WZTo2Q2L",
                process=self.processes.get("wz"),
                xs=5.595,
                secondary_dataset="wz_llqq_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ww_llnunu",
                folder=p + "WWTo2L2Nu",
                process=self.processes.get("ww"),
                xs=12.178,
                secondary_dataset="ww_llnunu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ww_lnuqq",
                folder=p + "WWTo1L1Nu2Q",
                process=self.processes.get("ww"),
                xs=49.997,
                secondary_dataset="ww_lnuqq_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ww_qqqq",
                folder=p + "WWTo4Q",
                process=self.processes.get("ww"),
                xs=51.723,
                secondary_dataset="ww_qqqq_aux",
                tags=["ul", "nanoV10"]),

            # VVV
            Dataset("zzz",
                folder=p + "ZZZ",
                process=self.processes.get("zzz"),
                xs=0.0147,
                secondary_dataset="zzz_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wzz",
                folder=p + "WZZ",
                process=self.processes.get("wzz"),
                xs=0.057,
                secondary_dataset="wzz_aux",
                tags=["ul", "nanoV10"]),
            Dataset("www",
                folder=p + "WWW",
                process=self.processes.get("www"),
                xs=0.209,
                secondary_dataset="www_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wwz",
                folder=p + "WWZ",
                process=self.processes.get("wwz"),
                xs=0.168,
                secondary_dataset="wwz_aux",
                tags=["ul", "nanoV10"]),

            ######################################## Others ###############################################
            ###############################################################################################

            # TTX
            Dataset("ttw_lnu",
                folder=p + "TTWJetsToLNu",
                process=self.processes.get("ttw"),
                xs=0.2043,
                secondary_dataset="ttw_lnu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttw_qq",
                folder=p + "TTWJetsToQQ",
                process=self.processes.get("ttw"),
                xs=0.4062,
                secondary_dataset="ttw_qq_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttww",
                folder=p + "TTWW",
                process=self.processes.get("ttww"),
                xs=0.00698,
                secondary_dataset="ttww_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttwz",
                folder=p + "TTWZ",
                process=self.processes.get("ttwz"),
                xs=0.002441,
                secondary_dataset="ttwz_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttwh",
                folder=p + "TTWH",
                process=self.processes.get("ttwh"),
                xs=0.00158,
                secondary_dataset="ttwh_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttzh",
                folder=p + "TTZH",
                process=self.processes.get("ttzh"),
                xs=0.00154,
                secondary_dataset="ttzh_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttz_llnunu",
                folder=p + "TTZToLLNuNu_M-10",
                process=self.processes.get("ttz"),
                xs=0.2529,
                secondary_dataset="ttz_llnunu_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttz_qq",
                folder=p + "TTZToQQ",
                process=self.processes.get("ttz"),
                xs=0.5297,
                secondary_dataset="ttz_qq_aux",
                tags=["ul", "nanoV10"]),
            Dataset("ttzz",
                folder=p + "TTZZ",
                process=self.processes.get("ttzz"),
                xs=0.001386,
                secondary_dataset="ttzz_aux",
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

            # WH_htt
            Dataset("wminush_htt",
                folder=p + "WminusHToTauTau",
                process=self.processes.get("wh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0334,
                secondary_dataset="wminush_htt_aux",
                tags=["ul", "nanoV10"]),
            Dataset("wplush_htt",
                folder=p + "WplusHToTauTau",
                process=self.processes.get("wh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.05268,
                secondary_dataset="wminush_htt_aux",
                tags=["ul", "nanoV10"]),    

            # vbf_htt (not in the datacard)
            Dataset("vbf_htt",
                folder=p + "VBFHToTauTau",
                process=self.processes.get("vbf_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.237,
                secondary_dataset="vbf_htt_aux",
                tags=["ul", "nanoV10"]),

            # ttH_hbb
            Dataset("tth_bb",
                folder=p + "ttHTobb",
                process=self.processes.get("tth_bb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.2953,
                secondary_dataset="tth_bb_aux",
                tags=["ul", "nanoV10"]),
            # ttH_htt (not in the datacard)
            Dataset("tth_tautau",
                folder=p + "ttHToTauTau",
                process=self.processes.get("tth_tautau"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.031805,
                secondary_dataset="tth_tautau_aux",
                tags=["ul", "nanoV10"]),
            # ttH_hnonbb (not in the datacard) 
            Dataset("tth_nonbb",
                folder=p + "ttHToNonbb",
                process=self.processes.get("tth_nonbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.17996,
                secondary_dataset="tth_nonbb_aux",
                tags=["ul", "nanoV10"]),

            # ggH_ZZ
            Dataset("ggH_ZZ",
                folder=p + "ggHToZZTo2L2Q",
                process=self.processes.get("ggH_ZZ"),
                # prefix="xrootd-cms.infn.it//",
                xs=28.87, # XSDB NLO
                secondary_dataset="ggH_ZZ_aux",
                tags=["ul", "nanoV10"]),

            ######################################## HH bbtautau ##########################################
            ###############################################################################################

            # ggf
            Dataset("ggf_sm",
                folder=p + "GluGluToHHTo2B2Tau_node_SM",
                process=self.processes.get("ggf_sm"),
                xs=0.002268,
                secondary_dataset="ggf_sm_aux",
                tags=["ul", "nanoV10"]),
            # # vbf
            # Dataset("vbf_sm",
            #     dataset="",
            #     process=self.processes.get("vbf_sm"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.001726,
            #     secondary_dataset="vbf_sm_aux",
            #     tags=["ul", "nanoV10"]),

            ###################################### ZZ Signal ##############################################
            ###############################################################################################

            # ZZ Signal
            Dataset("zz_sl_signal",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=5.52,
                secondary_dataset="zz_sl_signal_aux",
                tags=["ul", "nanoV10"]),

            ###################################### X ZZ 2L2Q ##############################################
            ###############################################################################################

            # ZZ Resonance high mass
            Dataset("ggXZZbbtt_M200",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M200/Step_4",
                process=self.processes.get("ggXZZbbtt_M200"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M300",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M300/Step_4",
                process=self.processes.get("ggXZZbbtt_M300"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M400",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M400/Step_4",
                process=self.processes.get("ggXZZbbtt_M400"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M500",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M500/Step_4",
                process=self.processes.get("ggXZZbbtt_M500"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M600",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M600/Step_4",
                process=self.processes.get("ggXZZbbtt_M600"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M700",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M700/Step_4",
                process=self.processes.get("ggXZZbbtt_M700"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M800",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M800/Step_4",
                process=self.processes.get("ggXZZbbtt_M800"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M900",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M900/Step_4",
                process=self.processes.get("ggXZZbbtt_M900"),
                xs=1,
                tags=["ul", "nanoV10"]),
            Dataset("ggXZZbbtt_M1000",
                folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/OutputSamples/"
                    "gg_X_ZZbbtautau_M1000/Step_4",
                process=self.processes.get("ggXZZbbtt_M1000"),
                xs=1,
                tags=["ul", "nanoV10"]),

            ######################################## Data #################################################
            ###############################################################################################

            # Tau 2018
            Dataset("data_tau_a",
                folder=p + "Tau_2018A",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="A",
                splitting=-1,
                merging={
                    "tautau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_tau_b",
                folder=p + "Tau_2018B",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="B",
                splitting=-1,
                merging={
                    "tautau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_tau_c",
                folder=p + "Tau_2018C",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="C",
                splitting=-1,
                merging={
                    "tautau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_tau_d",
                folder=p + "Tau_2018D",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="D",
                splitting=-1,
                merging={
                    "tautau": 2,
                },
                tags=["ul", "nanoV10"]),

            # EGamma 2018
            Dataset("data_etau_a",
                folder=p + "EGamma_2018A",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="A",
                splitting=-1,
                merging={
                    "etau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_etau_b",
                folder=p + "EGamma_2018B",
                process=self.processes.get("data_etau"),
                runPeriod="B",
                splitting=-1,
                merging={
                    "etau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_etau_c",
                folder=p + "EGamma_2018C",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="C",
                splitting=-1,
                merging={
                    "etau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_etau_d",
                folder=p + "EGamma_2018D",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="D",
                splitting=-1,
                merging={
                    "etau": 2,
                },
                tags=["ul", "nanoV10"]),

            # SingleMuon 2018
            Dataset("data_mutau_a",
                folder=p + "SingleMuon_2018A",
                selection="pairType == 0",
                process=self.processes.get("data_mutau"),
                runPeriod="A",
                splitting=-1,
                merging={
                    "mutau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_mutau_b",
                folder=p + "SingleMuon_2018B",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="B",
                splitting=-1,
                merging={
                    "mutau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_mutau_c",
                folder=p + "SingleMuon_2018C",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="C",
                splitting=-1,
                merging={
                    "mutau": 2,
                },
                tags=["ul", "nanoV10"]),
            Dataset("data_mutau_d",
                folder=p + "SingleMuon_2018D",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="D",
                splitting=-1,
                merging={
                    "mutau": 2,
                },
                tags=["ul", "nanoV10"]),
                
        ]
        datasets = ObjectCollection(datasets)

        for name in [
                "wjets", "dy", "ewk_z", "ewk_wplus", "ewk_wminus", "tt_dl", "tt_sl", "tt_fh",
                "st_tw_antitop", "st_tw_top", "st_antitop", "st_top",
                "zz_dl", "zz_sl_background", "zz_fh", "zz_lnu", "zz_qnu",
                "wz_lllnu", "wz_lnuqq", "wz_lnununu", "wz_llqq", "ww_llnunu", "ww_lnuqq", "ww_qqqq",
                "zzz", "wzz", "www", "wwz", 
                "ttw_lnu", "ttw_qq", "ttww", "ttwz", "ttwh", "ttzh", "ttz_llnunu", "ttz_qq", "ttzz", 
                "zh_hbb_zll", "zh_htt", "wminush_htt", "wplush_htt", "vbf_htt", 
                "tth_bb", "tth_nonbb", "tth_tautau", "ggH_ZZ", "ggf_sm", "zz_sl_signal"]:
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
