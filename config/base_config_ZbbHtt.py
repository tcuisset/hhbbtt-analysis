# Config for ZbbHtt analysis common for all years
import itertools
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig
from config.base_config_ZH import get_ZH_common_features, resonant_masses_ZH, reduced_resonant_masses_ZH

class ConfigZbbHtt(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        elliptical_cut_90 = ("((({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
                " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) < 1)")
        elliptical_cut_90_inv = ("((({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
                " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) >= 1)")
        sr_cut = ("(((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 2) && (isOS == 1) && "
                    "(dau1_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0}))) "
                    .format(self.deeptau.vsjet.Medium))
        bjets = self.get_bjets_requirements()
        
        categories += ObjectCollection([

            Category("ZbbHtt_elliptical_cut_90", "Elliptical cut E=90%",
                selection=elliptical_cut_90),
            Category("ZbbHtt_elliptical_cut_90_sr", "ZH mass cut E=90% && Signal region",
                selection="("+elliptical_cut_90+") && ("+sr_cut+")"),

            Category("ZbbHtt_elliptical_cut_90_CR_mutau", "CR ZH mass cut E=90%",
                selection="("+elliptical_cut_90_inv+") && (pairType == 0)"),
            Category("ZbbHtt_elliptical_cut_90_CR_etau", "CR ZH mass cut E=90%",
                selection="("+elliptical_cut_90_inv+") && (pairType == 1)"),
            Category("ZbbHtt_elliptical_cut_90_CR_tautau", "CR ZH mass cut E=90%",
                selection="("+elliptical_cut_90_inv+") && (pairType == 2)"),

            Category("ZbbHtt_elliptical_cut_90_mutau", "ZH mass cut E=90%",
                selection="("+elliptical_cut_90+") && (pairType == 0)"),
            Category("ZbbHtt_elliptical_cut_90_etau", "ZH mass cut E=90%",
                selection="("+elliptical_cut_90+") && (pairType == 1)"),
            Category("ZbbHtt_elliptical_cut_90_tautau", "ZH mass cut E=90%",
                selection="("+elliptical_cut_90+") && (pairType == 2)"),
            
            Category("ZbbHtt_ttCR", "ttbar CR", # inverted elliptical mass cut + 2 resolved b jets
                selection=f"({elliptical_cut_90_inv}) && !isBoosted &&"
                f"Jet_btagDeepFlavB.at(bjet1_JetIdx) > {self.btag['medium']} && "
                f"Jet_btagDeepFlavB.at(bjet2_JetIdx) > {self.btag['medium']}"),
            
            # elliptical cut & non boosted
            # non-boosted = at least one bjet passes medium (res1b&&res2b equivalent)
            # boosted : needs to be studied (b-tagging for AK8 ?) f"|| (isBoosted == 1 && Jet_btagDeepFlavB.at(bjet1_JetIdx) > {self.btag['loose']} && et_btagDeepFlavB.at(bjet2_JetIdx) > {self.btag['loose']})"
            Category("ZbbHtt_SR_btag_resolved_etau", "ZH SR with btag res1b,res2b,boosted",
                selection=f"({elliptical_cut_90}) && isBoosted == 0 && pairType == 1"
                f" && (Jet_btagDeepFlavB.at(bjet1_JetIdx) > {self.btag['medium']} || Jet_btagDeepFlavB.at(bjet2_JetIdx) > {self.btag['medium']})"
            ),

            Category("ZbbHtt_elliptical_cut_90_resolved_1b", "EC90 & resolved 1b",
                selection=f"({elliptical_cut_90}) && isBoosted == 0 && ({bjets.req_1b})"),
            Category("ZbbHtt_elliptical_cut_90_resolved_2b", "EC90 & resolved 2b",
                selection=f"({elliptical_cut_90}) && isBoosted == 0 && ({bjets.req_2b})"),
            Category("ZbbHtt_elliptical_cut_90_boosted", "EC90 & boosted",
                selection=f"({elliptical_cut_90}) && isBoosted == 1 && ({bjets.req_ll})"),
        ])

        return categories
    
    #@override
    def add_features(self):
        """ Add features specific to ZH, in addition to the common ones defined in base_config.py 
        There are features for both ZbbHtt and ZttHbb analyses. TODO split them
        """
        base_features = super().add_features() + get_ZH_common_features()
        zbttHtt_features = [
            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(15, 50, 200),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV",
                systematics=["jer","jec", #"jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             #"jec_7", "jec_8", "jec_9", "jec_10", "jec_11"
                            ]),
            Feature("Zbb_eta", "Zbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b#bar{b}) #eta"),
                systematics=["jer","jec", #"jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             #"jec_7", "jec_8", "jec_9", "jec_10", "jec_11"
                            ]),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b#bar{b}) #phi"),
                systematics=["jer","jec", #"jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             #"jec_7", "jec_8", "jec_9", "jec_10", "jec_11"
                            ]),
            Feature("Zbb_mass", "Zbb_mass", binning=(30, 0, 250),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV",
                systematics=["jer","jec", #"jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             #"jec_7", "jec_8", "jec_9", "jec_10", "jec_11"
                            ]),
            Feature("Zbb_mass_ellipse", "Zbb_mass", binning=(50, 0, 500),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV"),
            
            # Htt
            Feature("Htt_pt", "Htt_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_eta", "Htt_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta"),
                systematics=["tes"]),
            Feature("Htt_phi", "Htt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}) #phi"),
                systematics=["tes"]),
            Feature("Htt_mass", "Htt_mass", binning=(30, 0, 150),
                x_title=Label("H(#tau^{+}#tau^{-}) mass"),
                units="GeV",
                systematics=["tes"]),
            
            # Htt + met
            Feature("Htt_met_pt", "Htt_met_pt", binning=(15, 50, 200),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_met_eta", "Htt_met_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #eta"),
                systematics=["tes"]),
            Feature("Htt_met_phi", "Htt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #phi"),
                systematics=["tes"]),
            Feature("Htt_met_mass", "Htt_met_mass", binning=(25, 0, 500),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) mass"),
                units="GeV",
                systematics=["tes"]),
            
            # Htt (SVFit)
            Feature("Htt_svfit_pt", "Xtt_svfit_pt", binning=(15, 50, 200),
                x_title=Label("H(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_svfit_eta", "Xtt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_phi", "Xtt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}) #phi (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_mass", "Xtt_svfit_mass", binning=(25, 1, 501),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_svfit_mass_ellipse", "Xtt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV"),
        ]
        return base_features + ObjectCollection(zbttHtt_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        # https://leonardocolor.io/scales.html#
        # long version
        colors_res = itertools.cycle([(31, 0, 117), (4, 41, 100), (0, 55, 101), (0, 66, 106), (0, 78, 110), (0, 88, 113), (0, 99, 115), (0, 109, 115), (0, 119, 114), (0, 129, 111), (0, 139, 105), (14, 148, 99), (48, 155, 92), (78, 161, 84), (103, 165, 76), (127, 169, 68), (151, 172, 60), (174, 174, 55)])
        #short version
        colors_res = itertools.cycle([(31, 0, 117), (0, 66, 106), (0, 99, 115), (0, 129, 111), (48, 155, 92), (127, 169, 68), (174, 174, 55)])
        
        processes += ObjectCollection([
            ########### ZbbHtt analysis
            # ZHToTauTau_M125 dataset with genfilter Z->bb,H->tautau
            Process("zh_zbb_htt_signal", Label("Z_{bb}H_{#tau#tau}"),
                    ProcType="Zbb_Htautau", isSigBBTT=True, isSignal=True, color=(0, 165, 80), llr_name="ZbbHtt"),
            # same as above but with reversed genfilter (everything except Z->bb,H->tautau)
            Process("zh_zbb_htt_background", Label("ZH (H#rightarrow#tau#tau) bkg"), parent_process='zh',
                    ProcType="Zbb_Htautau", isBkgBBTT=True, color=(224, 190, 79)),

            # includes ZH_HToBB_ZToTT as background of ZbbHtt analysis
            Process("zh_hbb", Label("ZH (H#rightarrow bb, Z#rightarrow ll)"), parent_process='zh',
                    color=(1, 99, 24)),
            # ZH includes all the processes BUT THE ZBBHTT SIGNAL
            Process("zh", Label("ZH"), color=(130, 39, 197), parent_process="higgs", llr_name="ZH"),
            
            ######### Common
            # ZZ_SL
            Process("zz_sl", Label("zz_sl"), color=(130, 39, 197), parent_process="zz"),
            Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(28, 130, 145), parent_process="zh"),

            ######## Resonant
            # ZH resonant (old label : Z'#rightarrow Z_{bb}H_{#tau#tau} )
            *[Process(f"Zprime_Zh_Zbbhtautau_M{mass}", Label(f"Z' {mass} GeV" if mass < 1000 else f"Z' {mass/1000:g} TeV"), color=next(colors_res), 
                    isSigBBTT=True, ProcType="Zbb_Htautau", isSignal=True, llr_name="ZprimeZbbHtt")
            for mass in resonant_masses_ZH],

            # background for resonant analysis (zh_zbb_htt_signal with isSignal=False, dataset is the exact same)
            Process("zh_zbb_htt", Label("Z_{bb}H_{#tau#tau}"), color=(0, 165, 80), 
                    ProcType="Zbb_Htautau", isSigBBTT=True, parent_process='zh'),
        ])

        resonant_dataset_names = [f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH]
        resonant_dataset_names_reduced = [f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in reduced_resonant_masses_ZH]

        process_group_names = {
        "Zprime_Zh_Zbbhtt": resonant_dataset_names,
        "datacard_ZbbHtt": [
            "zh_zbb_htt_signal",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz which in turn includes zz_sl
            "wh",
            "zh", # this is actually zh_background ie ZH processes not part of signal
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "plot": [
            "zh_zbb_htt_signal",
            "higgs", # includes zh_zbb_htt_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "plot_res": [
            *resonant_dataset_names,
            "higgs", # includes zh_zbb_htt and zh_zbb_htt_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "plot_res_reduced": [ # smaller number of mass points to avoid cluttering plot
            *resonant_dataset_names_reduced,
            "higgs", # includes zh_zbb_htt and zh_zbb_htt_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "datacard_ZbbHtt_res": [
            *resonant_dataset_names,
            "zh_zbb_htt", # ZbbHtt as background for resonant analysis
            "zh_zbb_htt_background", # remainder of ZHToTauTau dataset (TODO probably put this under some more general category (in ZZ analysis it is under vv))
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz
            "wh",
            #"zh", # this is actually zh_background ie ZH processes not part of signal
            "zh_hbb_zqq",
            "zh_hbb",
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "zh_split_signal": [
            "zh_zbb_htt_signal",
            "zh_zbb_htt_background",       
        ],
        "zh_sig_vs_bkg": [
            "all_background",
            "zh_zbb_htt_signal",
        ],
        }        
        return processes, process_group_names, process_training_names