# Config for ZttHbb analysis common for all years
import itertools
import numpy as np
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict, join_root_selection as jrs
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig
from config.base_config_ZH import get_ZH_common_features, get_ZH_common_processes, resonant_masses_ZH, reduced_resonant_masses_ZH

class ConfigZttHbb(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # self.dnn = DotDict(
        #     nonresonant=DotDict(
        #         model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_03_04/ZttHbb-0",
        #         out_branch="dnn_ZHbbtt_kl_1",
        #         #systematics=["tes", "jer", "jec"]
        #     ),
        #     resonant=DotDict(
        #         model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_01_09/ResZttHbb-0/",
        #         resonant_masses=resonant_masses_ZH,
        #         out_branch="dnn_ZHbbtt_kl_1_{mass}",
        #         #systematics=["tes", "jer", "jec"]
        #     ),
        # )

    def get_dnn_config(self, category, isResonant:bool):
        """ Returns the DNN config for the given category. """
        if isResonant:
            return DotDict(
                model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_01_09/ResZttHbb-0/",
                #model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/Resbbtt-0/",
                resonant_masses=resonant_masses_ZH,
                out_branch="dnn_ZHbbtt_kl_1_{mass}",
                # systematics=["tes", "jer", "jec"]
            )
        else:
            if "boosted_bb" in category.get_aux("jet_category"):
                return DotDict(
                    model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework9/nanoaod_base_analysis/data/cmssw/CMSSW_15_0_3/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_04_17/ZttHbb_Boosted-0", 
                    out_branch="dnn_ZHbbtt_kl_1",
                    # systematics=["tes", "jer", "jec"]
                )
            elif "resolved_" in category.get_aux("jet_category"):
                return DotDict(
                    model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework9/nanoaod_base_analysis/data/cmssw/CMSSW_15_0_3/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2025_04_17/ZttHbb_Resolved-0", 
                    out_branch="dnn_ZHbbtt_kl_1",
                    # systematics=["tes", "jer", "jec"]
                )
            else: raise ValueError(category.get_aux("jet_category"))


    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        elliptical_cut_90 = ("((({{Ztt_svfit_mass}} - 85.0) * ({{Ztt_svfit_mass}} - 85.0) / ( 92.0 *  92.0)"
                " + ({{Hbb_mass}} - 115.0) * ({{Hbb_mass}} - 115.0) / (130.0 * 130.0)) < 1)")
        elliptical_cut_90_inv = f"!({elliptical_cut_90})"

        # orthogonality condition between ZbbHtt & ZttHbb
        orthogonality = "({{Hbb_mass}} > 1.33*{{Ztt_svfit_mass}} - 40)"

        # old elliptical cut pre-21/05/24
        # elliptical_cut_90 = ("((({{Ztt_svfit_mass}} - 91.) * ({{Ztt_svfit_mass}} - 91.) / (83. * 83.)"
        #         " + ({{Hbb_mass}} - 102.) * ({{Hbb_mass}} - 102.) / (143. * 143.)) < 1)")
        # elliptical_cut_90_inv = ("((({{Ztt_svfit_mass}} - 91.) * ({{Ztt_svfit_mass}} - 91.) / (83. * 83.)"
        #         " + ({{Hbb_mass}} - 102.) * ({{Hbb_mass}} - 102.) / (143. * 143.)) >= 1)")

        cat_reqs = self.get_categories_requirements()
        
        categories += ObjectCollection([

            Category("ZttHbb_elliptical_cut_90", "Elliptical cut E=90%",
                selection=elliptical_cut_90),

            # Category("ZttHbb_elliptical_cut_90_CR_mutau", "CR ZH mass cut E=90%",
            #     selection="("+elliptical_cut_90_inv+") && (pairType == 0)"),
            # Category("ZttHbb_elliptical_cut_90_CR_etau", "CR ZH mass cut E=90%",
            #     selection="("+elliptical_cut_90_inv+") && (pairType == 1)"),
            # Category("ZttHbb_elliptical_cut_90_CR_tautau", "CR ZH mass cut E=90%",
            #     selection="("+elliptical_cut_90_inv+") && (pairType == 2)"),
            
            Category("ZttHbb_orthogonal_cut_90_CR", "CR orthogonal",
                selection=f"({elliptical_cut_90_inv}) && ({orthogonality})"),
            
            # Category("ZttHbb_orthogonal_cut_90_CR_resolved_1b", "CR orthogonal & resolved 1b",
            #     selection=f"({elliptical_cut_90_inv}) && ({orthogonality})&& {cat_reqs.resolved_1b}"),
            # Category("ZttHbb_orthogonal_cut_90_CR_resolved_2b", "CR orthogonal & resolved 2b",
            #     selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && {cat_reqs.resolved_2b}"),
            # Category("ZttHbb_orthogonal_cut_90_CR_boosted", "CR orthogonal & boosted",
            #     selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && {cat_reqs.boosted}"),
            # Category("ZttHbb_orthogonal_cut_90_CR_boosted_noPNet", "CR orthogonal & boosted (no PNet cut)",
            #     selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && isBoosted == 1 "),
        ])

        for orthogonality_name, orthogonality_cut in [("EC", "true"), ("OC", orthogonality)]:
            for jet_category_idx, jet_category in [(0, "resolved_2b"), (1, "resolved_1b"), (2, "boosted_bb")]:
                for tau_category in ["HPSTau", "boostedTau"]:
                    categories.append(Category(
                        f"ZttHbb_{orthogonality_name}90_{jet_category}_{tau_category}",
                        f"{orthogonality_name}90 {jet_category} {tau_category}",
                        pre_selection=f"({cat_reqs[tau_category]})",
                        selection=f"({elliptical_cut_90}) && ({orthogonality_cut}) && (jetCategory == {jet_category_idx}) && ({cat_reqs[tau_category]})",
                        jet_category=jet_category,
                        tau_category=tau_category
                    ))
            
            categories.append(
            Category(f"ZttHbb_{orthogonality_name}90_sr", f"ZttHbb {orthogonality_name} mass cut E=90% && Signal region", # for DNN training
                    selection=jrs([
                        elliptical_cut_90,
                        orthogonality_cut,
                        jrs([
                            f"{cat_reqs['HPSTau']} && jetCategory >= 0", # HPSTaus 
                            f"{cat_reqs['boostedTau']} && jetCategory == 2" # boostedTaus : boosted_bb only
                        ], op="or"),
                        jrs([self.regions.get("etau_os_iso").selection, self.regions.get("mutau_os_iso").selection, self.regions.get("tautau_os_iso").selection], op="or")], 
                    op="and")
                    )
            )
        
        categories.append(
        Category("ZttHbb_EC90_DNNtraining", "DNN training region", # for DNN training increasing training statistics
                pre_selection=jrs([
                    "pairType>=0",
                    f"pairType != 2 || (isBoostedTau ? dau1_rawIdDeepTauVSjet >= 0.4 : dau1_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Loose})", # loosening dau1 iso in tautau a bit
                    f"isBoostedTau ? dau2_rawIdDeepTauVSjet >= {self.deepboostedtau.vsjet.VLooseQCD} : dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.VVVLoose}"
                ],
                op="and"), 
                selection=jrs([
                    elliptical_cut_90,
                    jrs([
                        f"{cat_reqs['HPSTau']} && (jetCategory >= 0 || (jetCategory==-2 && fatjet_pnet>=0.))", # HPSTaus: recover some boosted_bb events failing PNet  
                        f"{cat_reqs['boostedTau']} && (jetCategory == 2 || (jetCategory==-2 && fatjet_pnet>=0.))" # boostedTaus : boosted_bb only
                    ], op="or"),
                    "isOS",
                    "pairType>=0",
                    f"pairType != 2 || (isBoostedTau ? dau1_rawIdDeepTauVSjet >= 0.4 : dau1_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Loose})", # loosening dau1 iso in tautau a bit
                    f"isBoostedTau ? dau2_rawIdDeepTauVSjet >= {self.deepboostedtau.vsjet.VLooseQCD} : dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.VVVLoose}"
                ],
                op="and")
                )
        )

        return categories
    
    #@override
    def get_rebinning_target_bin_count(self, feature, category, region):
        """ Target bin count for FeatureHistogramRebin """
        dnn_rebinning_target_bin_count = 10
        jet_category = category.get_aux("jet_category")
        tau_category = category.get_aux("tau_category")
        region_name = region.name if region else ""

        if jet_category == "boosted_bb":
            if tau_category=="HPSTau":
                dnn_rebinning_target_bin_count = 3 # here the template fluctuations are particularly bad
            elif tau_category=="boostedTau":
                if "tautau" in region_name: dnn_rebinning_target_bin_count = 3
                else: dnn_rebinning_target_bin_count = 4
        elif jet_category == "resolved_2b":
            if "tautau" in region_name: dnn_rebinning_target_bin_count = 5
        elif jet_category == "resolved_1b":
            if "tautau" in region_name: dnn_rebinning_target_bin_count = 7
        
        return dnn_rebinning_target_bin_count
    
    #@override
    def add_features(self):
        """ Add features specific to ZH, in addition to the common ones defined in base_config.py 
        """
        base_features = super().add_features() + get_ZH_common_features(self)
        zttHbb_features = [
            # Hbb
            Feature("Hbb_pt", "Hbb_pt", binning=(40, 0, 200),
                x_title=Label("H(b#bar{b}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Hbb_eta", "Hbb_eta", binning=(20, -5., 5.),
                x_title=Label("H(b#bar{b}) #eta"), tags=["cat"]),
            Feature("Hbb_phi", "Hbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(b#bar{b}) #phi"), tags=["cat"]),
            Feature("Hbb_mass", "Hbb_mass", binning=(40, 0, 200),
                x_title=Label("H(b#bar{b}) mass"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Hbb_mass_ellipse", "Hbb_mass", binning=(50, 0, 500),
                x_title=Label("H(b#bar{b}) mass"),
                units="GeV", tags=["cat", "extra"],
                **self.jet_systs_params),

            # Ztt
            Feature("Ztt_pt", "Ztt_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.didau_systs_params),
            Feature("Ztt_eta", "Ztt_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}) #eta"), tags=["cat"]),
            Feature("Ztt_phi", "Ztt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}) #phi"), tags=["cat"]),
            Feature("Ztt_mass", "Ztt_mass", binning=(30, 0, 150),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass"), tags=["cat"],
                units="GeV",
                **self.didau_systs_params),

            # Ztt + met
            Feature("Ztt_met_pt", "Ztt_met_pt", binning=(15, 50, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_eta", "Ztt_met_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #eta"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_phi", "Ztt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) #phi"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_met_mass", "Ztt_met_mass", binning=(25, 0, 500),
                x_title=Label("Z(#tau^{+}#tau^{-}+MET) mass"), tags=["cat"],
                units="GeV",
                systematics=self.all_systs),

            # Ztt (SVFit)
            Feature("Ztt_svfit_pt", "Xtt_svfit_pt", binning=(15, 50, 200),
                x_title=Label("Z(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Ztt_svfit_eta", "Xtt_svfit_eta", binning=(20, -5., 5.),
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
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"), tags=["cat", "extra"],
                units="GeV",
                systematics=self.all_systs),
        ]
        return base_features + ObjectCollection(zttHbb_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        zh_processes, zh_process_group_names, zh_process_training_names = get_ZH_common_processes()
        processes += zh_processes
        process_group_names.update(zh_process_group_names)
        process_training_names.update(zh_process_training_names)

        resonant_dataset_names = [f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in resonant_masses_ZH]
        resonant_dataset_names_reduced = [f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in reduced_resonant_masses_ZH]

        process_group_names.update({
        "Zprime_Zh_Ztautauhbb": resonant_dataset_names,
        "plot": [
            "zh_ztt_hbb_signal",
            "higgs", # includes zh_ztt_hbb & zh_ztt_hbb_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "plot_res": [
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in resonant_masses_ZH],
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH],
            "higgs", # includes zh_ztt_hbb & zh_zbb_htt_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "plot_res_reduced": [ # smaller number of mass points to avoid cluttering plot
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in reduced_resonant_masses_ZH],
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in reduced_resonant_masses_ZH],
            "higgs", # includes zh_zbb_htt and zh_zbb_htt_background
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "zh_split_signal": [
            "zh_ztt_hbb_signal",
            "zh_ztt_hbb_background",         
        ],
        "zh_sig_vs_bkg": [
            "all_background",
            "zh_ztt_hbb_signal",
        ],
        })     
        return processes, process_group_names, process_training_names