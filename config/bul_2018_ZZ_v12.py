from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config_ZZ import Config as base_config_ZZ, res_mass_ZZ
from config.bul_2018_v12 import setupBtagDeeptau, get_common_datasets_v12, get_2018_v12_weights 

class Config_bul_2018_ZZ_v12(base_config_ZZ):
    def __init__(self, *args, **kwargs):
        self.useBoostedTaus = True
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2018_v12_weights()
        print(self.categories)
        for category in self.categories:
            weights[category.name] = weights.mutau
        
        weights.base_noWeights = ["genWeight", "DYstitchWeight"]
        # weights.ZZ_elliptical_cut_90 = weights.mutau
        # weights.ZZ_elliptical_cut_90_sr = weights.mutau
        # weights.ZZ_elliptical_cut_90_etau = weights.mutau
        # weights.ZZ_elliptical_cut_90_mutau = weights.mutau
        # weights.ZZ_elliptical_cut_90_tautau = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_etau = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_mutau = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_tautau = weights.mutau
        # weights.ZZ_elliptical_cut_80_CR_etau = weights.mutau
        # weights.ZZ_elliptical_cut_90_resolved_1b = weights.mutau
        # weights.ZZ_elliptical_cut_90_resolved_2b = weights.mutau
        # weights.ZZ_elliptical_cut_90_boosted = weights.mutau
        # weights.ZZ_elliptical_cut_90_boosted_noPNet = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_resolved_1b = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_resolved_2b = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR_boosted_noPNet = weights.mutau
        # weights.ZZ_elliptical_cut_90_CR = weights.mutau

        return weights

    #@override
    def add_datasets(self):
        datasets = get_common_datasets_v12(self)

        # ZZ datasets
        # ZZ_SL is split in 2 processes :
        # - zz_sl_signal (with filter for bbtautau decay) 
        # - zz_sl_background (with inverted filter)
        # ZHToTauTau is considered as background
        # ZH_Hbb_Zll is considered as background

        p = "/eos/grif/cms/llr/store/user/tcuisset/boostedTaus/2018_MC/"
        datasets += ObjectCollection([

            ###################################### ZZ Signal ##############################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_signal",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_signal"),
                xs=self.cross_section_dict["zz_sl"],
                #secondary_dataset="zz_sl_signal_aux",
                prefix="eos.grif.fr//",
                tags=["ul", "nanoV10", "bul", "genfilter"]),

            ###################################### ZZ Background ##########################################
            ###############################################################################################

            #### ZZ_SL
            Dataset("zz_sl_background",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_sl_background"),
                xs=self.cross_section_dict["zz_sl"],
                #secondary_dataset="zz_sl_background_aux",
                # categorization_max_events=10000,
                prefix="eos.grif.fr//",
                tags=["ul", "nanoV10", "bul", "genfilter"]),
            
            #### ZHToTauTau
            Dataset("zh_htt",
                folder=p + "ZHToTauTau_M125",
                process=self.processes.get("zh_htt"),
                xs=self.cross_section_dict["zh_htt"],
                #secondary_dataset="zh_htt_aux",
                # categorization_max_events=10000,
                prefix="eos.grif.fr//",
                tags=["ul", "nanoV10", "bul"]), 

            #### ZH_Hbb_Zll
            Dataset("zh_hbb_zll",
                folder=p + "ZH_Hbb_Zll",
                process=self.processes.get("zh_hbb"),
                xs=self.cross_section_dict["zh_hbb_zll"],
                #secondary_dataset="zh_hbb_zll_aux",
                # categorization_max_events=10000,
                prefix="eos.grif.fr//",
                tags=["ul", "nanoV10", "bul"]),

            #### ZZ_SL but considered as background for the resonant analysis
            Dataset("zz_bbtt",
                folder=p + "ZZTo2Q2L",
                process=self.processes.get("zz_bbtt"),
                xs=self.cross_section_dict["zz_sl"],
                #secondary_dataset="zz_bbtt_aux",
                # categorization_max_events=10000,
                prefix="eos.grif.fr//",
                tags=["ul", "nanoV10", "bul", "res", "genfilter"]),

            ###################################### ZZ Resonant ############################################
            ###############################################################################################

            #### ZZ Resonance high mass

            *(
            Dataset(f"GluGluToXToZZTo2B2Tau_M{mass}",
                folder=p + f"GluGluToXToZZTo2B2Tau_M-{mass}",
                process=self.processes.get(f"ggXZZbbtt_M{mass}"),
                prefix="eos.grif.fr//",
                xs=1,
                tags=["ul", "nanoV10", "bul", "res"])
            
            for mass in res_mass_ZZ
            )

        ])
            
        return datasets

    # if I don't want to specify the version every time
    # def add_version(self):
    #     versions = {"MergeCategorizationStats": "prod_503"}
    #     return versions

config = Config_bul_2018_ZZ_v12("bul_2018_ZZ_v12", year=2018, ecm=13, lumi_pb=59741, isUL=True, AnalysisType="Zbb_Ztautau")
