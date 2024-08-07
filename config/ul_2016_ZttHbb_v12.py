from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2016_v12 import setupBtagDeeptau, get_2016_v12_weights 
from config.ul_2016_ZH_v12 import get_datasets_ZH_2016
from config.base_config_ZttHbb import ConfigZttHbb

class Config_ul_2016_ZH_v12(ConfigZttHbb):
    def __init__(self, *args, **kwargs):
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_weights(self):
        weights = get_2016_v12_weights()
        weights.ZttHbb_elliptical_cut_90 = weights.mutau
        weights.ZttHbb_elliptical_cut_90_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_tautau = weights.mutau

        weights.ZttHbb_elliptical_cut_90_sr = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_sr_tautau = weights.mutau

        weights.ZttHbb_elliptical_cut_90_CR = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_mutau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_etau = weights.mutau
        weights.ZttHbb_elliptical_cut_90_CR_tautau = weights.mutau

        weights.ZttHbb_orthogonal_cut_90_resolved_1b = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_resolved_2b = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_boosted = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_boosted_noPNet = weights.mutau

        weights.ZttHbb_orthogonal_cut_90_CR = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_CR_resolved_1b = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_CR_resolved_2b = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_CR_boosted = weights.mutau
        weights.ZttHbb_orthogonal_cut_90_CR_boosted_noPNet = weights.mutau

        return weights

    #@override
    def add_datasets(self):
        return get_datasets_ZH_2016(self)

config = Config_ul_2016_ZH_v12("ul_2016_ZttHbb_v12", year=2016, ecm=13, lumi_pb=16800, isUL=True, AnalysisType="Ztautau_Hbb", ispreVFP=False, runPeriod="postVFP")
# https://github.com/LLRCMS/KLUBAnalysis/blob/master/config/mainCfg_ETau_UL2016.cfg#L3C8-L3C13