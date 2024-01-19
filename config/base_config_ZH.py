""" Base configuration for X->ZH->bbtautau analysis. Inherits from base_config_ZZ.py """
from types import MethodType

from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)


    def add_categories(self, **kwargs):
        categories = super().add_categories()

        cats_zh_elliptical = ObjectCollection([
            Category("ZH_elliptical_cut_zbb_htt_v1", "ZH elliptical mass cut targeting Z->bb,H->tautau (non-optimized)",
                selection="(({{Ztt_svfit_mass}} - 120.) * ({{Ztt_svfit_mass}} - 120.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 90.) * ({{Zbb_mass}} - 90.) / (113. * 113.)) < 1"
            ),
            Category("ZH_elliptical_cut_ztt_hbb_v1", "ZH elliptical mass cut targeting Z->bb,H->tautau (non-optimized)",
                selection="(({{Ztt_svfit_mass}} - 90.) * ({{Ztt_svfit_mass}} - 90.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 120.) * ({{Zbb_mass}} - 120.) / (113. * 113.)) < 1"
            ),
        ])
        categories += cats_zh_elliptical
        # add the same ellipitical cuts but in mutau, etau, tautau versions
        for channelName, pairType in {"mutau":0, "etau": 1, "tautau":2}.items():
            for baseEllipticalCut in cats_zh_elliptical:
                categories.append(Category(name=baseEllipticalCut.name + "_" + channelName,
                    label=baseEllipticalCut.label + f" ({channelName})",
                    selection=f"({baseEllipticalCut.selection}) && (pairType == {pairType})"))
        
        return ObjectCollection(categories)

    
    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()

        ZHmassPoints = [600]
        resonantProcessesNames = [f"ggZpZHttbb_M{mass}" for mass in ZHmassPoints]
        # add ggZpZHbbtt
        processes += ObjectCollection([
            Process(f"ggZpZHttbb_M{mass}", Label(r"gg \to Z' \to ZH \to \tau\tau b b (m_{Z'} = " + f"{mass} GeV)"),
                    isZHsignal="ztt_hbb", isSignal=True, llr_name=f"ZHbbtt_M{mass}")
            for mass in ZHmassPoints
        ])

        # remove signals for ZZ analysis  but keep zz_bbtt (this will be used as background for ZH analysis)
        #processes = [process for process in processes if process.name not in ["zz_sl_signal", "zz_sl_background",
                # remove zh processes as they will be recreated below 
        #         "zh_hbb", "zh_htt", "zh"]]

        processes += ObjectCollection([
            # signal for non-resonant ZH->bbtt (both ZbbHtt and ZttHbb)
            Process("zh_sl_signal", Label("ZH_{bb#tau#tau}"),
                    isZHsignal=["zbb_htt", "ztt_hbb"], isSignal=True), # TODO llr_name ?
            # two subsignals for non-resonant ZH->bbtt
            Process("zh_zbb_htt_sl_signal", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"),
                    isZHsignal="zbb_htt", isSignal=True, parent_process="zh_sl_signal",
                    color=(126, 238, 124)),
            Process("zh_ztt_hbb_sl_signal", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"),
                    isZHsignal="ztt_hbb", isSignal=True, parent_process="zh_sl_signal",
                    color=(32, 196, 201)),
            
            # ZH background (ZH_HToBB_ZToLL + ZHToTauTau not decaying in bbtautau or tautaubb)
            Process("zh_sl_background", Label("ZH semileptonic (not bb#tau#tau)"),
                    isZHbackground=True),
            
            # background (everything)
            # for now we just use zz_background as background name (probably should change the name for clarity)
            #Process("zh_background", Label("Background"), color=(0, 0, 255)),
        ])

        process_group_names = {}
        process_group_names["ggZpZHttbb"] = resonantProcessesNames
        
        
        process_group_names["datacard_zh"] = [
            "zh_zbb_htt_sl_signal",
            "zh_ztt_hbb_sl_signal",
            "zh_sl_background"
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz
            "wh",
            "zh", # this is actually zh_background ie ZH processes not part of signal
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ]
        process_group_names["datacard_zh_res"] = [
            process_group_names["datacard_zh"][0],
            *resonantProcessesNames,
            *process_group_names["datacard_zh"][1:],
        ]
        
        process_group_names["zh_split_signal"] = [
            "zh_zbb_htt_sl_signal",
            "zh_ztt_hbb_sl_signal",
            "zh_sl_background"
        ]

        process_group_names["zh_sig_vs_bkg"] = [
            "zz_background",
            "zh_zbb_htt_sl_signal",
            "zh_ztt_hbb_sl_signal",
        ]
        
        return processes, process_group_names, process_training_names

#config = Config("base", year=2018, ecm=13, lumi_pb=59741)
