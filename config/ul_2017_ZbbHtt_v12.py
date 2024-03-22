from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZbbHtt import ConfigZbbHtt as base_config_ZbbHtt
from config.ul_2017_v9 import get_common_datasets_v9
from config.ul_2017_v12 import setupBtagDeeptau, get_common_datasets_v12, get_2017_v12_weights

class Config_ul_2017_ZH_v12(base_config_ZbbHtt):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2017_v12_weights()
        weights.ZbbHtt_elliptical_cut_90 = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_tautau = weights.mutau

        weights.ZbbHtt_elliptical_cut_90_sr = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_tautau = weights.mutau
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
            # "zh_zbb_htt_signal", "zh_ztt_hbb_signal",
            # "zh_hbb_zll",
            # "zz_sl"
            ]:
            datasets.add(
                Dataset(
                    v9_datasets.get(name), dataset_name="%s_aux" % name, tags=["ul", "secondary"])
            )

        # ZH datasets
        # ZH_HToTT_ZToBB is split in 2 processes :
        # - zh_zbb_htt_signal (with filter for bbtautau decay) 
        # - zh_zbb_htt_background (with inverted filter)
        # ZH_HToBB_ZToTT is considered as background
        # ZZ_SL is considered as background

        p = "/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2017/"
        datasets += ObjectCollection([

            ###################################### ZH Signal ##############################################
            ###############################################################################################

            #### ZH_Htt_Zbb
            Dataset("zh_zbb_htt_signal",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_zbb_htt_signal"),
                xs=0.0554,
                secondary_dataset="zh_zbb_htt_signal_aux",
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zh_zbb_htt_signal_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
                process=self.processes.get("zh_zbb_htt_signal"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary"]),  

            ###################################### ZH Background ##########################################
            ###############################################################################################

            #### ZH_Htt_Zbb
            Dataset("zh_zbb_htt_background",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_zbb_htt_background"),
                xs=0.0554,
                secondary_dataset="zh_zbb_htt_background_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zh_zbb_htt_background_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
                process=self.processes.get("zh_zbb_htt_background"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                tags=["ul", "secondary"]),

            #### ZH_Hbb_Zll
            Dataset("zh_hbb_zll",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_hbb"),
                xs=0.052,
                secondary_dataset="zh_hbb_zll_aux",
                # categorization_max_events=10000,
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10"]),
            Dataset("zh_hbb_zll_aux",
                dataset="/ZH_HToBB_ZToLL_M-125_TuneCP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                tags=["ul", "secondary"]),

            #### ZZ_SL 
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
                    "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
                process=self.processes.get("zz_sl"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                tags=["ul", "secondary"]),

            ###################################### ZH Resonant ############################################
            ###############################################################################################

        ])

        return datasets

config = Config_ul_2017_ZH_v12("ul_2017_ZbbHtt_v12", year=2017, ecm=13, lumi_pb=41529, isUL=True, AnalysisType="Zbb_Htautau")
# https://github.com/LLRCMS/KLUBAnalysis/blob/master/config/mainCfg_ETau_Legacy2017.cfg#L3