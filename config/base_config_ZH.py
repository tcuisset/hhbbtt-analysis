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
            # ZH elliptical cuts. Optimized. 
            # Best Ellipse (140.0, 82.0, 57.0, 66.0): S_eff=0.8019, B_eff=0.3956, S/sqrt(B)=1.2751
            Category("ZH_elliptical_cut_80_zbb_htt", "ZH elliptical mass cut targeting Z->bb,H->tautau",
                selection="(({{Ztt_svfit_mass}} - 140.) * ({{Ztt_svfit_mass}} - 140.) / (57. * 57.)"
                " + ({{Zbb_mass}} - 82.) * ({{Zbb_mass}} - 82.) / (66. * 66.)) < 1"
            ),
            # Best Ellipse (158.0, 118.0, 83.0, 118.0): S_eff=0.9003, B_eff=0.5991, S/sqrt(B)=1.1632
            Category("ZH_elliptical_cut_90_zbb_htt", "ZH elliptical mass cut targeting Z->bb,H->tautau",
                selection="(({{Ztt_svfit_mass}} - 158.) * ({{Ztt_svfit_mass}} - 158.) / (83. * 83.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (118. * 118.)) < 1"
            ),
            # Best Ellipse (93.0, 172.0, 37.0, 164.0): S_eff=0.8009, B_eff=0.3313, S/sqrt(B)=1.3914
            Category("ZH_elliptical_cut_80_ztt_hbb", "ZH elliptical mass cut targeting Z->bb,H->tautau",
                selection="(({{Ztt_svfit_mass}} - 93.) * ({{Ztt_svfit_mass}} - 93.) / (37. * 37.)"
                " + ({{Zbb_mass}} - 172.) * ({{Zbb_mass}} - 172.) / (164. * 164.)) < 1"
            ),
            #Best Ellipse (100.0, 189.0, 64.0, 187.0): S_eff=0.9000, B_eff=0.5304, S/sqrt(B)=1.2358
            Category("ZH_elliptical_cut_90_ztt_hbb", "ZH elliptical mass cut targeting Z->bb,H->tautau",
                selection="(({{Ztt_svfit_mass}} - 100.) * ({{Ztt_svfit_mass}} - 100.) / (64. * 64.)"
                " + ({{Zbb_mass}} - 189.) * ({{Zbb_mass}} - 189.) / (187. * 187.)) < 1"
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
                    ProcType="Ztautau_Hbb", isSignal=True, llr_name=f"ZHbbtt_M{mass}")
            for mass in ZHmassPoints
        ])

        # remove signals for ZZ analysis  but keep zz_bbtt (this will be used as background for ZH analysis)
        #processes = [process for process in processes if process.name not in ["zz_sl_signal", "zz_sl_background",
                # remove zh processes as they will be recreated below 
        #         "zh_hbb", "zh_htt", "zh"]]

        processes += ObjectCollection([
            # two subsignals for non-resonant ZH->bbtt
            Process("zh_zbb_htt_sl_signal", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"),
                    ProcType="Zbb_Htautau", isSigBBTT=True, isSignal=True, color=(126, 238, 124)),
            Process("zh_ztt_hbb_sl_signal", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"),
                    ProcType="Ztautau_Hbb", isSigBBTT=True, isSignal=True, color=(32, 196, 201)),

            Process("zh_zbb_htt_sl_background", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"),
                    ProcType="Zbb_Htautau", isBkgBBTT=True, color=(126, 238, 124)),
            Process("zh_ztt_hbb_sl_background", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"),
                    ProcType="Ztautau_Hbb", isBkgBBTT=True, color=(32, 196, 201)),
            
            # VV
            Process("zz_sl", Label("zz_sl"), color=(130, 39, 197), parent_process="zz"),
            
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
