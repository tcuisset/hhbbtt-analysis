""" Base configuration for X->ZH->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig

class Config(BaseConfig):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def add_categories(self, **kwargs):
        categories = super().add_categories(**kwargs)

        categories_mass_cut = ObjectCollection([
 
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
        categories += categories_mass_cut

        # add the same ellipitical cuts but in mutau, etau, tautau versions
        for channelName, pairType in {"mutau": 0, "etau": 1, "tautau": 2}.items():
            for baseEllipticalCut in categories_mass_cut:
                categories.append(
                        Category(
                            name = baseEllipticalCut.name + "_" + channelName,
                            label = baseEllipticalCut.label + f" ({channelName})",
                            selection  =f"({baseEllipticalCut.selection}) && (pairType == {pairType})"
                        )
                    )
        return ObjectCollection(categories)
    
    #@override
    def add_processes(self):
        processes, process_group_names, process_training_names = get_common_processes()

        # add ggZpZHbbtt
        processes += ObjectCollection([
            ########### ZbbHtt analysis
            # ZH_HToTT_ZToBB
            Process("zh_zbb_htt_signal", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"),
                    ProcType="Zbb_Htautau", isSigBBTT=True, isSignal=True, color=(126, 238, 124)),
            Process("zh_zbb_htt_background", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"), parent_process='higgs',
                    ProcType="Zbb_Htautau", isBkgBBTT=True, color=(126, 238, 124)),

            # includes ZH_HToBB_ZToTT as background of ZbbHtt analysis
            Process("zh_hbb", Label("ZH (H#rightarrow bb, Z#rightarrow ll)"), parent_process='higgs',
                    color=(126, 238, 124)),

            ########### ZttHbb analysis
            # ZH_HToBB_ZToTT
            Process("zh_ztt_hbb_signal", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"),
                    ProcType="Ztautau_Hbb", isSigBBTT=True, isSignal=True, color=(32, 196, 201)),
            Process("zh_ztt_hbb_background", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"), parent_process='higgs',
                    ProcType="Ztautau_Hbb", isBkgBBTT=True, color=(32, 196, 201)),
            
            # includes ZHToTauTau as background of ZttHbb analysis
            Process("zh_htt", Label("ZH (H#rightarrow #tau#tau, Z#rightarrow anything)"), parent_process='higgs',
                    color=(126, 238, 124)),
            
            ######### Common
            # ZZ_SL
            Process("zz_sl", Label("zz_sl"), color=(130, 39, 197), parent_process="zz"),
            Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(130, 39, 197), parent_process="higgs"),


            ######## Resonant
            # ZH resonant
            Process("Zprime_Zh_Zbbhtautau_M600", Label("Z'#rightarrow ZH #rightarrow bb#tau#tau,  600 GeV"), color=(238, 245, 99), 
                    isSigBBTT=True, ProcType="Zbb_Htautau", isSignal=True, llr_name="ZHbbtt_M600"),

            # background for resonant analysis 
            Process("zh_zbb_htt", Label("ZH (H#rightarrow bb, Z#rightarrow#tau#tau)"), color=(0, 165, 80), 
                    ProcType="Zbb_Htautau", isSigBBTT=True, parent_process='higgs'),
            Process("zh_ztt_hbb", Label("ZH (H#rightarrow#tau#tau, Z#rightarrow bb)"), color=(0, 165, 80), 
                    ProcType="Ztautau_Hbb", isSigBBTT=True, parent_process='higgs'),
        ])

        process_group_names = {
        "Zprime_Zh_Zbbhtautau": ["Zprime_Zh_Zbbhtautau_M600"],
        "datacard_zh": [
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
            "zh_zbb_htt_background",
            "zh_ztt_hbb_background",
            "higgs", # added for zh but not sure correct (Theo)
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz
            "wh",
            #"zh", # this is actually zh_background ie ZH processes not part of signal
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "zh_split_signal": [
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
            "zh_zbb_htt_background",
            "zh_ztt_hbb_background",         
        ],
        "zh_sig_vs_bkg": [
            "zh_background",
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
        ],
        }        
        return processes, process_group_names, process_training_names
