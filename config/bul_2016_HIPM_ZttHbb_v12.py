from config.base_config_ZttHbb import ConfigZttHbb as base_config_ZttHbb
from config.bul_2016_HIPM_v12 import setupBtagDeeptau #,get_2016_HIPM_v12_weights
from config.bul_2016_HIPM_ZH_v12 import get_datasets_ZH_2016_HIPM

class Config_bul_2016_HIPM_ZttHbb_v12(base_config_ZttHbb):
    def __init__(self, *args, **kwargs):
        self.useBoostedTaus = True
        setupBtagDeeptau(self)
        super().__init__(*args, **kwargs)

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    def add_datasets(self):
        return get_datasets_ZH_2016_HIPM(self)

config = Config_bul_2016_HIPM_ZttHbb_v12("bul_2016_HIPM_ZttHbb_v12", year=2016, ecm=13, lumi_pb=19500, isUL=True, ispreVFP=True, runPeriod="preVFP", AnalysisType="Ztautau_Hbb")
