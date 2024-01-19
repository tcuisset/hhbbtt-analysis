# config specific to ZZ analysis but not any particular year
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict

from plotting_tools import Label
from collections import OrderedDict

from config.base_config import get_common_processes, BaseConfig

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()
        processes += ObjectCollection([
            Process("zz_sl_signal", Label("ZZ_{bb#tau#tau}"), color=(126, 238, 124), 
                isZZsignal=True, isSignal=True, llr_name="ZZbbtt"),
            Process("ggXZZbbtt_M200", Label("ggX 200 GeV"), color=(238, 245, 99), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M200"),
            Process("ggXZZbbtt_M300", Label("ggX 300 GeV"), color=(208, 240, 120), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M300"),
            Process("ggXZZbbtt_M400", Label("ggX 400 GeV"), color=(179, 241, 134), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M400"),
            Process("ggXZZbbtt_M500", Label("ggX 500 GeV"), color=(149, 241, 147), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M500"),
            Process("ggXZZbbtt_M600", Label("ggX 600 GeV"), color=(126, 238, 124), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M600"),
            Process("ggXZZbbtt_M700", Label("ggX 700 GeV"), color=(118, 241, 156),
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M700"),
            Process("ggXZZbbtt_M800", Label("ggX 800 GeV"), color=(109, 243, 187), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M800"),
            Process("ggXZZbbtt_M900", Label("ggX 900 GeV"), color=(127, 232, 214), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M900"),
            Process("ggXZZbbtt_M1000", Label("ggX 1.0 TeV"), color=(122, 197, 220), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1000"),
            Process("ggXZZbbtt_M1100", Label("ggX 1.1 TeV"), color=(99, 173, 199), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1100"),
            Process("ggXZZbbtt_M1200", Label("ggX 1.2 TeV"), color=(77, 149, 167), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1200"),
            Process("ggXZZbbtt_M1300", Label("ggX 1.3 TeV"), color=(54, 125, 135), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1300"),
            Process("ggXZZbbtt_M1400", Label("ggX 1.4 TeV"), color=(30, 106, 114), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1400"),
            Process("ggXZZbbtt_M1500", Label("ggX 1.5 TeV"), color=(5, 87, 92), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M1500"),
            Process("ggXZZbbtt_M2000", Label("ggX 2.0 TeV"), color=(5, 72, 76), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M2000"),
            Process("ggXZZbbtt_M3000", Label("ggX 3.0 TeV"), color=(5, 59, 63), 
                    isZZsignal=True, isSignal=True, llr_name="ggXZZbbtt_M3000"),
            Process("zz_bbtt", Label("ZZ_{bb#tau#tau}"), color=(0, 165, 80), 
                    isZZsignal=True, parent_process="zz_background", llr_name="ZZbbtt"), # background for resonant analysis 
        
            # VV
            Process("zz_sl_background", Label("ZZ SL BKG"), color=(20, 60, 255), parent_process="zz", isZZbackground=True),

            # ZH_hbb
            Process("zh_hbb", Label("zh_hbb"), color=(130, 39, 197), parent_process="zh"),
            Process("zh_htt", Label("zh_htt"), color=(130, 39, 197), parent_process="zh"),
            Process("zh", Label("ZH"), color=(130, 39, 197), parent_process="higgs", llr_name="ZH"),
        ])

        process_group_names |= {
            "zz": [
            "zz_sl_signal",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "zz_res": [
            "zz_bbtt",
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
            "higgs",
            "vv_v",
            "wjets",
            "dy",
            "others",
            "tt",
            "ttx",
            "data",
        ],
        "datacard_zz": [
            "zz_sl_signal",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv",
            "wh",
            "zh",
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "datacard_zz_res": [
            "zz_bbtt",
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv",
            "wh",
            "zh",
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "ggXZZbbtt": [
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
        ],
        "zz_total": [
            "zz_sl_signal",
            "dy",
            "tt",
            "wjets",
            "tth",
            "ggf_sm",
            "zz",
            "others",
        ],
        "zz_total_data": [
            "zz_sl_signal",
            "dy",
            "tt",
            "wjets",
            "tth",
            "ggf_sm",
            "zz",
            "others",
            "data",
        ],
        "zz_sig_vs_bkg": [
            "zz_background",
            "zz_sl_signal",
            "ggXZZbbtt_M200",
            "ggXZZbbtt_M300",
            "ggXZZbbtt_M400",
            "ggXZZbbtt_M500",
            "ggXZZbbtt_M600",
            "ggXZZbbtt_M700",
            "ggXZZbbtt_M800",
            "ggXZZbbtt_M900",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1000",
            "ggXZZbbtt_M1100",
            "ggXZZbbtt_M1200",
            "ggXZZbbtt_M1300",
            "ggXZZbbtt_M1400",
            "ggXZZbbtt_M1500",
            "ggXZZbbtt_M2000",
            "ggXZZbbtt_M3000",
        ],
        }
        return processes, process_group_names, process_training_names

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        categories += ObjectCollection([
            Category("ZZ_elliptical_cut_80", "ZZ mass cut E=80%",
                selection="(({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1"),
            Category("ZZ_elliptical_cut_90", "Elliptical cut E=90%",
                selection="(({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
                " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1"),
            
            Category("ZZ_elliptical_cut_80_sr", "ZZ mass cut E=80% && Signal region",
                selection="((({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
                    " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1) && " + \
                    "(((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 2) && (isOS == 1) && "
                    "(dau1_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0}))) "
                    .format(self.deeptau.vsjet.Medium)),
            Category("ZZ_elliptical_cut_80_sr_debug", "ZZ mass cut E=80% && Signal region debug",
                selection="(event == 31332435) || (event == 31336032)"),
            Category("ZZ_elliptical_cut_80_mutau", "ZZ mass cut E=80%",
                selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 0)"),
            Category("ZZ_elliptical_cut_80_etau", "ZZ mass cut E=80%",
                selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 1)"),
            Category("ZZ_elliptical_cut_80_tautau", "ZZ mass cut E=80%",
                selection="((({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1) && (pairType == 2)"),
        ])

        return categories




#config = Config("base", year=2018, ecm=13, lumi_pb=59741)
