from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZttHbb import ConfigZttHbb as base_config_ZttHbb
from config.ul_2018_v9 import get_common_datasets_v9
from config.ul_2018_v12 import setupBtagDeeptau, get_common_datasets_v12, get_2018_v12_weights 

class Config_ul_2018_ZH_v12(base_config_ZttHbb):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_v12_weights()
        weights.ZttHbb_elliptical_cut_90 = weights.mutau
        weights.ZttHbb_elliptical_cut_90_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_tautau = weights.mutau

        weights.ZttHbb_elliptical_cut_90_sr = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_tautau = weights.mutau

        weights.ZttHbb_elliptical_cut_90_CR = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_tautau = weights.mutau
        return weights

    #@override
    def add_datasets(self):
        v9_datasets = get_common_datasets_v9(self)
        datasets = get_common_datasets_v12(self)

        for name in [
            # "wjets_FXFX", "wjets_FXFX_0j", "wjets_FXFX_1j", "wjets_FXFX_2j", 
            "wjets_MLM", 
            # "wjets_MLM_1j", "wjets_MLM_2j", "wjets_MLM_3j", "wjets_MLM_4j", 
            "wjets_ht1", "wjets_ht2", "wjets_ht3", "wjets_ht4", "wjets_ht5", "wjets_ht6", "wjets_ht7", "wjets_ht8",
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

        p = "/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2018/"
        datasets += ObjectCollection([

            ###################################### ZH Signal ##############################################
            ###############################################################################################

            #### ZH_Hbb_Zll
            Dataset("zh_ztt_hbb_signal",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_ztt_hbb_signal"),
                xs=0.052,
                secondary_dataset="zh_ztt_hbb_signal_aux",
                prefix="eoscms.cern.ch//",
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
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zh_ztt_hbb_background_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zh_ztt_hbb_background"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                tags=["ul", "secondary"]),

            #### ZHToTauTau
            Dataset("zh_htt",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_htt"),
                xs=0.0554,
                secondary_dataset="zh_htt_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]), 
            Dataset("zh_htt_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v2/NANOAODSIM",
                process=self.processes.get("zh_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                tags=["ul", "secondary"]),

            ###################################### ZZ Background ##########################################
            ###############################################################################################
            # ZZ semileptonic (added here since ZZ analysis uses this dataset with genfilter for bbtautau, whilst in ZH we use the full dataset)
            Dataset("zz_sl",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl"),
                xs=5.52,
                secondary_dataset="zz_sl_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zz_sl_aux",
                dataset="/ZZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                    "RunIISummer20UL18NanoAODv9-106X_upgrade2018_realistic_v16_L1v1-v1/NANOAODSIM",
                process=self.processes.get("zz_sl"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                tags=["ul", "secondary"]),

            ###################################### ZH Resonant ############################################
            ###############################################################################################

            #### ZH Resonance high mass (Private Production)
            # version 3 (miniAODv2 nanoAODv12)
            Dataset("Zprime_Zh_Ztautauhbb_M500_v3",
                folder="/eos/grif/cms/llr/store/user/evernazz/bbtt-prod/PrivateZH/ZttHbb_500/",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="Zprime_Zh_Ztautauhbb_M500_v3_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("Zprime_Zh_Ztautauhbb_M500_v3_aux",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Ztautauhbb_M500/Step_6",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("Zprime_Zh_Ztautauhbb_M1000_v3",
                folder="/eos/grif/cms/llr/store/user/evernazz/bbtt-prod/PrivateZH/ZttHbb_1000/",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M1000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="Zprime_Zh_Ztautauhbb_M1000_v3_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("Zprime_Zh_Ztautauhbb_M1000_v3_aux",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Ztautauhbb_M1000/Step_6",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M1000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("Zprime_Zh_Ztautauhbb_M2000_v3",
                folder="/eos/grif/cms/llr/store/user/evernazz/bbtt-prod/PrivateZH/ZttHbb_2000/",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M2000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="Zprime_Zh_Ztautauhbb_M2000_v3_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("Zprime_Zh_Ztautauhbb_M2000_v3_aux",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Ztautauhbb_M2000/Step_6",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M2000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("Zprime_Zh_Ztautauhbb_M3000_v3",
                folder="/eos/grif/cms/llr/store/user/evernazz/bbtt-prod/PrivateZH/ZttHbb_3000/",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M3000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="Zprime_Zh_Ztautauhbb_M3000_v3_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("Zprime_Zh_Ztautauhbb_M3000_v3_aux",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Ztautauhbb_M3000/Step_6",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M3000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("Zprime_Zh_Ztautauhbb_M4000_v3",
                folder="/eos/grif/cms/llr/store/user/evernazz/bbtt-prod/PrivateZH/ZttHbb_4000/",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M4000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="Zprime_Zh_Ztautauhbb_M4000_v3_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("Zprime_Zh_Ztautauhbb_M4000_v3_aux",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Ztautauhbb_M4000/Step_6",
                process=self.processes.get("Zprime_Zh_Ztautauhbb_M4000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

        ])

        return datasets

config = Config_ul_2018_ZH_v12("ul_2018_ZttHbb_v12", year=2018, ecm=13, lumi_pb=59741, isUL=True, AnalysisType="Ztautau_Hbb")