from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZZ import Config as base_config_ZZ
from config.ul_2018_v9 import get_common_datasets_v9
from config.ul_2018_v12 import setupBtagDeeptau, get_common_datasets_v12, get_2018_v12_weights 

class Config_ul_2018_ZZ_v12(base_config_ZZ):
    def __init__(self, *args, **kwargs):
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_v12_weights()
        weights.ZZ_elliptical_cut_90 = weights.mutau
        weights.ZZ_elliptical_cut_90_sr = weights.mutau
        weights.ZZ_elliptical_cut_90_etau = weights.mutau
        weights.ZZ_elliptical_cut_90_mutau = weights.mutau
        weights.ZZ_elliptical_cut_90_tautau = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_etau = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_mutau = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_tautau = weights.mutau
        weights.ZZ_elliptical_cut_80_CR_etau = weights.mutau
        weights.ZZ_elliptical_cut_90_resolved_1b = weights.mutau
        weights.ZZ_elliptical_cut_90_resolved_2b = weights.mutau
        weights.ZZ_elliptical_cut_90_boosted_noPNet = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_resolved_1b = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_resolved_2b = weights.mutau
        weights.ZZ_elliptical_cut_90_CR_boosted_noPNet = weights.mutau
        weights.ZZ_elliptical_cut_90_CR = weights.mutau

        return weights

    #@override
    def add_datasets(self):
        v9_datasets = get_common_datasets_v9(self)
        datasets = get_common_datasets_v12(self)

        for name in [
            # "wjets_FXFX", "wjets_FXFX_0j", "wjets_FXFX_1j", "wjets_FXFX_2j", 
            "wjets_MLM", 
            # "wjets_MLM_1j", "wjets_MLM_2j", "wjets_MLM_3j", "wjets_MLM_4j", 
            # "wjets_ht1", # actually not used since we normalize wjets_ht1 to inclusive directly
            "wjets_ht2", "wjets_ht3", "wjets_ht4", "wjets_ht5", "wjets_ht6", "wjets_ht7", "wjets_ht8",
            "dy", "dy_ptz1", "dy_ptz2", "dy_ptz3", "dy_ptz4", "dy_ptz5", "dy_ptz6", "dy_0j", "dy_1j", "dy_2j", 
            "ewk_z", "ewk_wplus", "ewk_wminus", "tt_dl", "tt_sl", "tt_fh",
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
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"],
                    # The get_aux properties are dropped in the copy, so we need to explicitly keep those we need
                    # We don't actually use the selection for aux datasets (PreCounter does not apply it) so the next line is not really useful, just as a reminder
                    selection=v9_datasets.get(name).get_aux("selection", None),
                    setGenWeightToOne=v9_datasets.get(name).get_aux("setGenWeightToOne", None)
                )
            )

        # ZZ datasets
        # ZZ_SL is split in 2 processes :
        # - zz_sl_signal (with filter for bbtautau decay) 
        # - zz_sl_background (with inverted filter)
        # ZHToTauTau is considered as background
        # ZH_Hbb_Zll is considered as background

        p = "/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2018/"
        datasets += ObjectCollection([

            ###################################### ZZ Signal ##############################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_signal",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=self.cross_section_dict["zz_sl"],
                secondary_dataset="zz_sl_signal_aux",
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_signal_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl_signal"),
                xs=self.cross_section_dict["zz_sl"],
                tags=["ul", "secondary"]),

            ###################################### ZZ Background ##########################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_background",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_background"),
                xs=self.cross_section_dict["zz_sl"],
                secondary_dataset="zz_sl_background_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_background_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz"),
                xs=self.cross_section_dict["zz_sl"],
                tags=["ul", "secondary"]),
            
            #### ZHToTauTau
            Dataset("zh_htt",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_htt"),
                xs=self.cross_section_dict["zh_htt"],
                secondary_dataset="zh_htt_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]), 
            Dataset("zh_htt_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_htt"),
                xs=self.cross_section_dict["zh_htt"],
                tags=["ul", "secondary"]),

            #### ZH_Hbb_Zll
            Dataset("zh_hbb_zll",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_hbb"),
                xs=self.cross_section_dict["zh_hbb_zll"],
                secondary_dataset="zh_hbb_zll_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zh_hbb_zll_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                xs=self.cross_section_dict["zh_hbb_zll"],
                tags=["ul", "secondary"]),

            #### ZZ_SL but considered as background for the resonant analysis
            Dataset("zz_bbtt",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_bbtt"),
                xs=self.cross_section_dict["zz_sl"],
                secondary_dataset="zz_bbtt_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10", "res"]),
            Dataset("zz_bbtt_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_bbtt"),
                xs=self.cross_section_dict["zz_sl"],
                tags=["ul", "secondary", "res"]),

            ###################################### ZZ Resonant ############################################
            ###############################################################################################

            #### ZZ Resonance high mass

            Dataset("GluGluToXToZZTo2B2Tau_M200",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-200/",
                process=self.processes.get("ggXZZbbtt_M200"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M200_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M200_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-200_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M200"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M210",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-210/",
                process=self.processes.get("ggXZZbbtt_M210"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M210_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M210_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-210_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M210"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M220",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-220/",
                process=self.processes.get("ggXZZbbtt_M220"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M220_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M220_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-220_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M220"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M230",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-230/",
                process=self.processes.get("ggXZZbbtt_M230"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M230_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M230_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-230_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M230"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M240",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-240/",
                process=self.processes.get("ggXZZbbtt_M240"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M240_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M240_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-240_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M240"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M250",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-250/",
                process=self.processes.get("ggXZZbbtt_M250"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M250_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M250_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-250_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M250"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M260",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-260/",
                process=self.processes.get("ggXZZbbtt_M260"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M260_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M260_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-260_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M260"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M270",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-270/",
                process=self.processes.get("ggXZZbbtt_M270"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M270_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M270_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-270_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M270"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M280",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-280/",
                process=self.processes.get("ggXZZbbtt_M280"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M280_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M280_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-280_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M280"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M300",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-300/",
                process=self.processes.get("ggXZZbbtt_M300"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M300_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M300_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-300_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M300"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M320",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-320/",
                process=self.processes.get("ggXZZbbtt_M320"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M320_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M320_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-320_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M320"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M350",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-350/",
                process=self.processes.get("ggXZZbbtt_M350"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M350_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M350_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-350_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M350"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M360",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-360/",
                process=self.processes.get("ggXZZbbtt_M360"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M360_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M360_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-360_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M360"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M400",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-400/",
                process=self.processes.get("ggXZZbbtt_M400"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M400_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M400_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-400_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M400"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M450",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-450/",
                process=self.processes.get("ggXZZbbtt_M450"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M450_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M450_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-450_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M450"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-500/",
                process=self.processes.get("ggXZZbbtt_M500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M500_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-500_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M550",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-550/",
                process=self.processes.get("ggXZZbbtt_M550"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M550_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M550_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-550_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M550"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M600",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-600/",
                process=self.processes.get("ggXZZbbtt_M600"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M600_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M600_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-600_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M600"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M650",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-650/",
                process=self.processes.get("ggXZZbbtt_M650"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M650_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M650_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-650_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M650"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M700",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-700/",
                process=self.processes.get("ggXZZbbtt_M700"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M700_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M700_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-700_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M700"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M750",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-750/",
                process=self.processes.get("ggXZZbbtt_M750"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M750_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M750_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-750_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M750"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M800",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-800/",
                process=self.processes.get("ggXZZbbtt_M800"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M800_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M800_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-800_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M800"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M850",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-850/",
                process=self.processes.get("ggXZZbbtt_M850"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M850_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M850_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-850_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M850"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M900",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-900/",
                process=self.processes.get("ggXZZbbtt_M900"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M900_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M900_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-900_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M900"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1000/",
                process=self.processes.get("ggXZZbbtt_M1000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1000_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1000_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1100",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1100/",
                process=self.processes.get("ggXZZbbtt_M1100"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1100_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1100_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1100_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1100"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1200",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1200/",
                process=self.processes.get("ggXZZbbtt_M1200"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1200_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1200_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1200_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1200"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1300",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1300/",
                process=self.processes.get("ggXZZbbtt_M1300"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1300_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1300_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1300_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1300"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1400",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1400/",
                process=self.processes.get("ggXZZbbtt_M1400"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1400_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1400_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1400_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1400"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1500/",
                process=self.processes.get("ggXZZbbtt_M1500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1500_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1500_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1600",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1600/",
                process=self.processes.get("ggXZZbbtt_M1600"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1600_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1600_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1600_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1600"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1700",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1700/",
                process=self.processes.get("ggXZZbbtt_M1700"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1700_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1700_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1700_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1700"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1800",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1800/",
                process=self.processes.get("ggXZZbbtt_M1800"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1800_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1800_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1800_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1800"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M1900",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-1900/",
                process=self.processes.get("ggXZZbbtt_M1900"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M1900_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M1900_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-1900_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M1900"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2000/",
                process=self.processes.get("ggXZZbbtt_M2000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2000_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2000_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2200",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2200/",
                process=self.processes.get("ggXZZbbtt_M2200"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2200_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2200_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2200_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2200"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2400",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2400/",
                process=self.processes.get("ggXZZbbtt_M2400"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2400_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2400_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2400_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2400"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2500/",
                process=self.processes.get("ggXZZbbtt_M2500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2500_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2500_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2600",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2600/",
                process=self.processes.get("ggXZZbbtt_M2600"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2600_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2600_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2600_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2600"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M2800",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-2800/",
                process=self.processes.get("ggXZZbbtt_M2800"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M2800_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M2800_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-2800_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M2800"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M3000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-3000/",
                process=self.processes.get("ggXZZbbtt_M3000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M3000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M3000_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-3000_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M3000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M3500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-3500/",
                process=self.processes.get("ggXZZbbtt_M3500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M3500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M3500_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-3500_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M3500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M4000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-4000/",
                process=self.processes.get("ggXZZbbtt_M4000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M4000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M4000_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-4000_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M4000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M4500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-4500/",
                process=self.processes.get("ggXZZbbtt_M4500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M4500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M4500_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-4500_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M4500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("GluGluToXToZZTo2B2Tau_M5000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-5000/",
                process=self.processes.get("ggXZZbbtt_M5000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="GluGluToXToZZTo2B2Tau_M5000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("GluGluToXToZZTo2B2Tau_M5000_aux",
                dataset="/GluGluToXToZZTo2B2Tau_M-5000_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("ggXZZbbtt_M5000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            # Old datasets ULv9 produced privately
            
            # Dataset("ggXZZbbtt_M200",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M200/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M200"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M300",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M300/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M300"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M400",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M400/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M400"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M500",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M500/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M500"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M600",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M600/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M600"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M700",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M700/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M700"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M800",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M800/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M800"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M900",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M900/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M900"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1000",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1000/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1000"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1100",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1100/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1100"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1200",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1200/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1200"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1300",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1300/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1300"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1400",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1400/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1400"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M1500",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M1500/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M1500"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M2000",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M2000/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M2000"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
            # Dataset("ggXZZbbtt_M3000",
            #     folder="/data_CMS/cms/vernazza/MCProduction/2023_11_14/MyPrivateGridpacks/"
            #         "gg_X_ZZbbtautau_M3000/Step_4",
            #     process=self.processes.get("ggXZZbbtt_M3000"),
            #     xs=1,
            #     tags=["ul", "res", "tmp"]),
        ])
            
        return datasets

    # if I don't want to specify the version every time
    # def add_version(self):
    #     versions = {"MergeCategorizationStats": "prod_503"}
    #     return versions

config = Config_ul_2018_ZZ_v12("ul_2018_ZZ_v12", year=2018, ecm=13, lumi_pb=59741, isUL=True, AnalysisType="Zbb_Ztautau")
