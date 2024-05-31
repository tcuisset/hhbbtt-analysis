from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2017_v12 import setupBtagDeeptau, get_2017_v12_weights
from config.ul_2017_ZH_v12 import get_datasets_ZH_2017
from config.base_config_ZbbHtt import ConfigZbbHtt

class Config_ul_2017_ZH_v12(ConfigZbbHtt):
    def __init__(self, *args, **kwargs):
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

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
        
        weights.ZbbHtt_elliptical_cut_90_CR = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_mutau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_etau = weights.mutau
        weights.ZbbHtt_elliptical_cut_90_CR_tautau = weights.mutau

        weights.ZbbHtt_orthogonal_cut_90_resolved_1b = weights.mutau
        weights.ZbbHtt_orthogonal_cut_90_resolved_2b = weights.mutau
        weights.ZbbHtt_orthogonal_cut_90_boosted = weights.mutau
        weights.ZbbHtt_orthogonal_cut_90_boosted_noPNet = weights.mutau
        
        return weights

    #@override
    def add_datasets(self):
        return get_datasets_ZH_2017(self)

config = Config_ul_2017_ZH_v12("ul_2017_ZbbHtt_v12", year=2017, ecm=13, lumi_pb=41529, isUL=True, AnalysisType="Zbb_Htautau")
# https://github.com/LLRCMS/KLUBAnalysis/blob/master/config/mainCfg_ETau_Legacy2017.cfg#L3