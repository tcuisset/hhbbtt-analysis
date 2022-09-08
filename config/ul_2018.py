from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from config.base_config import Config as base_config
from cmt.config.ul_2018 import Config_ul_2018

class Config_ul_2018(base_config, Config_ul_2018):
    def __init__(self, *args, **kwargs):
        super(Config_ul_2018, self).__init__(*args, **kwargs)

    def add_weights(self):
        weights = DotDict()
        weights.default = "1"
        # weights.total_events_weights = ["genWeight", "puWeight", "DYstitchWeight"]
        weights.total_events_weights = ["genWeight", "puWeight"]
        weights.channels = {
            "mutau": ["genWeight", "puWeight", "prescaleWeight", "trigSF",
                "idAndIsoAndFakeSF_deep_pt", "L1PreFiringWeight_Nom", "PUjetID_SF", "bTagweightReshape2"
            ],
        }
        weights.channels["etau"] = weights.channels["mutau"]
        weights.channels["tautau"] = weights.channels["mutau"]

        weights.channels_mult = {channel: jrs(weights.channels[channel], op="*")
            for channel in weights.channels}
        return weights

config = Config_ul_2018("ul_2018", year=2018, ecm=13, lumi_pb=59741)
