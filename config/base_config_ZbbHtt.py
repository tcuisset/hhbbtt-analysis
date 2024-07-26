# Config for ZbbHtt analysis common for all years
import itertools
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict, join_root_selection as jrs
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig
from config.base_config_ZH import get_ZH_common_features, get_ZH_common_processes, resonant_masses_ZH, reduced_resonant_masses_ZH

class ConfigZbbHtt(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.dnn = DotDict(
            nonresonant=DotDict(
                model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/ZbbHtt-0",
                out_branch="dnn_ZHbbtt_kl_1",
                #systematics=["tes", "jer", "jec"]
            ),
            resonant=DotDict(
                model_folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/models/arc_checks/zz_bbtt/2024-05-10/ResZbbHtt-0/",
                resonant_masses=resonant_masses_ZH,
                out_branch="dnn_ZHbbtt_kl_1_{mass}",
                #systematics=["tes", "jer", "jec"]
            ),
        )

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        elliptical_cut_90 = ("((({{Htt_svfit_mass}} - 125.0) * ({{Htt_svfit_mass}} - 125.0) / (100.0 * 100.0)"
                " + ({{Zbb_mass}} - 85.0) * ({{Zbb_mass}} - 85.0) / (131.0 * 131.0)) < 1)")
        elliptical_cut_90_inv = f"!({elliptical_cut_90})"

        # orthogonality condition between ZbbHtt & ZttHbb
        orthogonality = "({{Zbb_mass}} <= 1.33*{{Htt_svfit_mass}} - 40)"

        # old elliptical cut pre-21/05/24
        # elliptical_cut_90 = ("((({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
        #         " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) < 1)")
        # elliptical_cut_90_inv = ("((({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.) / (113. * 113.)"
        #         " + ({{Zbb_mass}} - 80.) * ({{Zbb_mass}} - 80.) / (93. * 93.)) >= 1)")
        sr_cut = ("(((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 2) && (isOS == 1) && "
                    "(dau1_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0}))) "
                    .format(self.deeptau.vsjet.Medium))
        bjets = self.get_bjets_requirements()
        cat_reqs = self.get_categories_requirements()

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
            
            # Category("ZbbHtt_ttCR", "ttbar CR", # inverted elliptical mass cut + 2 resolved b jets
            #     selection=f"({elliptical_cut_90_inv}) && !isBoosted &&"
            #     f"Jet_btagDeepFlavB.at(bjet1_JetIdx) > {self.btag_algo_wps['medium']} && "
            #     f"Jet_btagDeepFlavB.at(bjet2_JetIdx) > {self.btag_algo_wps['medium']}"),

            Category("ZbbHtt_elliptical_cut_90_resolved_1b", "EC90 & resolved 1b",
                selection=f"({elliptical_cut_90}) && {cat_reqs.resolved_1b}"),
            Category("ZbbHtt_elliptical_cut_90_resolved_2b", "EC90 & resolved 2b",
                selection=f"({elliptical_cut_90}) && {cat_reqs.resolved_2b}"),
            Category("ZbbHtt_elliptical_cut_90_boosted", "EC90 & boosted",
                selection=f"({elliptical_cut_90}) && {cat_reqs.boosted}"),
            # Category("ZbbHtt_elliptical_cut_90_boosted_noPNet", "EC90 & boosted (no PNet cut)",
            #     selection=f"({elliptical_cut_90}) && isBoosted == 1 "),
            
            Category("ZbbHtt_orthogonal_cut_90_resolved_1b", "EC90 orthogonal & resolved 1b",
                selection=f"({elliptical_cut_90}) && ({orthogonality}) && {cat_reqs.resolved_1b}"),
            Category("ZbbHtt_orthogonal_cut_90_resolved_2b", "EC90 orthogonal & resolved 2b",
                selection=f"({elliptical_cut_90}) && ({orthogonality}) && {cat_reqs.resolved_2b}"),
            Category("ZbbHtt_orthogonal_cut_90_boosted", "EC90 orthogonal & boosted", boosted=True,
                selection=f"({elliptical_cut_90}) && ({orthogonality}) && {cat_reqs.boosted}"),
            Category("ZbbHtt_orthogonal_cut_90_boosted_noPNet", "EC90 orthogonal & boosted (no PNet cut)",
                selection=f"({elliptical_cut_90}) && ({orthogonality}) && isBoosted == 1 "),
            
            Category("ZbbHtt_orthogonal_cut_90_CR", "CR orthogonal",
                selection=f"({elliptical_cut_90_inv}) && ({orthogonality})"),
            
            Category("ZbbHtt_orthogonal_cut_90_CR_resolved_1b", "CR orthogonal & resolved 1b",
                selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && {cat_reqs.resolved_1b}"),
            Category("ZbbHtt_orthogonal_cut_90_CR_resolved_2b", "CR orthogonal & resolved 2b",
                selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && {cat_reqs.resolved_2b}"),
            Category("ZbbHtt_orthogonal_cut_90_CR_boosted", "CR orthogonal & boosted", boosted=True,
                selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && {cat_reqs.boosted}"),
            # Category("ZbbHtt_orthogonal_cut_90_CR_boosted_noPNet", "CR orthogonal & boosted (no PNet cut)",
            #     selection=f"({elliptical_cut_90_inv}) && ({orthogonality}) && isBoosted == 1 "),
        ])

        return categories
    
    #@override
    def add_features(self):
        """ Add features specific to ZH, in addition to the common ones defined in base_config.py 
        There are features for both ZbbHtt and ZttHbb analyses. TODO split them
        """
        base_features = super().add_features() + get_ZH_common_features(self)
        zbttHtt_features = [
            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(15, 50, 200),
                x_title=Label("Z(b#bar{b}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Zbb_eta", "Zbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b#bar{b}) #eta"), tags=["cat"]),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b#bar{b}) #phi"), tags=["cat"]),
            Feature("Zbb_mass", "Zbb_mass", binning=(30, 0, 250),
                x_title=Label("Z(b#bar{b}) mass"),
                units="GeV", tags=["cat"],
                **self.jet_systs_params),
            Feature("Zbb_mass_ellipse", "Zbb_mass", binning=(50, 0, 500),
                x_title=Label("Z(b#bar{b}) mass"), central="jet_smearing",
                units="GeV", tags=["cat", "extra"]), # no systematics here (for 2D plot)
            
            # Htt
            Feature("Htt_pt", "Htt_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+}#tau^{-}) p_{T}"),
                units="GeV", tags=["cat"],
                **self.didau_systs_params),
            Feature("Htt_eta", "Htt_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta"), tags=["cat"]),
            Feature("Htt_phi", "Htt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}) #phi"), tags=["cat"]),
            Feature("Htt_mass", "Htt_mass", binning=(30, 0, 150),
                x_title=Label("H(#tau^{+}#tau^{-}) mass"), tags=["cat"],
                units="GeV",
                **self.didau_systs_params),
            
            # Htt + met
            Feature("Htt_met_pt", "Htt_met_pt", binning=(15, 50, 200),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) p_{T}"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_met_eta", "Htt_met_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #eta"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_met_phi", "Htt_met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) #phi"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_met_mass", "Htt_met_mass", binning=(25, 0, 500),
                x_title=Label("H(#tau^{+}#tau^{-}+MET) mass"), tags=["cat"],
                units="GeV",
                systematics=self.all_systs),
            
            # Htt (SVFit)
            Feature("Htt_svfit_pt", "Xtt_svfit_pt", binning=(15, 50, 200),
                x_title=Label("H(#tau^{+}#tau^{-}) p_{T} (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_svfit_eta", "Xtt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+}#tau^{-}) #eta (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_svfit_phi", "Xtt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+}#tau^{-}) #phi (SVFit)"), tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_svfit_mass", "Xtt_svfit_mass", binning=(25, 1, 501),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV", tags=["cat"],
                systematics=self.all_systs),
            Feature("Htt_svfit_mass_ellipse", "Xtt_svfit_mass", binning=(35, 0, 350),
                x_title=Label("H(#tau^{+}#tau^{-}) mass (SVFit)"),
                units="GeV", tags=["cat", "extra"],
                systematics=self.all_systs),
        ]
        return base_features + ObjectCollection(zbttHtt_features)

    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        zh_processes, zh_process_group_names, zh_process_training_names = get_ZH_common_processes()
        processes += zh_processes
        process_group_names.update(zh_process_group_names)
        process_training_names.update(zh_process_training_names)

        resonant_dataset_names = [f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH]
        resonant_dataset_names_reduced = [f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in reduced_resonant_masses_ZH]

        process_group_names.update({
        "Zprime_Zh_Zbbhtt": resonant_dataset_names,
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
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH],
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in resonant_masses_ZH],
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
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in reduced_resonant_masses_ZH],
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in reduced_resonant_masses_ZH],
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
            "zh_zbb_htt_signal",
            "zh_zbb_htt_background",       
        ],
        "zh_sig_vs_bkg": [
            "all_background",
            "zh_zbb_htt_signal",
        ],
        })
        return processes, process_group_names, process_training_names