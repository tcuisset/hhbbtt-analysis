from types import MethodType
import copy

from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.ul_2018_ZZ_v10 import config as config_ul_2018_ZZ_v10, Config_ul_2018_v10
from config.base_config_ZH import Config as Base_config_ZH

class Config_ul_2018_ZH_v10(Base_config_ZH):
    def __init__(self, *args, **kwargs):
        self.add_weights = MethodType(Config_ul_2018_v10.add_weights, self)

        super().__init__(*args, **kwargs)

        # this has to be done after __init__ as Base_config_ZH writes to it
        # but before self.add_regions() as that is where the values are actually used
        self.deeptau = config_ul_2018_ZZ_v10.deeptau

        self.regions = self.add_regions()
        self.categories = self.add_categories()

    #@override
    def add_datasets(self):
        # make a copy of the Dataset objects so we can modify them without changing the ZZ config
        zz_datasets = [copy.copy(dataset) for dataset in config_ul_2018_ZZ_v10.datasets]

        datasets = [dataset for dataset in zz_datasets if not dataset.name.startswith("ggXZZbbtt_M")]
        datasets += [
            ## Zprime -> ZH resonance high mass
            Dataset("ggZpZHttbb_M600",
                folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobsPilots/gg_X_ZZbbtautau_M600/Step_4",
                process=self.processes.get("ggZpZHttbb_M600"),
                xs=1,
                tags=["ul", "nanoV10"])
        ]

        # remove the extra ZZ datasets meant for ZZ analysis, keeping only zz_sl_background (process=zz)
        datasets = [dataset for dataset in datasets if dataset.name not in ["zz_sl_signal", "zz_sl_signal_aux",
                "zz_bbtt", "zz_bbtt_aux"]]

        datasets = ObjectCollection(datasets)

        # ZH datasets
        # ZH_HToBB_ZToLL is split in 2 : process zh_zbbhtt_sl_signal (with genMatching for bbtautau decay) 
        # and for process zh_sl_background (with inverted genMatching)
        zh_hbb_zll_fromZZ = datasets.get("zh_hbb_zll")
        zh_hbb_zll_fromZZ.name = "zh_hbb_zll_background"
        zh_hbb_zll_fromZZ.process = self.processes.get("zh_sl_background")
        zh_hbb_zll_fromZZ.aux["secondary_dataset"] = "zh_hbb_zll_background_aux"

        zh_hbb_zll_fromZZ_aux = datasets.get("zh_hbb_zll_aux")
        zh_hbb_zll_fromZZ_aux.name = "zh_hbb_zll_background_aux"
        zh_hbb_zll_fromZZ_aux.process = self.processes.get("zh_sl_background")

        zh_ztthbb_sl_signal = copy.copy(zh_hbb_zll_fromZZ)
        zh_ztthbb_sl_signal.name = "zh_ztt_hbb_sl_signal"
        zh_ztthbb_sl_signal.process = self.processes.get("zh_ztt_hbb_sl_signal")
        zh_ztthbb_sl_signal.aux["secondary_dataset"] = "zh_ztt_hbb_sl_signal_aux"
        datasets.add(zh_ztthbb_sl_signal)

        zh_ztthbb_sl_signal_aux = copy.copy(zh_hbb_zll_fromZZ_aux)
        zh_ztthbb_sl_signal_aux.name = "zh_ztt_hbb_sl_signal_aux"
        zh_ztthbb_sl_signal_aux.process = self.processes.get("zh_ztt_hbb_sl_signal")
        datasets.add(zh_ztthbb_sl_signal_aux)

        # ZHToTauTau
        zh_htt_fromZZ = datasets.get("zh_htt")
        zh_htt_fromZZ.name = "zh_htt_background"
        zh_htt_fromZZ.process = self.processes.get("zh_sl_background")
        zh_htt_fromZZ.aux["secondary_dataset"] = "zh_htt_background_aux"

        zh_htt_fromZZ_aux = datasets.get("zh_htt_aux")
        zh_htt_fromZZ_aux.name = "zh_htt_background_aux"
        zh_htt_fromZZ_aux.process = self.processes.get("zh_sl_background")

        zh_zbbhtt_sl_signal = copy.copy(zh_htt_fromZZ)
        zh_zbbhtt_sl_signal.name = "zh_zbb_htt_sl_signal"
        zh_zbbhtt_sl_signal.process = self.processes.get("zh_zbb_htt_sl_signal")
        zh_zbbhtt_sl_signal.aux["secondary_dataset"] = "zh_zbb_htt_sl_signal_aux"
        datasets.add(zh_zbbhtt_sl_signal)

        zh_zbbhtt_sl_signal_aux = copy.copy(zh_htt_fromZZ_aux)
        zh_zbbhtt_sl_signal_aux.name = "zh_zbb_htt_sl_signal_aux"
        zh_zbbhtt_sl_signal_aux.process = self.processes.get("zh_zbb_htt_sl_signal")
        datasets.add(zh_zbbhtt_sl_signal_aux)

        # ZH_Hbb_Zqq (ZH_HToBB_ZToQQ)
        datasets.get("zh_hbb_zqq").process = self.processes.get("zh_sl_background") # replaced from zh_hbb

        # we changed names of objects in the collection so we need to recreate it
        datasets = ObjectCollection(list(datasets))
        # update the processes to reflect the ZH process data instead of the ZZ process data 
        for dataset in datasets:
            dataset.process = self.processes.get(dataset.process.name)


        return datasets

config = Config_ul_2018_ZH_v10("ul_2018_ZH_v10", year=2018, ecm=13, lumi_pb=59741, isUL=True)