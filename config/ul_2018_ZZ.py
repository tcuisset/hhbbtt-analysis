from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZZ import Config as base_config_ZZ


class Config_ul_2018_ZZ(base_config_ZZ):
    def __init__(self, *args, **kwargs):
        super(Config_ul_2018_ZZ, self).__init__(*args, **kwargs)

    def add_weights(self):
        weights = DotDict()
        weights.default = "1"
        # weights.total_events_weights = ["genWeight", "puWeight", "DYstitchWeight"]
        weights.total_events_weights = ["genWeight", "puWeight"]

        # weights.mutau = ["genWeight", "puWeight", "prescaleWeight", "trigSF",
        #     "idAndIsoAndFakeSF", "L1PreFiringWeight", "PUjetID_SF",
        #     "bTagweightReshape"]

        weights.mutau = ["genWeight", "puWeight", "prescaleWeight", "trigSF",
            "L1PreFiringWeight_Nom", "PUjetID_SF"]
        
        weights.etau = weights.mutau
        weights.tautau = weights.mutau
        weights.base_selection = weights.mutau
        weights.base = weights.mutau
        weights.ZZ_elliptical_cut_80_sr = weights.mutau
        weights.ZZ_elliptical_cut_80_etau = weights.mutau
        weights.ZZ_elliptical_cut_80_mutau = weights.mutau
        weights.ZZ_elliptical_cut_80_tautau = weights.mutau

        # weights.channels_mult = {channel: jrs(weights.channels[channel], op="*")
            # for channel in weights.channels}
        return weights
    
    def add_datasets(self):
        
        # super(Config_ul_2018_ZZ, self).add_datasets() 
        datasets = [

            ######################################## Single boson #########################################
            ###############################################################################################

            # W
            Dataset("wjets",
                dataset="/WJetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wjets"),
                # prefix="xrootd-cms.infn.it//",
                xs=61526.7,
                merging={
                    "tautau": 5,
                    "etau": 10,
                },
                splitting=200000,
                tags=["ul"]),

            # DY
            Dataset("dy_nlo",
                dataset="/DYJetsToLL_M-50_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("dy"),
                # prefix="xrootd-cms.infn.it//",
                # prefix="cms-xrd-global.cern.ch//",
                xs=6077.22,
                merging={
                    "tautau": 20,
                    "etau": 20,
                    "mutau": 20,
                },
                tags=["ul"]),

            # EWK
            Dataset("ewk_z",
                dataset="/EWKZ2Jets_ZToLL_M-50_TuneCP5_PSweights_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ewk_z"),
                # prefix="xrootd-cms.infn.it//",
                xs=3.987,
                splitting=200000,
                tags=["ul"]),
            Dataset("ewk_wplus",
                dataset="/EWKWPlus2Jets_WToLNu_M-50_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ewk_wplus"),
                # prefix="xrootd-cms.infn.it//",
                xs=25.62,
                splitting=200000,
                tags=["ul"]),
            Dataset("ewk_wminus",
                dataset="/EWKWMinus2Jets_WToLNu_M-50_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ewk_wminus"),
                # prefix="xrootd-cms.infn.it//",
                xs=20.25,
                splitting=200000,
                tags=["ul"]),

            ######################################## Top ##################################################
            ###############################################################################################

            # TT
            Dataset("tt_dl",
                dataset="/TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("tt_dl"),
                # prefix="xrootd-cms.infn.it//",
                xs=88.29, 
                merging={
                    "tautau": 20,
                    "mutau": 20,
                    "etau": 40,
                },
                scaling=(0.96639, 0.00863),
                tags=["ul"]),
            Dataset("tt_sl",
                dataset="/TTToSemiLeptonic_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("tt_sl"),
                # prefix="xrootd-cms.infn.it//",
                xs=365.34,
                merging={
                    "tautau": 20,
                    "mutau": 60,
                    "etau": 40,
                },
                scaling=(0.96639, 0.00863),
                tags=["ul"]),
            Dataset("tt_fh",
                dataset="/TTToHadronic_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("tt_fh"),
                # prefix="xrootd-cms.infn.it//",
                xs=377.96,
                scaling=(0.96639, 0.00863),
                tags=["ul"]),

            # TW
            Dataset("st_tw_antitop",
                dataset="/ST_tW_antitop_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("tw"),
                # prefix="xrootd-cms.infn.it//",
                xs=35.85,
                splitting=200000,
                tags=["ul"]),
            Dataset("st_tw_top",
                dataset="/ST_tW_top_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("tw"),
                # prefix="xrootd-cms.infn.it//",
                xs=35.85,
                splitting=200000,
                tags=["ul"]),

            # singleT
            Dataset("st_antitop",
                dataset="/ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("singlet"),
                # prefix="xrootd-cms.infn.it//",
                xs=80.95,
                splitting=200000,
                tags=["ul"]),
            Dataset("st_top",
                dataset="/ST_t-channel_top_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("singlet"),
                # prefix="xrootd-cms.infn.it//",
                xs=136.02,
                splitting=200000,
                tags=["ul"]),

            ######################################## Di- and Tri-boson ####################################
            ###############################################################################################

            # VV
            Dataset("zz_dl",
                dataset="/ZZTo4L_TuneCP5_13TeV_powheg_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=1.26,
                splitting=200000,
                tags=["ul"]),
            Dataset("zz_sl_background",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52,
                splitting=200000,
                tags=["ul"]),
            Dataset("zz_fh",
                dataset="/ZZTo4Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=3.262, #taken from DAS but to be checked
                splitting=200000,
                tags=["ul"]),
            Dataset("zz_lnu",
                dataset="/ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.564,
                splitting=200000,
                tags=["ul"]),
            Dataset("zz_qnu",
                dataset="/ZZTo2Q2Nu_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                # prefix="xrootd-cms.infn.it//",
                xs=4.07,
                splitting=200000,
                tags=["ul"]),
            Dataset("wz_lllnu",
                dataset="/WZTo3LNu_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wz"),
                # prefix="xrootd-cms.infn.it//",
                xs=4.43,
                splitting=200000,
                tags=["ul"]),
            Dataset("wz_lnuqq",
                dataset="/WZTo1L1Nu2Q_13TeV_amcatnloFXFX_madspin_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wz"),
                # prefix="xrootd-cms.infn.it//",
                xs=10.71,
                splitting=200000,
                tags=["ul"]),
            Dataset("wz_llqq",
                dataset="/WZTo2L2Q_13TeV_amcatnloFXFX_madspin_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wz"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.595,
                splitting=200000,
                tags=["ul"]),
            Dataset("ww_llnunu",
                dataset="/WWTo2L2Nu_NNPDF31_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ww"),
                # prefix="xrootd-cms.infn.it//",
                xs=12.178,
                splitting=200000,
                tags=["ul"]),
            Dataset("ww_lnuqq",
                dataset="/WWToLNuQQ_NNPDF31_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ww"),
                # prefix="xrootd-cms.infn.it//",
                xs=49.997,
                splitting=200000,
                tags=["ul"]),
            Dataset("ww_qqqq",
                dataset="/WWTo4Q_NNPDF31_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ww"),
                # prefix="xrootd-cms.infn.it//",
                xs=51.723,
                splitting=200000,
                tags=["ul"]),

            # VVV
            Dataset("zzz",
                dataset="/ZZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zzz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0147,
                splitting=200000,
                tags=["ul"]),
            Dataset("wzz",
                dataset="/WZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wzz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.057,
                splitting=200000,
                tags=["ul"]),
            Dataset("www",
                dataset="/WWW_4F_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("www"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.209,
                splitting=200000,
                tags=["ul"]),
            Dataset("wwz",
                dataset="/WWZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("wwz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.168,
                splitting=200000,
                tags=["ul"]),

            ######################################## Others ###############################################
            ###############################################################################################

            # TTX
            Dataset("ttw_lnu",
                dataset="/TTWJetsToLNu_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttw"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.2043,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttw_qq",
                dataset="/TTWJetsToQQ_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttw"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.4062,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttww",
                dataset="/TTWW_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttww"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.00698,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttwz",
                dataset="/TTWZ_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttwz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.002441,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttwh",
                dataset="/TTWH_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttwh"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.00158,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttzh",
                dataset="/TTZH_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttzh"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.00154,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttz_llnunu",
                dataset="/TTZToLLNuNu_M-10_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.2529,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttz_qq",
                dataset="/TTZToQQ_TuneCP5_13TeV-amcatnlo-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.5297,
                splitting=200000,
                tags=["ul"]),
            Dataset("ttzz",
                dataset="/TTZZ_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ttzz"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.001386,
                splitting=200000,
                tags=["ul"]),

            ######################################## Higgs ###############################################
            ###############################################################################################

            # ZH_hbb
            Dataset("zh_hbb_zll",
                dataset="/ZH_HToBB_ZToLL_M125_13TeV_powheg_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052,
                splitting=200000,
                tags=["ul"]),
            Dataset("zh_hbb_zqq",
                dataset="/ZH_HToBB_ZToQQ_M125_13TeV_powheg_pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.36,
                splitting=200000,
                tags=["ul"]),

            # WH_htt
            # /WplusHToTauTau M125 13TeV powheg pythia8
            # /WminusHToTauTau M125 13TeV powheg pythia8

            # qqH_htt /VBFHToTauTau_M125_13TeV_powheg_pythia8 ?

            # ggH_htt /GluGluHToTauTau_M125_13TeV_powheg_pythia8

            # ttH_hbb
            Dataset("tth_bb",
                dataset="/ttHTobb_M125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("tth_bb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.2953,
                splitting=200000,
                tags=["ul"]),
            # Dataset("tth_tautau",
            #     dataset="/ttHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
            #         "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
            #     process=self.processes.get("tth_tautau"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.031805,
            #     splitting=200000,
            #     tags=["ul"]),
            # Dataset("tth_nonbb",
            #     dataset="/ttHToNonbb_M125_TuneCP5_13TeV-powheg-pythia8/"
            #         "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
            #     process=self.processes.get("tth_nonbb"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.17996,
            #     splitting=200000,
            #     tags=["ul"]),

            ######################################## HH bbtautau ##########################################
            ###############################################################################################

            # ggf 
            Dataset("ggf_sm",
                dataset="/GluGluToHHTo2B2Tau_TuneCP5_PSWeights_node_SM_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("ggf_sm"),
                xs=0.03105,
                tags=["ul"]),
            # # vbf
            # Dataset("vbf_sm",
            #     dataset="/VBFHHTo2B2Tau_CV_1_C2V_1_C3_1_dipoleRecoilOff"
            #     "-TuneCP5_PSweights_13TeV-madgraph-pythia8/"
            #     "RunIIAutumn18NanoAODv7-Nano02Apr2020_102X_upgrade2018_realistic_v21-v1/NANOAODSIM",
            #     process=self.processes.get("vbf_sm"),
            #     # prefix="xrootd-cms.infn.it//",
            #     xs=0.001726),


            ###################################### ZZ Signal ##############################################
            ###############################################################################################
            
            # ZZ Signal
            Dataset("zz_sl_signal",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52,
                splitting=200000,
                tags=["ul"]),

            ######################################## Data #################################################
            ###############################################################################################

            # Tau 2018
            Dataset("data_tau_a",
                dataset="/Tau/Run2018A-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="A",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "tautau": 20,
                },
                tags=["ul"]),
            Dataset("data_tau_b",
                dataset="/Tau/Run2018B-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="B",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "tautau": 20,
                },
                tags=["ul"]),
            Dataset("data_tau_c",
                dataset="/Tau/Run2018C-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="C",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "tautau": 20,
                },
                tags=["ul"]),
            Dataset("data_tau_d",
                dataset="/Tau/Run2018D-UL2018_MiniAODv2_NanoAODv9-v2/NANOAOD",
                selection="pairType == 2",
                process=self.processes.get("data_tau"),
                runPeriod="D",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "tautau": 20,
                    "etau": 40,
                },
                tags=["ul"]),

            # EGamma 2018
            Dataset("data_etau_a",
                dataset="/EGamma/Run2018A-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="A",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "etau": 10,
                },
                tags=["ul"]),
            Dataset("data_etau_b",
                dataset="/EGamma/Run2018B-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="B",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "etau": 10,
                },
                tags=["ul"]),
            Dataset("data_etau_c",
                dataset="/EGamma/Run2018C-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="C",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "etau": 10,
                },
                tags=["ul"]),
            Dataset("data_etau_d",
                dataset="/EGamma/Run2018D-UL2018_MiniAODv2_NanoAODv9-v3/NANOAOD",
                selection="pairType == 1",
                process=self.processes.get("data_etau"),
                runPeriod="D",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "etau": 10,
                },
                tags=["ul"]),

            # SingleMuon 2018
            Dataset("data_mutau_a",
                dataset="/SingleMuon/Run2018A-UL2018_MiniAODv2_NanoAODv9-v2/NANOAOD",
                selection="pairType == 0",
                process=self.processes.get("data_mutau"),
                runPeriod="A",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "mutau": 20,
                },
                tags=["ul"]),
            Dataset("data_mutau_b",
                dataset="/SingleMuon/Run2018B-UL2018_MiniAODv2_NanoAODv9-v2/NANOAOD",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="B",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "mutau": 20,
                },
                tags=["ul"]),
            Dataset("data_mutau_c",
                dataset="/SingleMuon/Run2018C-UL2018_MiniAODv2_NanoAODv9-v2/NANOAOD",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="C",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "mutau": 20,
                },
                tags=["ul"]),
            Dataset("data_mutau_d",
                dataset="/SingleMuon/Run2018D-UL2018_MiniAODv2_NanoAODv9-v1/NANOAOD",
                process=self.processes.get("data_mutau"),
                selection="pairType == 0",
                runPeriod="D",
                # prefix="xrootd-cms.infn.it//",
                splitting=-1,
                merging={
                    "mutau": 20,
                },
                tags=["ul"]),

        ]
        return ObjectCollection(datasets)

config = Config_ul_2018_ZZ("ul_2018", year=2018, ecm=13, lumi_pb=59741, isUL=True)