""" Base configuration for X->ZH->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label
import itertools
import numpy as np
import sys

from config.base_config import get_common_processes, BaseConfig

resonant_masses_ZH = [500,600,700,800,1000,1200,1400,1600,1800,2000,2500,3000,3500,4000,4500,5000,5500,6000]
""" Masses for resonant central samples of ZH (both ZbbHtt and ZttHbb)"""
reduced_resonant_masses_ZH = [600, 800, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 5000, 6000]
""" reduced set of masses to declutter plots """

def get_ZH_common_features(self):
    """ Returns the features that are common to both ZH analyses"""
    return ObjectCollection([
        # ZH
        Feature("ZH_pt", "ZH_pt", binning=(25, 0, 250),
            x_title=Label("ZH p_{T}"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_eta", "ZH_eta", binning=(20, -5., 5.),
            x_title=Label("ZH #eta"), tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_phi", "ZH_phi", binning=(20, -3.2, 3.2),
            x_title=Label("ZH #phi"), tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_mass", "ZH_mass", binning=(50, 0, 1000),
            x_title=Label("ZH_{bb#tau#tau} mass"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_mass_fine", "ZH_mass", binning=(600, 0, 3000),
            x_title=Label("ZH_{bb#tau#tau} mass"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),

        # ZH (SVFit)
        Feature("ZH_svfit_pt", "ZH_svfit_pt", binning=(30, 0, 330),
            x_title=Label("ZH p_{T} (SVFit)"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_svfit_eta", "ZH_svfit_eta", binning=(20, -5., 5.),
            x_title=Label("ZH #eta (SVFit)"), tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_svfit_phi", "ZH_svfit_phi", binning=(20, -3.2, 3.2),
            x_title=Label("ZH #phi (SVFit)"), tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_svfit_mass", "ZH_svfit_mass", binning=(50, 150, 1150),
            x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZH_svfit_mass_fine", "ZH_svfit_mass", binning=(600, 0, 3000),
            x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),

        # ZH KinFit
        Feature("ZHKinFit_mass", "ZHKinFit_mass", binning=(50, 150, 1150),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZHKinFit_highmass", "ZHKinFit_mass",
            binning=(79-1, 160, 2500),
            # Attempts at variable binning. Looks super ugly
            # the +1 is to include the last bin edge
            #old binning=(175, 150, 3550),
            #binning=np.concatenate([np.arange(160, 1000, 20), np.arange(1000, 1500, 50), np.arange(1500, 2000, 100), np.arange(2000, 3500+1, 500)]),
            #binning=np.concatenate([np.arange(160, 1000, 20), np.arange(1000, 1500, 50), np.arange(1500, 2000, 100), np.arange(2000, 3500+1, 500)]),
            x_title=Label("ZH mass (Kin. Fit)"), 
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZHKinFit_mass_res", "ZHKinFit_mass", binning=(50, 150, 1150),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZHKinFit_highmass_res", "ZHKinFit_mass", binning=(175, 150, 3650),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV", tags=["cat"],
            systematics=self.all_systs),
        Feature("ZHKinFit_chi2", "ZHKinFit_chi2", binning=(30, 0, 50),
            x_title=Label("ZH #chi^{2} (Kin. Fit)"), tags=["cat"],
            systematics=self.all_systs),
        
        *[Feature(f"dnn_ZHbbtt_{nbins}b", "dnn_ZHbbtt_kl_1", binning=(nbins, 0, 1+sys.float_info.epsilon),
                x_title=Label("DNN ZZ"), tags=["dnn", "blind", "dnn_nonres"]+(["dnn_limited"] if nbins in [10, 100] else []), no_save_bin_yields=True,
                systematics=self.all_systs)
            for nbins in [10, 30, 100, 500]],
        *[Feature(f"dnn_ZHbbtt_{nbins}bv", "dnn_ZHbbtt_kl_1", binning=np.concatenate([np.linspace(0., 0.5, int(nbins/10), endpoint=False), np.linspace(0.5, 0.8, int(1./10.*nbins), endpoint=False), np.linspace(0.8, 0.9, int(2/10*nbins), endpoint=False), np.linspace(0.9, 0.97, int(3/10*nbins), endpoint=False), np.linspace(0.97, 1.+sys.float_info.epsilon, int(3/10*nbins)+1, endpoint=True)]),
                x_title=Label("DNN ZH"), tags=["dnn", "blind", "dnn_nonres"], no_save_bin_yields=True,
                systematics=self.all_systs)
            for nbins in [500]], # variable-binning non-res DNN (for boostedTaus category)
        
        *[Feature(f"dnn_ZHbbtt_kl_1_{mass}", f"dnn_ZHbbtt_kl_1_{mass}", binning=(10, 0, 1+sys.float_info.epsilon),
                x_title=Label(f"DNN ZH resonant {mass}"), tags=["dnn", "blind"],
                systematics=self.all_systs)
        for mass in resonant_masses_ZH],

        *[Feature(f"dnn_ZHbbtt_{nbins}bv_M{mass}", f"dnn_ZHbbtt_kl_1_{mass}", # variable binning version for auto-rebin algorithm
                # [0, 0.5, 0.8, 0.9, 0.97, 1]
                # [  50  50   100  150  150 ]
                # in case high DNN score gets rounded to 1 we want to include it, thus the highest bin includes 1. Also add one bin to the last interval as we need nbins+1 edges
                binning=np.concatenate([np.linspace(0., 0.5, int(nbins/10), endpoint=False), np.linspace(0.5, 0.8, int(1./10.*nbins), endpoint=False), np.linspace(0.8, 0.9, int(2/10*nbins), endpoint=False), np.linspace(0.9, 0.97, int(3/10*nbins), endpoint=False), np.linspace(0.97, 1.+sys.float_info.epsilon, int(3/10*nbins)+1, endpoint=True)]),
                x_title=Label(f"PNN ZH {mass} GeV" if mass < 1000 else f"PNN ZH {mass/1000:g} TeV"),  tags=["dnn", "dnn_res", "blind", f"dnn_res_M{mass}"] + (["dnn_limited"] if mass in reduced_resonant_masses_ZH else []),
                systematics=self.all_systs, no_save_bin_yields=True)
            for mass in resonant_masses_ZH for nbins in [500]],
    ])

def get_ZH_common_processes():
    """ Returns the processes that are common to both ZH analyses"""
    # https://leonardocolor.io/scales.html#
    # long version
    colors_res = itertools.cycle([(31, 0, 117), (4, 41, 100), (0, 55, 101), (0, 66, 106), (0, 78, 110), (0, 88, 113), (0, 99, 115), (0, 109, 115), (0, 119, 114), (0, 129, 111), (0, 139, 105), (14, 148, 99), (48, 155, 92), (78, 161, 84), (103, 165, 76), (127, 169, 68), (151, 172, 60), (174, 174, 55)])
    #short version
    colors_res = itertools.cycle([(31, 0, 117), (0, 66, 106), (0, 99, 115), (0, 129, 111), (48, 155, 92), (127, 169, 68), (174, 174, 55)])

    processes = [
        ######### Common ZbbHtt / ZttHbb backgrounds
        # ZZ_SL
        #Process("zz_sl", Label("zz_sl"), color=(130, 39, 197), parent_process="zz"),
        Process("zz_sl_background", Label("ZZ SL BKG"), color=(20, 60, 255), parent_process="zz", 
                    removeZH=True, isBkgBBTT=True, genfilter_denominator_weights=False, ProcType="Zbb_Ztautau"),
        Process("zz_bbtt", Label("ZZ_{bb#tau#tau}"), color=(0, 165, 80),  # zz_sl_signal but isSignal=False
            isSigBBTT=True, ProcType="Zbb_Ztautau", removeZH=True, genfilter_denominator_weights=True, llr_name="ZZbbtt", fatjet_bb_type="HHlike", parent_process="zz"),

        Process("zh_hbb_zqq", Label("zh_hbb_zqq"), color=(28, 130, 145), parent_process="zh"),

        # ZH includes all ZH processes that are not signal (ie not ZbbHtt, ZttHbb and resonant)
        Process("zh", Label("ZH"), color=(130, 39, 197), parent_process="higgs", llr_name="ZH"),

        ######### ZbbHtt
        # ZHToTauTau_M125 dataset with genfilter Z->bb,H->tautau
        # ONLY TO BE USED FOR NON-RESONANT (use dataset selection)
        # normalization is from theory
        Process("zh_zbb_htt_signal", Label("Z_{bb}H_{#tau#tau}"),
                ProcType="Zbb_Htautau", isSigBBTT=True, genfilter_denominator_weights=True, isSignal=True, color=(0, 165, 80), llr_name="ZbbHtt", fatjet_bb_type="HHlike", parent_process="all_signals"),
        # same as above but with reversed genfilter (ZH, Z->anything except bb, H->tautau)
        Process("zh_zbb_htt_background", Label("ZH (H#rightarrow#tau#tau) bkg"), parent_process='zh',
                ProcType="Zbb_Htautau", isBkgBBTT=True, genfilter_denominator_weights=True, color=(224, 190, 79)),
        # resonant
        *[Process(f"Zprime_Zh_Zbbhtautau_M{mass}", Label(f"Z' {mass} GeV" if mass < 1000 else f"Z' {mass/1000:g} TeV"), color=next(colors_res), 
                ProcType="Zbb_Htautau", isSignal=True, llr_name="ZprimeZbbHtt", fatjet_bb_type="HHlike", parent_process="all_signals") # isSigBBTT=True, 
            for mass in resonant_masses_ZH],
        
        # background for resonant analysis (zh_zbb_htt_signal with isSignal=False, dataset is the exact same)
        # Need to be very careful with dataset selection to only include this for resonant analysis (otherwise it duplicates zh_zbb_htt_signal)
        Process("zh_zbb_htt", Label("Z_{bb}H_{#tau#tau}"), color=(0, 165, 80), 
                ProcType="Zbb_Htautau", isSigBBTT=True, genfilter_denominator_weights=True, parent_process='zh'),
        
        ######### ZttHbb
        # ZH_Hbb_Zll dataset with genfilter Z->tautau,H->bb
        Process("zh_ztt_hbb_signal", Label("Z_{#tau#tau}H_{bb}"),
                ProcType="Ztautau_Hbb", isSigBBTT=True, genfilter_denominator_weights=True, isSignal=True,  color=(0, 165, 80), llr_name="ZttHbb", fatjet_bb_type="HHlike", parent_process="all_signals"),
        # same as above but with reversed genfilter (Z->ll except tautau, H->bb)
        Process("zh_ztt_hbb_background", Label("ZH (Z#rightarrow ll, H#rightarrow bb) bkg"), parent_process='zh',
                ProcType="Ztautau_Hbb", isBkgBBTT=True, genfilter_denominator_weights=True, color=(224, 190, 79)),
        # resonant
        *[Process(f"Zprime_Zh_Ztautauhbb_M{mass}", Label(f"Z' {mass} GeV" if mass < 1000 else f"Z' {mass/1000:g} TeV"), color=next(colors_res),
                    ProcType="Ztautau_Hbb", isSignal=True, llr_name="ZprimeZttHbb", fatjet_bb_type="HHlike", parent_process="all_signals") # isSigBBTT=True, 
            for mass in resonant_masses_ZH],

        # background for resonant analysis (zh_ztt_hbb_signal with isSignal=False, dataset is the exact same)
        # Need to be very careful with dataset selection to only include this for resonant analysis (otherwise it duplicates zh_ztt_hbb_signal)
        Process("zh_ztt_hbb", Label("Z_{#tau#tau}H_{bb}"), color=(0, 165, 80), 
                ProcType="Ztautau_Hbb", isSigBBTT=True, genfilter_denominator_weights=True, parent_process='zh'
                ),
    ]

    process_group_names = {
        "datacard": [
            "zh_zbb_htt_signal",
            "zh_ztt_hbb_signal",
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz which in turn includes zz_sl
            "wh",
            "zh", # this is actually ZH processes not part of signal
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "datacard_res": [
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH],
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in resonant_masses_ZH],
            # "zh_zbb_htt", # ZbbHtt as background for resonant analysis -> included in zh
            # "zh_ztt_hbb", # background for resonant analysis -> included in zh
            #"zh_zbb_htt_background", # -> goes in zh
            "ttH",
            "dy",
            "vvv",
            "vbf_htt",
            "ggH_ZZ",
            "ttx",
            "vv", # this includes zz
            "wh",
            "zh", # this is actually zh_background ie ZH processes not part of signal
            # "zh_hbb_zqq", # included in zh
            #"zh_hbb", # TODO this would be included in zh but the dataset is not available
            "tw",
            "singlet",
            "ewk",
            "wjets",
            "tt",
            "ggf_sm",
            "data",
        ],
        "datacard_res_reduced": [
            *[f"Zprime_Zh_Zbbhtautau_M{mass}" for mass in resonant_masses_ZH],
            *[f"Zprime_Zh_Ztautauhbb_M{mass}" for mass in resonant_masses_ZH],
            # "zh_zbb_htt", # ZbbHtt as background for resonant analysis -> included in zh
            # "zh_ztt_hbb", # background for resonant analysis -> included in zh
            #"zh_zbb_htt_background", # -> goes in zh -> higgs
            # "zz_bbtt", -> goes into zz -> vv
            "tt",
            "dy",
            "wjets",
            "vv_v", #includes vv (& zz) & vvv
            "ttx",
            "higgs", # include wh, vbf_htt, ggH_ZZ, ttH, zh, ggf_sm
            "others", #inlucde ewk, tw, singlet
            "data",
        ],
        "full": [
            'ewk_wminus',
            'ewk_wplus',
            'ewk_z',
            'ggH_ZZ',
            'ggf_sm',
            'singlet',
            'tt_dl',
            'tt_fh',
            'tt_sl',
            'tth_bb',
            'tth_tautau',
            'ttw',
            'ttwh',
            'ttww',
            'ttwz',
            'ttz',
            'ttzh',
            'ttzz',
            'tw',
            'wh_htt',
            "dy",
            "wjets",
            'ww',
            'www',
            'wwz',
            'wz',
            'wzz',
            'zh_hbb',
            'zh_htt',
            'zz',
            'zzz',
            'data'
        ]
    }

    process_training_names = {}

    return ObjectCollection(processes), process_group_names, process_training_names

