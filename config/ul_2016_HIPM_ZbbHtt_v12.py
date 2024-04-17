from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZbbHtt import ConfigZbbHtt as base_config_ZbbHtt
from config.ul_2016_HIPM_v9 import get_common_datasets_v9
from config.ul_2016_HIPM_v12 import setupBtagDeeptau, get_common_datasets_v12, get_2016_HIPM_v12_weights

class Config_ul_2016_HIPM_ZH_v12(base_config_ZbbHtt):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        setupBtagDeeptau(self)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2016_HIPM_v12_weights()
        weights.ZbbHtt_elliptical_cut_90 = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_tautau = weights.mutau

        weights.ZbbHtt_elliptical_cut_90_sr = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_sr_tautau = weights.mutau
        
        weights.ZbbHtt_elliptical_cut_90_CR = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_tautau = weights.mutau
        return weights

    #@override
    def add_datasets(self):
        v9_datasets = get_common_datasets_v9(self)
        datasets = get_common_datasets_v12(self)

        for name in [
            # "wjets_FXFX", "wjets_FXFX_0j", "wjets_FXFX_1j", "wjets_FXFX_2j", 
            "wjets_MLM", 
            # "wjets_MLM_1j", "wjets_MLM_2j", "wjets_MLM_3j", "wjets_MLM_4j", 
            # "wjets_ht1", 
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
            # "zh_zbb_htt_signal", "zh_ztt_hbb_signal",
            # "zh_hbb_zll",
            # "zz_sl"
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

        # ZH datasets
        # ZH_HToTT_ZToBB is split in 2 processes :
        # - zh_zbb_htt_signal (with filter for bbtautau decay) 
        # - zh_zbb_htt_background (with inverted filter)
        # ZH_HToBB_ZToTT is considered as background
        # ZZ_SL is considered as background

        p = "/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_2016_HIPM/"
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
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
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
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
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
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
                process=self.processes.get("zh_hbb"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.052, # AN
                # xs=0.07977, # XSDB NLO
                tags=["ul", "secondary"]),
            
            # Z->bb, H->tt considered as background for resonant analysis (genfilter bbtautau)
            # (exact same zh_zbb_htt_signal, you can even symlink the dataset to avoid reprocessing)
            Dataset("zh_zbb_htt",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_zbb_htt"),
                xs=0.0554,
                secondary_dataset="zh_zbb_htt_aux",
                prefix="eoscms.cern.ch//",
                tags=["ul", "nanoV10", "res"]),
            Dataset("zh_zbb_htt_aux",
                dataset="/ZHToTauTau_M125_CP5_13TeV-powheg-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("zh_zbb_htt"),
                # prefix="xrootd-cms.infn.it//",
                xs=0.0554, # AN
                # xs=0.7891, # XSDB NLO
                splitting=200000,
                tags=["ul", "secondary", "res"]),  


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
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
                process=self.processes.get("zz_sl"),
                # prefix="xrootd-cms.infn.it//",
                xs=5.52, # AN
                # xs=3.676, # XSDB unknown
                # xs=3.22, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15GS%2D00166-,3.22,-NLO%2C%20up%20to
                tags=["ul", "secondary"]),

            ###################################### ZH Resonant ############################################
            ###############################################################################################

            #### ZH Resonance high mass

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-500/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M500_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-500_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M600",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-600/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M600"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M600_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M600_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-600_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M600"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M700",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-700/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M700"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M700_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M700_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-700_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M700"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M800",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-800/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M800"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M800_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M800_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-800_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M800"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-1000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M1000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-1000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1200",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-1200/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1200"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M1200_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1200_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-1200_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1200"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1400",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-1400/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1400"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M1400_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1400_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-1400_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1400"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1600",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-1600/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1600"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M1600_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1600_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-1600_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1600"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1800",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-1800/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1800"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M1800_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M1800_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-1800_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M1800"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M2000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-2000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M2000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M2000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M2000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-2000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M2000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M2500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-2500/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M2500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M2500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M2500_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-2500_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M2500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M3000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-3000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M3000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M3000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M3000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-3000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M3000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M3500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-3500/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M3500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M3500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M3500_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-3500_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M3500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M4000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-4000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M4000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M4000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M4000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-4000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M4000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M4500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-4500/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M4500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M4500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M4500_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-4500_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M4500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M5000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-5000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M5000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M5000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M5000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-5000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M5000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M5500",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-5500/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M5500"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M5500_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M5500_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-5500_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M5500"),
                xs=1,
                tags=["ul", "secondary", "res"]),

            Dataset("ZprimeToZH_ZToBB_HToTauTau_M6000",
                folder="/eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2016_HIPM/ZprimeToZH_ZToBB_HToTauTau_M-6000/",
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M6000"),
                prefix="eos.grif.fr//",
                xs=1,
                secondary_dataset="ZprimeToZH_ZToBB_HToTauTau_M6000_aux",
                tags=["ul", "nanoV10", "res"]),
            Dataset("ZprimeToZH_ZToBB_HToTauTau_M6000_aux",
                dataset="/ZprimeToZH_ZToBB_HToTauTau_M-6000_TuneCP5_13TeV-madgraph-pythia8/"
                    "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
                skip_files=[
                    "/store/mc/RunIISummer20UL16MiniAODAPVv2/ZprimeToZH_ZToBB_HToTauTau_M-6000_TuneCP5_13TeV-madgraph-pythia8/MINIAODSIM/106X_mcRun2_asymptotic_preVFP_v11-v2/2830000/4A14A1CF-E9FE-A943-A4D0-B4CAB0153C1A.root",
                    "/store/mc/RunIISummer20UL16MiniAODAPVv2/ZprimeToZH_ZToBB_HToTauTau_M-6000_TuneCP5_13TeV-madgraph-pythia8/MINIAODSIM/106X_mcRun2_asymptotic_preVFP_v11-v2/2830000/5A1ABB56-819F-DD4D-AAC8-08C41E6655E2.root",
                    "/store/mc/RunIISummer20UL16MiniAODAPVv2/ZprimeToZH_ZToBB_HToTauTau_M-6000_TuneCP5_13TeV-madgraph-pythia8/MINIAODSIM/106X_mcRun2_asymptotic_preVFP_v11-v2/2830000/91B85314-BA92-BF4C-8984-98F535FAD50B.root",
                    "/store/mc/RunIISummer20UL16MiniAODAPVv2/ZprimeToZH_ZToBB_HToTauTau_M-6000_TuneCP5_13TeV-madgraph-pythia8/MINIAODSIM/106X_mcRun2_asymptotic_preVFP_v11-v2/2830000/9385D478-9A41-7748-9419-32A95CC1B82F.root",
                ],
                process=self.processes.get("Zprime_Zh_Zbbhtautau_M6000"),
                xs=1,
                tags=["ul", "secondary", "res"]),

        ])

        return datasets

config = Config_ul_2016_HIPM_ZH_v12("ul_2016_HIPM_ZbbHtt_v12", year=2016, ecm=13, lumi_pb=19500, isUL=True, ispreVFP=True, AnalysisType="Zbb_Htautau")
# https://github.com/LLRCMS/KLUBAnalysis/blob/master/config/mainCfg_MuTau_UL2016APV.cfg#L3C8-L3C13