from config.base_config_ZbbHtt import ConfigZbbHtt as base_config_ZbbHtt
from config.bul_2016_v12 import setupBtagDeeptau #,get_2016_v12_weights
from config.bul_2016_ZH_v12 import get_datasets_ZH_2016

class Config_bul_2016_ZbbHtt_v12(base_config_ZbbHtt):
    def __init__(self, *args, **kwargs):
        self.useBoostedTaus = True
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_datasets(self):
        return get_datasets_ZH_2016(self)

config = Config_bul_2016_ZbbHtt_v12("bul_2016_ZbbHtt_v12", year=2016, ecm=13, lumi_pb=16800, isUL=True, AnalysisType="Zbb_Htautau", ispreVFP=False, runPeriod="postVFP")
