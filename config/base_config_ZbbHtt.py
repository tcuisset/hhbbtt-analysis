# Config for ZbbHtt analysis common for all years

from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig
from config.base_config_ZH import get_ZH_common_features

class ConfigZbbHtt(BaseConfig):
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

            ########## New elliptifcal cut, centered on signal maximum
            Category("ZbbHtt_elliptical_cut_90", "ZH elliptical mass cut targeting Z->bb,H->tautau, 90% efficiency",
                selection="(({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
                " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) < 1"
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
        base_features = super().add_features() + get_ZH_common_features()
        zbttHtt_features = [
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
        ]
        return base_features + ObjectCollection(zbttHtt_features)

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
        ])

        process_group_names = {
        "Zprime_Zh_Zbbhtt": ["Zprime_Zh_Zbbhtautau_M600"],
        "datacard_ZbbHtt": [
            "zh_zbb_htt_signal",
            "zh_zbb_htt_background",
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