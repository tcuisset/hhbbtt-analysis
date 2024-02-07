""" Base configuration for X->ZH->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
    
    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        categories_mass_cut = ObjectCollection([
            ########## old elliptical cut, not centered on maximum of signal
            # # Best Ellipse (140.0, 82.0, 57.0, 66.0): S_eff=0.8019, B_eff=0.3956, S/sqrt(B)=1.2751
            # Category("ZH_elliptical_cut_80_zbb_htt", "ZH elliptical mass cut targeting Z->bb,H->tautau",
            #     selection="(({{Ztt_svfit_mass}} - 140.) * ({{Ztt_svfit_mass}} - 140.) / (57. * 57.)"
            #     " + ({{Zbb_mass}} - 82.) * ({{Zbb_mass}} - 82.) / (66. * 66.)) < 1"
            # ),
            # # Best Ellipse (158.0, 118.0, 83.0, 118.0): S_eff=0.9003, B_eff=0.5991, S/sqrt(B)=1.1632
            # Category("ZH_elliptical_cut_90_zbb_htt", "ZH elliptical mass cut targeting Z->bb,H->tautau",
            #     selection="(({{Ztt_svfit_mass}} - 158.) * ({{Ztt_svfit_mass}} - 158.) / (83. * 83.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (118. * 118.)) < 1"
            # ),
            # # Best Ellipse (93.0, 172.0, 37.0, 164.0): S_eff=0.8009, B_eff=0.3313, S/sqrt(B)=1.3914
            # Category("ZH_elliptical_cut_80_ztt_hbb", "ZH elliptical mass cut targeting Z->bb,H->tautau",
            #     selection="(({{Ztt_svfit_mass}} - 93.) * ({{Ztt_svfit_mass}} - 93.) / (37. * 37.)"
            #     " + ({{Zbb_mass}} - 172.) * ({{Zbb_mass}} - 172.) / (164. * 164.)) < 1"
            # ),
            # #Best Ellipse (100.0, 189.0, 64.0, 187.0): S_eff=0.9000, B_eff=0.5304, S/sqrt(B)=1.2358
            # Category("ZH_elliptical_cut_90_ztt_hbb", "ZH elliptical mass cut targeting Z->bb,H->tautau",
            #     selection="(({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (64. * 64.)"
            #     " + ({{Zbb_mass}} - 189.) * ({{Zbb_mass}} - 189.) / (187. * 187.)) < 1"
            # ),

            ########## New elliptifcal cut, centered on signal maximum
            Category("ZbbHtt_elliptical_cut_90", "ZH elliptical mass cut targeting Z->bb,H->tautau, 90% efficiency",
                selection="(({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
                " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) < 1"
            ),

            Category("ZttHbb_elliptical_cut_90", "ZH elliptical mass cut targeting Z->tautau,H->bb, 90% efficiency",
                selection="(({{Ztt_svfit_mass}} - 91.) * ({{Ztt_svfit_mass}} - 91.) / (83. * 83.)"
                " + ({{Hbb_mass}} - 102.) * ({{Hbb_mass}} - 102.) / (143. * 143.)) < 1"
            ),
        ])
        categories += categories_mass_cut

        # add the same ellipitical cuts but in mutau, etau, tautau versions
        for channelName, pairType in {"mutau": 0, "etau": 1, "tautau": 2}.items():
            for baseEllipticalCut in categories_mass_cut:
                categories.append(
                        Category(
                            name = baseEllipticalCut.name + "_" + channelName,
                            label = baseEllipticalCut.label + f" ({channelName})",
                            selection  =f"({baseEllipticalCut.selection}) && (pairType == {pairType})"
                        )
                    )
        return ObjectCollection(categories)
    
    #@override
    def add_features(self):
        """ Add features specific to ZH, in addition to the common ones defined in base_config.py 
        There are features for both ZbbHtt and ZttHbb analyses. TODO split them
        """
        base_features = super().add_features()
        zh_features = [
            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(10, 50, 150),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV",
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_eta", "Zbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b#bar{b}) #eta"),
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b#bar{b}) #phi"),
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_mass", "Zbb_mass", binning=(30, 0, 250),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV",
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_mass_ellipse", "Zbb_mass", binning=(50, 0, 500),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV"),

            # Hbb
            Feature("Hbb_pt", "Hbb_pt", binning=(10, 50, 150),
                x_title=Label("H(b#bar{b}) p_{T}"),
                units="GeV",
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Hbb_eta", "Hbb_eta", binning=(20, -5., 5.),
                x_title=Label("H(b#bar{b}) #eta"),
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Hbb_phi", "Hbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(b#bar{b}) #phi"),
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Hbb_mass", "Hbb_mass", binning=(30, 0, 250),
                x_title=Label("H(b#bar{b}) mass"),
                units="GeV",
                systematics=["jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Hbb_mass_ellipse", "Hbb_mass", binning=(50, 0, 500),
                x_title=Label("H(b#bar{b}) mass"),
                units="GeV"),

            # Ztt
            Feature("Ztt_pt", "Ztt_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_eta", "Ztt_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}) #eta"),
                systematics=["tes"]),
            Feature("Ztt_phi", "Ztt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi"),
                systematics=["tes"]),
            Feature("Ztt_mass", "Ztt_mass", binning=(30, 0, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass"),
                units="GeV",
                systematics=["tes"]),
            
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

            # Ztt + met
            Feature("Ztt_met_pt", "Ztt_met_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_met_eta", "Ztt_met_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #eta"),
                systematics=["tes"]),
            Feature("Ztt_met_phi", "Ztt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #phi"),
                systematics=["tes"]),
            Feature("Ztt_met_mass", "Ztt_met_mass", binning=(30, 0, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) mass"),
                units="GeV",
                systematics=["tes"]),
            
            # Htt + met
            Feature("Htt_met_pt", "Htt_met_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_met_eta", "Htt_met_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #eta"),
                systematics=["tes"]),
            Feature("Htt_met_phi", "Htt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #phi"),
                systematics=["tes"]),
            Feature("Htt_met_mass", "Htt_met_mass", binning=(30, 0, 150),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) mass"),
                units="GeV",
                systematics=["tes"]),

            # Ztt (SVFit)
            Feature("Ztt_svfit_pt", "Ztt_svfit_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_svfit_eta", "Ztt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta (SVFit)"),
                systematics=["tes"]),
            Feature("Ztt_svfit_phi", "Ztt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi (SVFit)"),
                systematics=["tes"]),
            Feature("Ztt_svfit_mass", "Ztt_svfit_mass", binning=(32, 40, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_svfit_mass_ellipse", "Ztt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV"),
            
            # Htt (SVFit)
            Feature("Htt_svfit_pt", "Htt_svfit_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_svfit_eta", "Htt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_phi", "Htt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}) #phi (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_mass", "Htt_svfit_mass", binning=(32, 40, 200),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_svfit_mass_ellipse", "Htt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV"),

            # ZH
            Feature("ZH_pt", "ZH_pt", binning=(10, 50, 150),
                x_title=Label("ZH p_{T}"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_eta", "ZH_eta", binning=(20, -5., 5.),
                x_title=Label("ZH #eta"),
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_phi", "ZH_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZH #phi"),
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_mass", "ZH_mass", binning=(50, 0, 1000),
                x_title=Label("ZH_{bb#tau#tau} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_mass_fine", "ZH_mass", binning=(600, 0, 3000),
                x_title=Label("ZH_{bb#tau#tau} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

            # ZH (SVFit)
            Feature("ZH_svfit_pt", "ZH_svfit_pt", binning=(10, 50, 150),
                x_title=Label("ZH p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_svfit_eta", "ZH_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("ZH #eta (SVFit)"),
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_svfit_phi", "ZH_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZH #phi (SVFit)"),
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_svfit_mass", "ZH_svfit_mass", binning=(50, 0, 1000),
                x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZH_svfit_mass_fine", "ZH_svfit_mass", binning=(600, 0, 3000),
                x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

            # ZH KinFit
            Feature("ZHKinFit_mass", "ZHKinFit_mass", binning=(50, 0, 1000),
                x_title=Label("ZH mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZHKinFit_highmass", "ZHKinFit_mass", binning=(175, 0, 3500),
                x_title=Label("ZH mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZHKinFit_mass_res", "ZHKinFit_mass", binning=(50, 180, 1180),
                x_title=Label("ZH mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZHKinFit_highmass_res", "ZHKinFit_mass", binning=(175, 180, 3680),
                x_title=Label("ZH mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZHKinFit_chi2", "ZHKinFit_chi2", binning=(30, 0, 50),
                x_title=Label("ZH #chi^{2} (Kin. Fit)"),
                systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        ]
        return base_features + ObjectCollection(zh_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()

        # add ggZpZHbbtt
        processes += ObjectCollection([
            ########### ZbbHtt analysis
            # ZH_HToTT_ZToBB
            Process("zh_zbb_htt_signal", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"),
                    ProcType="Zbb_Htautau", isSigBBTT=True, isSignal=True, color=(126, 238, 124)),
            Process("zh_zbb_htt_background", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"), parent_process='higgs',
                    ProcType="Zbb_Htautau", isBkgBBTT=True, color=(126, 238, 124)),

            # includes ZH_HToBB_ZToTT as background of ZbbHtt analysis
            Process("zh_hbb", Label("ZH (H#rightarrow bb, Z#rightarrow ll)"), parent_process='higgs',
                    color=(126, 238, 124)),

            ########### ZttHbb analysis
            # ZH_HToBB_ZToTT
            Process("zh_ztt_hbb_signal", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"),
                    ProcType="Ztautau_Hbb", isSigBBTT=True, isSignal=True, color=(32, 196, 201)),
            Process("zh_ztt_hbb_background", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"), parent_process='higgs',
                    ProcType="Ztautau_Hbb", isBkgBBTT=True, color=(32, 196, 201)),
            
            # includes ZHToTauTau as background of ZttHbb analysis
            Process("zh_htt", Label("ZH (H#rightarrow #tau#tau, Z#rightarrow anything)"), parent_process='higgs',
                    color=(126, 238, 124)),
            
            ######### Common
            # ZZ_SL
            Process("zz_sl", Label("zz_sl"), color=(130, 39, 197), parent_process="zz"),
            Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(130, 39, 197), parent_process="higgs"),


            ######## Resonant
            # ZH resonant
            Process("Zprime_Zh_Zbbhtautau_M600", Label("Z'#rightarrow ZH #rightarrow bb#tau#tau,  600 GeV"), color=(238, 245, 99), 
                    isSigBBTT=True, ProcType="Zbb_Htautau", isSignal=True, llr_name="ZHbbtt_M600"),

            # background for resonant analysis 
            Process("zh_zbb_htt", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"), color=(0, 165, 80), 
                    ProcType="Zbb_Htautau", isSigBBTT=True, parent_process='higgs'),
            Process("zh_ztt_hbb", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"), color=(0, 165, 80), 
                    ProcType="Ztautau_Hbb", isSigBBTT=True, parent_process='higgs'),
        ])

        process_group_names = {
        "Zprime_Zh_Zbbhtautau": ["Zprime_Zh_Zbbhtautau_M600"],
        "datacard_zh": [
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
            "zh_zbb_htt_background",
            "zh_ztt_hbb_background",
            "higgs", # added for zh but not sure correct (Theo)
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz
            "wh",
            #"zh", # this is actually zh_background ie ZH processes not part of signal
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
            "zh_ztt_hbb_signal",
            "zh_zbb_htt_background",
            "zh_ztt_hbb_background",         
        ],
        "zh_sig_vs_bkg": [
            "all_background",
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
        ],
        }        
        return processes, process_group_names, process_training_names
