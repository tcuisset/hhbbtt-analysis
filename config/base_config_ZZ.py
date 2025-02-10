""" Base configuration for X->ZZ->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict, join_root_selection as jrs
from plotting_tools import Label
import itertools
import numpy as np

from config.base_config import get_common_processes, BaseConfig

res_mass_ZZ = [ 200, 210, 220, 230, 240, 250, 260, 270, 280, 300, 320, 350, 360, 400, 450, 500, 550,
                600, 650, 700, 750, 800, 850, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700,
                1800, 1900, 2000, 2200, 2400, 2500, 2600, 2800, 3000, 3500, 4000, 4500, 5000]
res_mass_ZZ_limited = [200, 1000, 2000, 3000, 4000, 5000]

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.dnn = DotDict(
            nonresonant=DotDict(
                # model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/ZZbbtt-0",
                model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/ZZbbtt-0-newFeatureNames",
                out_branch="dnn_ZZbbtt_kl_1",
                # systematics=["tes", "jer", "jec"]
            ),
            resonant=DotDict(
                model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_01_09/ResZZbbtt-0/",
                #model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/ResZZbbtt-0/",
                resonant_masses=res_mass_ZZ,
                out_branch="dnn_ZZbbtt_kl_1_{mass}",
                # systematics=["tes", "jer", "jec"]
            ),
        )

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        # ARCHIVE
        # 80% elliptical cut
        #({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
            #         " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1)
        # old elliptical cut pre-21/05/24
        elliptical_cut_90_old = ("(({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                    " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) < 1)")
        elliptical_cut_90_inv_old = ("(({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (126. * 126.)"
                " + ({{Zbb_mass}} - 81.) * ({{Zbb_mass}} - 81.) / (142. * 142.)) >= 1)")
        
        elliptical_cut_90 = ("((({{Ztt_svfit_mass}} - 95.0) * ({{Ztt_svfit_mass}} - 95.0) / (120 * 120)"
                    " + ({{Zbb_mass}} - 85.0) * ({{Zbb_mass}} - 85.0) / (165.5 * 165.5)) < 1)")
        elliptical_cut_90_inv = f"!({elliptical_cut_90})"
        
        bjets = self.get_bjets_requirements()
        cat_reqs = self.get_categories_requirements()

        categories += ObjectCollection([
            Category("ZZ_elliptical_cut_90", "Elliptical cut E=90%",
                selection=elliptical_cut_90),

            Category("ZZ_elliptical_cut_90_CR", "CR ZZ mass cut E=90%",
                selection=elliptical_cut_90_inv),

            # Category("ZZ_elliptical_cut_90_CR_resolved_1b", "CR & resolved 1b",
            #     selection=f"({elliptical_cut_90_inv}) && ({cat_reqs.resolved_1b})"),
            # Category("ZZ_elliptical_cut_90_CR_resolved_2b", "CR & resolved 2b",
            #     selection=f"({elliptical_cut_90_inv}) && ({cat_reqs.resolved_2b})"),
            # Category("ZZ_elliptical_cut_90_CR_boosted", "CR & boosted",
            #     selection=f"({elliptical_cut_90_inv}) && ({cat_reqs.boosted})"),
        ])

        #all_categories_selections = []
        for jet_category_idx, jet_category in [(0, "resolved_2b"), (1, "resolved_1b"), (2, "boosted_bb")]:
            for tau_category in ["HPSTau", "boostedTau"]:
                categories.append(Category(
                    f"ZZ_EC90_{jet_category}_{tau_category}",
                    f"EC90 {jet_category} {tau_category}",
                    selection=f"({elliptical_cut_90}) && (jetCategory == {jet_category_idx}) && ({cat_reqs[tau_category]})", # ({cat_reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail[jet_category]})
                    jet_category=jet_category#"boosted" if jet_category == "boosted_bb" else "resolved"
                ))
            #all_categories_selections.append(f"({cat_reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail[jet_category]}) && ({cat_reqs[tau_category]})")
        
        
        categories.append(
        Category("ZZ_elliptical_cut_90_sr", "ZZ mass cut E=90% && Signal region", # for DNN training
                selection=jrs([
                    elliptical_cut_90,
                    jrs([
                        f"{cat_reqs['HPSTau']} && jetCategory >= 0", # HPSTaus 
                        f"{cat_reqs['boostedTau']} && jetCategory == 2" # boostedTaus : boosted_bb only
                    ], op="or"),
                    jrs([self.regions.get("etau_os_iso").selection, self.regions.get("mutau_os_iso").selection, self.regions.get("tautau_os_iso").selection], op="or")],
                op="and")
                )
        )

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
            # Feature("pairType", "pairType", binning=(5, 0, 4),
            #     x_title=Label("Pair Type")),

            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(40, 0, 200),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Zbb_pt_high", "Zbb_pt", binning=(40, 0, 800),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Zbb_eta", "Zbb_eta", binning=(30, -4., 4.),
                x_title=Label("Z(b#bar{b}) #eta"), tags=["cat"]),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b#bar{b}) #phi"), tags=["cat"]),
            Feature("Zbb_mass", "Zbb_mass", binning=(30, 0, 250),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Zbb_mass_ellipse", "Zbb_mass", binning=(50, 0, 500),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),

            # Ztt
            Feature("Ztt_pt", "Ztt_pt", binning=(40, 0, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.didau_systs_params),
            Feature("Ztt_pt_high", "Ztt_pt", binning=(40, 0, 800),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.didau_systs_params),
            Feature("Ztt_eta", "Ztt_eta", binning=(30, -4., 4.),
                x_title=Label("Z(#tau^{+}#tau^{-}) #eta"), tags=["cat"]),
            Feature("Ztt_phi", "Ztt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi"), tags=["cat"]),
            Feature("Ztt_mass", "Ztt_mass", binning=(40, 0, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass"),
                units="GeV", tags=["cat"],
                **self.didau_systs_params),

            # Ztt + met
            Feature("Ztt_met_pt", "Ztt_met_pt", binning=(40, 0, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_pt_high", "Ztt_met_pt", binning=(40, 0, 800),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_eta", "Ztt_met_eta", binning=(20, -4., 4.),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #eta"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_phi", "Ztt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #phi"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_mass", "Ztt_met_mass", binning=(25, 0, 500),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),

            # Ztt (SVFit)
            Feature("Ztt_svfit_pt", "Xtt_svfit_pt", binning=(40, 0, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_svfit_pt_high", "Xtt_svfit_pt", binning=(40, 0, 800),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_svfit_eta", "Xtt_svfit_eta", binning=(20, -4., 4.),
                x_title=Label("Z(#tau^{+}#tau^{-}) #eta (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_svfit_phi", "Xtt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_svfit_mass", "Xtt_svfit_mass", binning=(25, 0, 250),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"), tags=["cat"],
                units="GeV",
                systematics=self.all_systs),
            Feature("Ztt_svfit_mass_ellipse", "Xtt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"), tags=["cat"],
                units="GeV",
                systematics=self.all_systs),

            # ZZ
            Feature("ZZ_pt", "ZZ_pt", binning=(30, 0, 300),
                x_title=Label("ZZ p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_pt_high", "ZZ_pt", binning=(30, 0, 800),
                x_title=Label("ZZ p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_eta", "ZZ_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta"), tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_phi", "ZZ_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi"), tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_mass", "ZZ_mass", binning=(50, 0, 1000),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_mass_low", "ZZ_mass", binning=(24, 0, 1200),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_mass_high", "ZZ_mass", binning=(100, 0, 5000),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_mass_fine", "ZZ_mass", binning=(600, 0, 3000),
                x_title=Label("ZZ_{bb#tau#tau} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),

            # ZZ (SVFit)
            Feature("ZZ_svfit_pt", "ZZ_svfit_pt", binning=(30, 0, 330),
                x_title=Label("ZZ p_{T} (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_eta", "ZZ_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_phi", "ZZ_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_mass", "ZZ_svfit_mass", binning=(50, 150, 1150),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_mass_fine", "ZZ_svfit_mass", binning=(600, 0, 3000),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_mass_res_high", "ZZ_svfit_mass", binning=(100, 150, 5150),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_mass_res_veryHigh", "ZZ_svfit_mass", binning=(30, 150, 5500),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZ_svfit_mass_res_veryHigh_varBin", "ZZ_svfit_mass", binning=[0., 700., 900., 1100., 1400., 1800., 2500., 5000.],
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit} mass"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),

            # ZZ KinFit
            Feature("ZZKinFit_mass", "ZZKinFit_mass", binning=(50, 150, 1150),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_mass_fit_1", "ZZKinFit_mass", binning=(20, 180, 780),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_mass_fit_2", "ZZKinFit_mass", binning=(24, 180, 780),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_mass_res", "ZZKinFit_mass", binning=(50, 150, 1650),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_mass_res_low", "ZZKinFit_mass", binning=(37, 150, 1260),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_mass_res_high", "ZZKinFit_mass", binning=(100, 150, 5150),
                x_title=Label("ZZ mass (Kin. Fit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("ZZKinFit_chi2", "ZZKinFit_chi2", binning=(30, 0, 50),
                x_title=Label("ZZ #chi^{2} (Kin. Fit)"), tags=["cat"],
                systematics=self.all_systs),
            
            *[Feature(f"dnn_ZZbbtt_{nbins}b", "dnn_ZZbbtt_kl_1", binning=(nbins, 0, 1),
                x_title=Label("DNN ZZ"), tags=["dnn", "blind"], no_save_bin_yields=True,
                systematics=self.all_systs)
            for nbins in [10, 30, 100, 500]],
            
            *[Feature(f"dnn_ZZbbtt_{nbins}b_M{mass}", f"dnn_ZZbbtt_kl_1_{mass}", binning=(nbins, 0, 1), tags=["dnn", "dnn_res", "blind", f"dnn_res_M{mass}"] + (["dnn_limited"] if mass in res_mass_ZZ_limited else []),
                x_title=Label(f"PNN ZZ {mass} GeV" if mass < 1000 else f"PNN ZZ {mass/1000:g} TeV"), no_save_bin_yields=True,
                systematics=self.all_systs)
            for mass in res_mass_ZZ for nbins in [10, 100]],

            *[Feature(f"dnn_ZZbbtt_{nbins}bv_M{mass}", f"dnn_ZZbbtt_kl_1_{mass}", # variable binning version for auto-rebin algorithm
                binning=np.concatenate([np.linspace(0., 0.5, int(nbins/10), endpoint=False), np.linspace(0.5, 0.8, int(2./10.*nbins), endpoint=False), np.linspace(0.8, 0.9, int(3/10*nbins), endpoint=False), np.linspace(0.9, 1., int(4/10*nbins), endpoint=True)]),
                x_title=Label(f"PNN ZZ {mass} GeV" if mass < 1000 else f"PNN ZZ {mass/1000:g} TeV"),  tags=["dnn", "dnn_res", "blind", f"dnn_res_M{mass}"] + (["dnn_limited"] if mass in res_mass_ZZ_limited else []),
                systematics=self.all_systs, no_save_bin_yields=True)
            for mass in res_mass_ZZ for nbins in [500]],

        ]
        return base_features + ObjectCollection(zz_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        colors_res = itertools.cycle([(31, 0, 117), (4, 41, 100), (0, 55, 101), (0, 66, 106), (0, 78, 110), (0, 88, 113), (0, 99, 115), (0, 109, 115), (0, 119, 114), (0, 129, 111), (0, 139, 105), (14, 148, 99), (48, 155, 92), (78, 161, 84), (103, 165, 76), (127, 169, 68), (151, 172, 60), (174, 174, 55)])
        
        processes += ObjectCollection([

            # ZZ SL (signal and background)
            # zz_sl_signal : removes everything not decaying to bbtautau, removes ZH contribution (ZH is included with ZHToTauTau dataset)
            # (includes : Z->bb,Z->tautau / Z->bb,Z/gamma->tautau)
            Process("zz_sl_signal", Label("ZZ_{bb#tau#tau}"), color=(0, 165, 80), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", removeZH=True, isSignal=True, llr_name="ZZbbtt", fatjet_bb_type="HHlike"),
            # zz_sl_background : ZZ / ZZ/gamma decaying to 2L2Q except bbtautau
            Process("zz_sl_background", Label("ZZ SL BKG"), color=(20, 60, 255), parent_process="zz", 
                    isBkgBBTT=True, ProcType="Zbb_Ztautau"),

            # ZH
            Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(130, 39, 197), parent_process="zh_hbb"),
            Process("zh_hbb", Label("zh_hbb"), color=(130, 39, 197), parent_process="zh"),
            Process("zh_htt", Label("zh_htt"), color=(130, 39, 197), parent_process="zh"),
            Process("zh", Label("ZH"), color=(130, 39, 197), parent_process="higgs", llr_name="ZH", fatjet_bb_type="DYlike"),

            # ZZ resonant
            *[Process(f"ggXZZbbtt_M{mass}", Label(f"ggX {mass} GeV" if mass < 1000 else f"ggX {mass/1000:g} TeV"), color=next(colors_res), 
                    isSignal=True, llr_name="ggXZZbbtt", fatjet_bb_type="HHlike")
            for mass in [ 200, 210, 220, 230, 240, 250, 260, 270, 280, 300, 320, 350, 360, 400, 450, 500, 550,
                600, 650, 700, 750, 800, 850, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700,
                1800, 1900, 2000, 2200, 2400, 2500, 2600, 2800, 3000, 3500, 4000, 4500, 5000]],

            # # ZZ resonant
            # Process("ggXZZbbtt_M200", Label("ggX 200 GeV"), color=(238, 245, 99), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M200", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M300", Label("ggX 300 GeV"), color=(208, 240, 120), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M300", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M400", Label("ggX 400 GeV"), color=(179, 241, 134), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M400", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M500", Label("ggX 500 GeV"), color=(149, 241, 147), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M500", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M600", Label("ggX 600 GeV"), color=(126, 238, 124), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M600", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M700", Label("ggX 700 GeV"), color=(118, 241, 156),
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M700", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M800", Label("ggX 800 GeV"), color=(109, 243, 187), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M800", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M900", Label("ggX 900 GeV"), color=(127, 232, 214), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M900", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1000", Label("ggX 1.0 TeV"), color=(122, 197, 220), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1000", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1100", Label("ggX 1.1 TeV"), color=(99, 173, 199), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1100", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1200", Label("ggX 1.2 TeV"), color=(77, 149, 167), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1200", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1300", Label("ggX 1.3 TeV"), color=(54, 125, 135), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1300", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1400", Label("ggX 1.4 TeV"), color=(30, 106, 114), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1400", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M1500", Label("ggX 1.5 TeV"), color=(5, 87, 92), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M1500", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M2000", Label("ggX 2.0 TeV"), color=(5, 72, 76), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M2000", parent_process="ZZbbtt"),
            # Process("ggXZZbbtt_M3000", Label("ggX 3.0 TeV"), color=(5, 59, 63), 
            #         isSigBBTT=True, ProcType="Zbb_Ztautau", isSignal=True, llr_name="ggXZZbbtt_M3000", parent_process="ZZbbtt"),
            # Process("zz_res", Label("ggX"), color=(238, 245, 99)),
            
            # background for resonant analysis 
            Process("zz_bbtt", Label("ZZ_{bb#tau#tau}"), color=(0, 165, 80), 
                    isSigBBTT=True, ProcType="Zbb_Ztautau", llr_name="ZZbbtt", fatjet_bb_type="DYlike"),
            
        ])

        process_group_names |= {
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
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ],
            "zz_bbtt",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "zz_res_limitedMass": [
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ_limited],
            "zz_bbtt",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "zz_full" : [
            'ewk_wminus',
            'ewk_wplus',
            'ewk_z',
            'ggH_ZZ',
            'ggf_sm',
            'singlet',
            'tt_dl',
            'tt_fh',
            'tt_sl',
            'tth_bb',
            'tth_tautau',
            'ttw',
            'ttwh',
            'ttww',
            'ttwz',
            'ttz',
            'ttzh',
            'ttzz',
            'tw',
            'wh_htt',
            "dy",
            "wjets",
            # 'wjets_ht1',
            # 'wjets_ht2',
            # 'wjets_ht3',
            # 'wjets_ht4',
            # 'wjets_ht5',
            # 'wjets_ht6',
            # 'wjets_ht7',
            # 'wjets_ht8',
            # 'wjets_mlm',
            'ww',
            'www',
            'wwz',
            'wz',
            'wzz',
            'zh_hbb',
            'zh_htt',
            'zz',
            'zz_bbtt',
            'zz_sl_background',
            'zz_sl_signal',
            'zzz',
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ],
            "data"],
        "datacard_zz": [
            "zz_sl_signal",
            "ttH",
            "dy",
            "vvv",
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
        "datacard_zz_res": [
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ],
            "zz_bbtt",
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
        "datacard_zz_res_reduced": [
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ],
            "zz_bbtt",
            "tt",
            "dy",
            "wjets",
            "vv_v",
            "ttx",
            "higgs", # include wh, vbf_htt, ggH_ZZ, ttH, zh, ggf_sm
            "others", #inlucde ewk, tw, singlet
            "data",
        ],
        "ggXZZbbtt": [
            *[f"ggXZZbbtt_M{mass}" for mass in res_mass_ZZ],
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
        "zz_res_sig_vs_bkg": [
            "all_background",
            "zz_sl_signal",
            "zz_res",
        ],
        }
        process_group_names |= {
            f"datacard_zz_res_reduced_M{mass}": [
                f"ggXZZbbtt_M{mass}",
                "zz_bbtt",
                "tt",
                "dy",
                "wjets",
                "vv_v",
                "ttx",
                "higgs", # include wh, vbf_htt, ggH_ZZ, ttH, zh, ggf_sm
                "others", #inlucde ewk, tw, singlet
                "data",
            ] for mass in res_mass_ZZ
        }
        return processes, process_group_names, process_training_names

