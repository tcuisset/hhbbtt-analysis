from config.base_config_ZttHbb import ConfigZttHbb as base_config_ZttHbb
from config.bul_2017_v12 import setupBtagDeeptau #,get_2017_v12_weights
from config.bul_2017_ZH_v12 import get_datasets_ZH_2017

class Config_bul_2017_ZttHbb_v12(base_config_ZttHbb):
    def __init__(self, *args, **kwargs):
        self.useBoostedTaus = True
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_datasets(self):
        return get_datasets_ZH_2017(self)

config = Config_bul_2017_ZttHbb_v12("bul_2017_ZttHbb_v12", year=2017, ecm=13, lumi_pb=41529, isUL=True, AnalysisType="Ztautau_Hbb")
