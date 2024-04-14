""" Base configuration for X->ZZ->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        categories += ObjectCollection([
            # Category("ZZ_elliptical_cut_80", "ZZ mass cut E=80%",
            #     selection="(({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1"),
            # Category("ZZ_elliptical_cut_90", "Elliptical cut E=90%",
            #     selection="(({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
            #     " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1"),
            
            # Category("ZZ_elliptical_cut_80_sr", "ZZ mass cut E=80% && Signal region",
            #     selection="((({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
            #         " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1) && " + \
            #         "(((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
            #         "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
            #         "((pairType == 2) && (isOS == 1) && "
            #         "(dau1_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0}))) "
            #         .format(self.deeptau.vsjet.Medium)),

            # Category("ZZ_elliptical_cut_80_mutau", "ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 0)"),
            # Category("ZZ_elliptical_cut_80_etau", "ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 1)"),
            # Category("ZZ_elliptical_cut_80_tautau", "ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 2)"),

            # Category("ZZ_elliptical_cut_80_CR_mutau", "CR ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) >= 1) && (pairType == 0)"),
            # Category("ZZ_elliptical_cut_80_CR_etau", "CR ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) >= 1) && (pairType == 1)"),
            # Category("ZZ_elliptical_cut_80_CR_tautau", "CR ZZ mass cut E=80%",
            #     selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
            #     " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) >= 1) && (pairType == 2)"),

            Category("ZZ_elliptical_cut_90", "Elliptical cut E=90%",
                selection="(({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1"),

            Category("ZZ_elliptical_cut_90_sr", "ZZ mass cut E=90% && Signal region",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                    " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1) && " + \
                    "(((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 2) && (isOS == 1) && "
                    "(dau1_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0}))) "
                    .format(self.deeptau.vsjet.Medium)),

            Category("ZZ_elliptical_cut_90_CR_mutau", "CR ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) >= 1) && (pairType == 0)"),
            Category("ZZ_elliptical_cut_90_CR_etau", "CR ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) >= 1) && (pairType == 1)"),
            Category("ZZ_elliptical_cut_90_CR_tautau", "CR ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) >= 1) && (pairType == 2)"),

            Category("ZZ_elliptical_cut_90_mutau", "ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1) && (pairType == 0)"),
            Category("ZZ_elliptical_cut_90_etau", "ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1) && (pairType == 1)"),
            Category("ZZ_elliptical_cut_90_tautau", "ZZ mass cut E=90%",
                selection="((({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1) && (pairType == 2)"),

        ])

        return categories
    
    #@override
    def add_features(self):
        """ Add features specific to ZZ, in addition to the common ones defined in base_config.py """
        base_features = super().add_features()
        zz_features = [
            # # ZZ pt balance
            # Feature("ZZ_pt_balance", "({{Hbb_pt}} - {{Htt_svfit_pt}}) / ({{Hbb_pt}} + {{Htt_svfit_pt}})",
            #     binning=(30, -1, 1),
            #     x_title=Label("(p_{T}^{Z_{1}} - p_{T}^{Z_{2}}) / (p_{T}^{Z_{1}} + p_{T}^{Z_{2}})"),
            #     units="GeV"),
            # # ZZ angular variables
            # Feature("ZZ_deta", "({{Hbb_eta}} - {{Htt_svfit_eta}})", 
            #     binning=(30, -5., 5.),
            #     x_title=Label("#Delta#eta_{ZZ}")),
            # Feature("ZZ_dphi", "({{Hbb_phi}} - {{Htt_svfit_phi}})",
            #     binning=(30, -3.2, 3.2),
            #     x_title=Label("#Delta#phi_{ZZ}")),
            # Feature("ZZ_dR", "sqrt({{ZZ_deta}}*{{ZZ_deta}} + {{ZZ_dphi}}*{{ZZ_dphi}})", 
            #     binning=(30, 0, 10),
            #     x_title=Label("#DeltaR_{ZZ}")),
            Feature("pairType", "pairType", binning=(5, 0, 4),
                x_title=Label("Pair Type")),

            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(15, 50, 200),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV",
                systematics=["jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_eta", "Zbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b#bar{b}) #eta"),
                systematics=["jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b#bar{b}) #phi"),
                systematics=["jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_mass", "Zbb_mass", binning=(30, 0, 250),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV",
                systematics=["jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("Zbb_mass_ellipse", "Zbb_mass", binning=(50, 0, 500),
                x_title=Label("Z(b#bar{b}) mass"),
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

            # Ztt + met
            Feature("Ztt_met_pt", "Ztt_met_pt", binning=(15, 50, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_met_eta", "Ztt_met_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #eta"),
                systematics=["tes"]),
            Feature("Ztt_met_phi", "Ztt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #phi"),
                systematics=["tes"]),
            Feature("Ztt_met_mass", "Ztt_met_mass", binning=(25, 0, 500),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) mass"),
                units="GeV",
                systematics=["tes"]),

            # Ztt (SVFit)
            Feature("Ztt_svfit_pt", "Xtt_svfit_pt", binning=(15, 50, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_svfit_eta", "Xtt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}) #eta (SVFit)"),
                systematics=["tes"]),
            Feature("Ztt_svfit_phi", "Xtt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi (SVFit)"),
                systematics=["tes"]),
            Feature("Ztt_svfit_mass", "Xtt_svfit_mass", binning=(25, 1, 501),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Ztt_svfit_mass_ellipse", "Xtt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV"),

            # ZZ
            Feature("ZZ_pt", "ZZ_pt", binning=(10, 50, 150),
                x_title=Label("ZZ p_{T}"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_eta", "ZZ_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_phi", "ZZ_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_mass", "ZZ_mass", binning=(50, 0, 1000),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_mass_fine", "ZZ_mass", binning=(600, 0, 3000),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

            # ZZ (SVFit)
            Feature("ZZ_svfit_pt", "ZZ_svfit_pt", binning=(20, 30, 330),
                x_title=Label("ZZ p_{T} (SVFit)"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_svfit_eta", "ZZ_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta (SVFit)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_svfit_phi", "ZZ_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi (SVFit)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_svfit_mass", "ZZ_svfit_mass", binning=(50, 150, 1150),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZ_svfit_mass_fine", "ZZ_svfit_mass", binning=(600, 0, 3000),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

            # ZZ KinFit
            Feature("ZZKinFit_mass", "ZZKinFit_mass", binning=(50, 150, 1150),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZKinFit_mass_fit_1", "ZZKinFit_mass", binning=(20, 180, 780),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZKinFit_mass_fit_2", "ZZKinFit_mass", binning=(24, 180, 780),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZKinFit_mass_res", "ZZKinFit_mass", binning=(50, 150, 1650),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV",
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("ZZKinFit_chi2", "ZZKinFit_chi2", binning=(30, 0, 50),
                x_title=Label("ZZ #chi^{2} (Kin. Fit)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            
            Feature("dnn_ZZbbtt_kl_1", "dnn_ZZbbtt_kl_1", binning=(10, 0, 1),
                x_title=Label("DNN ZZ"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_200", "dnn_ZZbbtt_kl_1_200", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (200 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_300", "dnn_ZZbbtt_kl_1_300", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (300 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_400", "dnn_ZZbbtt_kl_1_400", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (400 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_500", "dnn_ZZbbtt_kl_1_500", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (500 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_600", "dnn_ZZbbtt_kl_1_600", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (600 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_700", "dnn_ZZbbtt_kl_1_700", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (700 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_800", "dnn_ZZbbtt_kl_1_800", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (800 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_900", "dnn_ZZbbtt_kl_1_900", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (900 GeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1000", "dnn_ZZbbtt_kl_1_1000", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1100", "dnn_ZZbbtt_kl_1_1100", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1.1 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1200", "dnn_ZZbbtt_kl_1_1200", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1.2 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1300", "dnn_ZZbbtt_kl_1_1300", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1.3 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1400", "dnn_ZZbbtt_kl_1_1400", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1.4 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
            Feature("dnn_ZZbbtt_kl_1_1500", "dnn_ZZbbtt_kl_1_1500", binning=(10, 0, 1),
                x_title=Label("PNN ZZ (1.5 TeV)"),
                systematics=["tes", "jer", "jec"]), # "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                             # "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

            
            Feature("LHE_Vpt", "LHE_Vpt", binning=(100, 0, 1000),
                x_title=Label("LHE PtZ"), units="GeV"),
            Feature("LHE_HT", "LHE_HT", binning=(100, 0, 1000),
                x_title=Label("LHE HT"), units="GeV"),

        ]
        return base_features + ObjectCollection(zz_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        processes += ObjectCollection([

            # ZZ SL (signal and background)
            Process("zz_sl_signal", Label("ZZ_{bb#tau#tau}"), color=(126, 238, 124), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ZZbbtt"),
            Process("zz_sl_background", Label("ZZ SL BKG"), color=(20, 60, 255), parent_process="zz", 
                    isBkgBBTT=True, ProcType="Zbb_Ztautau"),

            # ZH
            Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(130, 39, 197), parent_process="zh_hbb"),
            Process("zh_hbb", Label("zh_hbb"), color=(130, 39, 197), parent_process="zh"),
            Process("zh_htt", Label("zh_htt"), color=(130, 39, 197), parent_process="zh"),
            Process("zh", Label("ZH"), color=(130, 39, 197), parent_process="higgs", llr_name="ZH"),

            # ZZ resonant
            Process("ggXZZbbtt_M200", Label("ggX 200 GeV"), color=(238, 245, 99), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M200", parent_process="zz_res"),
            Process("ggXZZbbtt_M300", Label("ggX 300 GeV"), color=(208, 240, 120), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M300", parent_process="zz_res"),
            Process("ggXZZbbtt_M400", Label("ggX 400 GeV"), color=(179, 241, 134), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M400", parent_process="zz_res"),
            Process("ggXZZbbtt_M500", Label("ggX 500 GeV"), color=(149, 241, 147), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M500", parent_process="zz_res"),
            Process("ggXZZbbtt_M600", Label("ggX 600 GeV"), color=(126, 238, 124), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M600", parent_process="zz_res"),
            Process("ggXZZbbtt_M700", Label("ggX 700 GeV"), color=(118, 241, 156),
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M700", parent_process="zz_res"),
            Process("ggXZZbbtt_M800", Label("ggX 800 GeV"), color=(109, 243, 187), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M800", parent_process="zz_res"),
            Process("ggXZZbbtt_M900", Label("ggX 900 GeV"), color=(127, 232, 214), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M900", parent_process="zz_res"),
            Process("ggXZZbbtt_M1000", Label("ggX 1.0 TeV"), color=(122, 197, 220), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1000", parent_process="zz_res"),
            Process("ggXZZbbtt_M1100", Label("ggX 1.1 TeV"), color=(99, 173, 199), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1100", parent_process="zz_res"),
            Process("ggXZZbbtt_M1200", Label("ggX 1.2 TeV"), color=(77, 149, 167), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1200", parent_process="zz_res"),
            Process("ggXZZbbtt_M1300", Label("ggX 1.3 TeV"), color=(54, 125, 135), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1300", parent_process="zz_res"),
            Process("ggXZZbbtt_M1400", Label("ggX 1.4 TeV"), color=(30, 106, 114), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1400", parent_process="zz_res"),
            Process("ggXZZbbtt_M1500", Label("ggX 1.5 TeV"), color=(5, 87, 92), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1500", parent_process="zz_res"),
            Process("ggXZZbbtt_M2000", Label("ggX 2.0 TeV"), color=(5, 72, 76), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M2000", parent_process="zz_res"),
            Process("ggXZZbbtt_M3000", Label("ggX 3.0 TeV"), color=(5, 59, 63), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M3000", parent_process="zz_res"),
            Process("zz_res", Label("ggX"), color=(238, 245, 99)),
            
            # background for resonant analysis 
            Process("zz_bbtt", Label("ZZ_{bb#tau#tau}"), color=(0, 165, 80), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", llr_name="ZZbbtt"),
            
        ])


        process_group_names = {
        "dy_split": [
            "dy_incl",
            "dy_ptz1",
            "dy_ptz2",
            "dy_ptz3",
            "dy_ptz4",
            "dy_ptz5",
            "dy_ptz6",
            "dy_0j",
            "dy_1j",
            "dy_2j",
        ],
        "dy_incl": [
            "dy_incl",
        ],
        "dy_nj": [
            "dy_0j",
            "dy_1j",
            "dy_2j",
        ],
        "dy_ptz": [
            "dy_ptz1",
            "dy_ptz2",
            "dy_ptz3",
            "dy_ptz4",
            "dy_ptz5",
            "dy_ptz6",
        ],
        "wjets_fxfx": [ "wjets_fxfx" ],
        "wjets_mlm" : [ "wjets_mlm" ],
        "wjets_mlm_aux" : [ "wjets_mlm_aux" ],
        "wjets_fxfx_Nj": [
            "wjets_fxfx_0j",
            "wjets_fxfx_1j",
            "wjets_fxfx_2j",
        ],
        "wjets_mlm_Nj": [
            "wjets_mlm_1j",
            "wjets_mlm_2j",
            "wjets_mlm_3j",
            "wjets_mlm_4j",
        ],
        "wjets_mlm_HT": [
            "wjets_ht1",
            "wjets_ht2",
            "wjets_ht3",
            "wjets_ht4",
            "wjets_ht5",
            "wjets_ht6",
            "wjets_ht7",
            "wjets_ht8",
        ],
        "wjets_mlm_HT_aux": [
            "wjets_ht1_aux",
            "wjets_ht2_aux",
            "wjets_ht3_aux",
            "wjets_ht4_aux",
            "wjets_ht5_aux",
            "wjets_ht6_aux",
            "wjets_ht7_aux",
            "wjets_ht8_aux",
        ],
        "zz": [
            "zz_sl_signal",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "zz_res": [
            "zz_bbtt",
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "datacard_zz": [
            "zz_sl_signal",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv",
            "wh",
            "zh",
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "datacard_dnn_zz_res_200": [
            "ggXZZbbtt_M200", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_300": [
            "ggXZZbbtt_M300", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_400": [
            "ggXZZbbtt_M400", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_500": [
            "ggXZZbbtt_M500", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_600": [
            "ggXZZbbtt_M600", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_700": [
            "ggXZZbbtt_M700", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_800": [
            "ggXZZbbtt_M800", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_900": [
            "ggXZZbbtt_M900", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1000": [
            "ggXZZbbtt_M1000", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1100": [
            "ggXZZbbtt_M1100", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1200": [
            "ggXZZbbtt_M1200", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1300": [
            "ggXZZbbtt_M1300", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1400": [
            "ggXZZbbtt_M1400", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_dnn_zz_res_1500": [
            "ggXZZbbtt_M1500", "zz_bbtt", "ttH", "dy", "vvv", "vbf_htt", "ggH_ZZ", "ttx", "vv", "wh", "zh", "tw", "singlet", "ewk", "wjets", "tt", "ggf_sm", "data",
        ],
        "datacard_zz_res": [
            "zz_bbtt",
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv",
            "wh",
            "zh",
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "dnn_zz_res_200": [
            "ggXZZbbtt_M200", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_300": [
            "ggXZZbbtt_M300", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_400": [
            "ggXZZbbtt_M400", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_500": [
            "ggXZZbbtt_M500", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_600": [
            "ggXZZbbtt_M600", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_700": [
            "ggXZZbbtt_M700", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_800": [
            "ggXZZbbtt_M800", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_900": [
            "ggXZZbbtt_M900", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1000": [
            "ggXZZbbtt_M1000", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1100": [
            "ggXZZbbtt_M1100", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1200": [
            "ggXZZbbtt_M1200", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1300": [
            "ggXZZbbtt_M1300", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1400": [
            "ggXZZbbtt_M1400", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "dnn_zz_res_1500": [
            "ggXZZbbtt_M1500", "zz_bbtt", "higgs", "vv_v", "wjets", "dy", "others", "tt", "ttx", "data",
        ],
        "ggXZZbbtt": [
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
        ],
        "zz_total": [
            "zz_sl_signal",
            "dy",
            "tt",
            "wjets",
            "tth",
            "ggf_sm",
            "zz",
            "others",
        ],
        "zz_total_data": [
            "zz_sl_signal",
            "dy",
            "tt",
            "wjets",
            "tth",
            "ggf_sm",
            "zz",
            "others",
            "data",
        ],
        "zz_sig_vs_bkg": [
            "all_background",
            "zz_sl_signal",
        ],
        # "zz_res_sig_vs_bkg": [
        #     "all_background",
        #     "zz_sl_signal",
        #     "zz_res",
        # ],
        }
        return processes, process_group_names, process_training_names

