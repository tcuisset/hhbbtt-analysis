# Put all processes that are not specific to the ZZ or ZH analysis here
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from cmt.config.base_config import Config as cmt_config
from cmt.base_tasks.base import Task

from config.xs_config import cross_section_dict

import math

def get_common_processes():
    processes = [
        # W. Process type is DY-like (not sure why, but doing same as HH resonant analysis)
        Process("wjets", Label("Wjets"), color=(244, 44, 4), parent_process="all_background", llr_name="WJets", fatjet_bb_type="DYlike"),

        Process("wjets_ht1", Label("Wjets HT1"), color=(5, 87, 92), 
                parent_process="wjets"),
        Process("wjets_ht2", Label("Wjets HT2"), color=(54, 125, 135), 
                parent_process="wjets"),
        Process("wjets_ht3", Label("Wjets HT3"), color=(77, 149, 167), 
                parent_process="wjets"),
        Process("wjets_ht4", Label("Wjets HT4"), color=(99, 173, 199), 
                parent_process="wjets"),
        Process("wjets_ht5", Label("Wjets HT5"), color=(144, 221, 244), 
                parent_process="wjets"),
        Process("wjets_ht6", Label("Wjets HT6"), color=(127, 232, 214), 
                parent_process="wjets"),
        Process("wjets_ht7", Label("Wjets HT7"), color=(109, 243, 187), 
                parent_process="wjets"),
        Process("wjets_ht8", Label("Wjets HT8"), color=(126, 238, 124), 
                parent_process="wjets"),

        Process("wjets_fxfx", Label("Wjets FXFX"), color=(5, 87, 92), 
                parent_process="wjets"),
        Process("wjets_mlm", Label("Wjets MLM"), color=(54, 125, 135), 
                parent_process="wjets"),
        Process("wjets_fxfx_0j", Label("Wjets FXFX 0j"), color=(77, 149, 167), 
                parent_process="wjets"),
        Process("wjets_fxfx_1j", Label("Wjets FXFX 1j"), color=(99, 173, 199), 
                parent_process="wjets"),
        Process("wjets_fxfx_2j", Label("Wjets FXFX 2j"), color=(144, 221, 244), 
                parent_process="wjets"),
        Process("wjets_mlm_1j", Label("Wjets MLM 1j"), color=(127, 232, 214), 
                parent_process="wjets"),
        Process("wjets_mlm_2j", Label("Wjets MLM 2j"), color=(109, 243, 187), 
                parent_process="wjets"),
        Process("wjets_mlm_3j", Label("Wjets MLM 3j"), color=(126, 238, 124), 
                parent_process="wjets"),
        Process("wjets_mlm_4j", Label("Wjets MLM 4j"), color=(126, 238, 124), 
                parent_process="wjets"),

        # DY
        Process("dy", Label("DY"), color=(255, 149, 5), parent_process="all_background", llr_name="DY", isDY=True, fatjet_bb_type="DYlike"),

        Process("dy_incl", Label("DY Incl"), color=(0, 165, 80), 
                parent_process="dy", isDY=True),
        Process("dy_ptz1", Label("DY PtZ1"), color=(86, 3, 173), 
                parent_process="dy", isDY=True),
        Process("dy_ptz2", Label("DY PtZ2"), color=(109, 53,186), 
                parent_process="dy", isDY=True),
        Process("dy_ptz3", Label("DY PtZ3"), color=(131, 103,199), 
                parent_process="dy", isDY=True),
        Process("dy_ptz4", Label("DY PtZ4"), color=(179, 161, 232), 
                parent_process="dy", isDY=True),
        Process("dy_ptz5", Label("DY PtZ5"), color=(210, 208, 237), 
                parent_process="dy", isDY=True),
        Process("dy_ptz6", Label("DY PtZ6"), color=(225, 232, 239), 
                parent_process="dy", isDY=True),
        Process("dy_0j", Label("DY 0j"), color=(91, 179, 207), 
                parent_process="dy", isDY=True),
        Process("dy_1j", Label("DY 1j"), color=(109, 243, 187), 
                parent_process="dy", isDY=True),
        Process("dy_2j", Label("DY 2j"), color=(83, 223, 124), 
                parent_process="dy", isDY=True),

        # EWK
        Process("ewk_z",      Label("EWK Z"),     color=(255, 230, 0), parent_process="ewk", fatjet_bb_type="DYlike"),
        Process("ewk_wplus",  Label("EWK W^{+}"), color=(255, 230, 0), parent_process="ewk"),
        Process("ewk_wminus", Label("EWK W^{-}"), color=(255, 230, 0), parent_process="ewk"),
        Process("ewk", Label("EWK"), color=(255, 230, 0), parent_process="others", llr_name="EWK"),

        # TT
        Process("tt_dl", Label("t#bar{t} DL"), color=(40, 194, 255), parent_process="tt"),
        Process("tt_sl", Label("t#bar{t} SL"), color=(40, 194, 255), parent_process="tt"),
        Process("tt_fh", Label("t#bar{t} FH"), color=(40, 194, 255), parent_process="tt"),
        Process("tt", Label("t#bar{t}"), color=(40, 194, 255), parent_process="all_background", llr_name="TT", fatjet_bb_type="TTlike"),
        # TW
        Process("tw", Label("t+W"), color=(255, 230, 0), parent_process="others", llr_name="TW", fatjet_bb_type="TTlike"),
        # singleT
        Process("singlet", Label("st"), color=(255, 230, 0), parent_process="others", llr_name="singleT", fatjet_bb_type="TTlike"),

        # VV
        Process("zz", Label("ZZ"), color=(20, 60, 255), parent_process="vv"),
        Process("wz", Label("WZ"), color=(20, 60, 255), parent_process="vv"),
        Process("ww", Label("WW"), color=(20, 60, 255), parent_process="vv"),
        Process("vv", Label("VV"), color=(20, 60, 255), parent_process="vv_v", llr_name="VV"),
        # VVV
        Process("zzz", Label("ZZZ"), color=(20, 60, 255), parent_process="vvv"),
        Process("wzz", Label("WZZ"), color=(20, 60, 255), parent_process="vvv"),
        Process("www", Label("WWW"), color=(20, 60, 255), parent_process="vvv"),
        Process("wwz", Label("WWZ"), color=(20, 60, 255), parent_process="vvv"), 
        Process("vvv", Label("VVV"), color=(20, 60, 255), parent_process="vv_v", llr_name="VVV"),
        Process("vv_v", Label("VV(V)"), color=(20, 60, 255), parent_process="all_background", fatjet_bb_type="DYlike"), # will apply DY PNet SFs except where there is a Z->bb at gen level

        # TTX
        Process("ttw", Label("TTW"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttz", Label("TTZ"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttww", Label("TTWW"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttwz", Label("TTWZ"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttwh", Label("TTWH"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttzh", Label("TTZH"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttzz", Label("TTZZ"), color=(4, 240, 106), parent_process="ttx"),
        Process("ttx", Label("TTX"), color=(4, 240, 106), parent_process="all_background", llr_name="TTX", fatjet_bb_type="TTlike"),
        
        # zh_hbb_zqq : is defined in ZZ and ZH configs
        # WH_htt
        Process("wh_htt", Label("wh_htt"), color=(130, 39, 197), parent_process="wh"),
        Process("wh", Label("WH"), color=(130, 39, 197), parent_process="higgs", llr_name="WH", fatjet_bb_type="DYlike"),
        # VBF_htt
        Process("vbf_htt", Label("vbf_htt"), color=(130, 39, 197), parent_process="higgs", llr_name="qqH"),
        # ggHZZ
        Process("ggH_ZZ", Label("ggH_ZZ"), color=(130, 39, 197), parent_process="higgs", llr_name="ggH", fatjet_bb_type="HHlike"),
        # ttH_hbb
        Process("tth_bb", Label("t#bar{t}H bb"), color=(130, 39, 197), parent_process="ttH"),
        Process("tth_tautau", Label("t#bar{t}H #tau#tau"), color=(130, 39, 197), parent_process="ttH"),
        Process("tth_nonbb", Label("t#bar{t}H nonbb"), color=(130, 39, 197), parent_process="ttH"),
        Process("ttH", Label("t#bar{t}H"), color=(130, 39, 197), parent_process="higgs", llr_name="ttH", fatjet_bb_type="TTlike"),
        # ggHH
        Process("ggf_sm", Label("HH_{ggF}"), color=(130, 39, 197), isSignal=False, parent_process="higgs", llr_name="ggHH_kl_1_kt_1_hbbhtt", fatjet_bb_type="HHlike"),
        Process("higgs", Label("Higgs"), color=(130, 39, 197), parent_process="all_background", llr_name="Higgs"),

        Process("others", Label("Others"), color=(255, 230, 0),
            parent_process="all_background"),

        # Data
        Process("data", Label("Data"), color=(0, 0, 0), isData=True),
        Process("data_tau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),
        Process("data_etau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),
        Process("data_mutau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),
        Process("data_met", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),

        # unused currently for ZZ/ZH analysis
        Process("ggf", Label("HH_{ggF}"), color=(130, 39, 197), isSignal=False, llr_name="ggH", fatjet_bb_type="HHlike",
            parent_process="all_background"),
        Process("ggf_0_1", Label("HH_{ggF}^{(0, 1)}"), color=(0, 0, 0), isSignal=False,
            parent_process="ggf"),
        Process("ggf_2p45_1", Label("HH_{ggF}^{(2.45, 1)}"), color=(0, 0, 0), isSignal=False,
            parent_process="ggf"),
        Process("ggf_5_1", Label("HH_{ggF}^{(5, 1)}"), color=(0, 0, 0), isSignal=False,
            parent_process="ggf"),

        # unused currently for ZZ/ZH analysis
        Process("vbf", Label("HH_{VBF}"), color=(0, 0, 0), isSignal=False, llr_name="qqH", fatjet_bb_type="HHlike"),
        Process("vbf_sm", Label("HH_{VBF}"), color=(0, 0, 0), isSignal=False, parent_process="vbf"),
        Process("vbf_0p5_1_1", Label("HH_{VBF}^{(0.5,1,1)}"), color=(0, 0, 0),
            isSignal=False, parent_process="vbf"),
        Process("vbf_1p5_1_1", Label("HH_{VBF}^{(1.5,1,1)}"), color=(0, 0, 0),
            isSignal=False, parent_process="vbf"),
        Process("vbf_1_0_1", Label("HH_{VBF}^{(1,0,1)}"), color=(255, 153, 0),
            isSignal=False, parent_process="vbf"),
        Process("vbf_1_1_0", Label("HH_{VBF}^{(1,1,0)}"), color=(0, 0, 0),
            isSignal=False, parent_process="vbf"),
        Process("vbf_1_1_2", Label("HH_{VBF}^{(1,1,2)}"),
            color=(0, 0, 0), isSignal=False, parent_process="vbf"),
        Process("vbf_1_2_1", Label("HH_{VBF}^{(1,2,1)}"),
            color=(255, 102, 102), isSignal=False, parent_process="vbf"),

        Process("all_background", Label("Background"), color=(0, 0, 255)),

    ]

    process_group_names = {
        "data_tau": [
            "data_tau",
        ],
        "data_etau": [
            "data_etau",
        ],
        "bkg": [
            "tt_dl",
        ],
        "signal": [
            "ggf_sm",
        ],
        "data_bkg": [ # mostly used for FeaturePlot2D (ie plotting jet veto maps)
            "data",
            "all_background"
        ],
        "etau": [
            "tt_dl",
            "tt_sl",
            "tt_fh",
            "dy",
            "others",
            "data_etau",
        ],
        "mutau": [
            "tt_dl",
            "tt_sl",
            "tt_fh",
            "dy",
            "others",
            "data_mutau",
        ],
        "mutau_tmp": [
            "tt_dl",
            "tt_sl",
            "tt_fh",
            "dy",
            "wjets",
            "data_mutau",
        ],
        "tautau": [
            "tt_dl",
            "tt_sl",
            "tt_fh",
            "dy",
            "others",
            "data_tau",
        ],
        "vbf": [
            "vbf_sm",
            "vbf_0p5_1_1",
            "vbf_1p5_1_1",
            "vbf_1_0_1",
            "vbf_1_1_0",
            "vbf_1_1_2",
            "vbf_1_2_1"
        ],
        "ggf": [
            "ggf_sm",
            "ggf_0_1",
            "ggf_2p45_1",
            "ggf_5_1",
        ],
    }

    process_training_names = {
        "default": [
            "ggf_sm",
            "dy"
        ]
    }

    return ObjectCollection(processes), process_group_names, process_training_names

class BaseConfig(cmt_config):
    def __init__(self, *args, **kwargs):
        self.tauId_algo = "idDeepTau2017v2p1"
        self.add_bjet_id(kwargs["year"], kwargs.get("runPeriod", None), "DeepFlavB")
        self.channels = self.add_channels()
        self.regions = self.add_regions()
        self.categories = self.add_categories()
        self.cross_section_dict = cross_section_dict
        super().__init__(*args, **kwargs)
        # propagating fatjet_bb_type to every process. If a process does not have it, take it from a parent process
        for process in self.processes:
            upper_process = process
            fatjet_bb_type = None
            while fatjet_bb_type is None and upper_process.parent_process is not None:
                fatjet_bb_type = upper_process.get_aux("fatjet_bb_type")
                upper_process = self.processes.get(upper_process.parent_process)
            if fatjet_bb_type is not None:
                process.aux["fatjet_bb_type"] = fatjet_bb_type

    def join_selection_channels(self, selection):
        """ Takes a dict channel -> [selection], where the list of selections is first and-ed (with parentheses) 
        and makes a selection (etau && selection[etau]) || (mutau && selection[mutau]) || (tautau && selection[tautau])
        Channel selections are taken from self.channels.selection (aka pairType)
        """
        return jrs([jrs(jrs(selection[ch.name], op="and"), ch.selection, op="and")
            for ch in self.channels], op="or")

    def combine_selections_per_channel(self, selection1, selection2):
        selection = DotDict()
        for channel in selection1:
            selection[channel] = jrs(jrs(selection1[channel], op="and"),
                jrs(selection2[channel], op="and"), op="or")
        return selection

    def add_regions(self):
        selection = OrderedDict()
        region_names = ["Signal region", "OS inv. iso", "SS iso", "SS inv. iso"]

        if self.useBoostedTaus:
            dau1_iso = f"isBoostedTau ? dau1_rawIdDeepTauVSjet >= {self.deepboostedtau.vsjet.LooseWisc} : dau1_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Medium}"
            """ Medium isolation of dau1 (for tautau channel) """
            dau2_iso = f"isBoostedTau ? dau2_rawIdDeepTauVSjet >= {self.deepboostedtau.vsjet.LooseWisc} : dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Medium}"
            """ Medium isolation of dau2 """
            dau2_loosenedIso = [
                f"isBoostedTau ? dau2_rawIdDeepTauVSjet >= {self.deepboostedtau.vsjet.VLooseQCD} : dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.VVVLoose}", 
                f"isBoostedTau ? dau2_rawIdDeepTauVSjet < {self.deepboostedtau.vsjet.LooseWisc} : dau2_idDeepTau2017v2p1VSjet < {self.deeptau.vsjet.Medium}"]
            """ Loosened isolation for QCD reduced isolation control region """
            
        else:
            dau1_iso = f"dau1_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Medium}"
            """ Medium isolation of dau1 (for tautau channel) """
            dau2_iso = f"dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.Medium}"
            """ Medium isolation of dau2 """
            dau2_loosenedIso = [
                f"dau2_idDeepTau2017v2p1VSjet >= {self.deeptau.vsjet.VVVLoose}", 
                f"dau2_idDeepTau2017v2p1VSjet < {self.deeptau.vsjet.Medium}"]
            """ Loosened isolation for QCD reduced isolation control region """

        selection["os_iso"] = {
            "mutau": ["isOS == 1", dau2_iso],
            "etau": ["isOS == 1", dau2_iso],
            "tautau": ["isOS == 1",
                dau1_iso,
                dau2_iso],
        }
        selection["os_inviso"] = {
            "mutau": ["isOS == 1", *dau2_loosenedIso],
            "etau": ["isOS == 1", *dau2_loosenedIso],
            "tautau": ["isOS == 1",
                dau1_iso,
                *dau2_loosenedIso],
        }
        selection["ss_iso"] = {
            "mutau": ["isOS == 0", dau2_iso],
            "etau": ["isOS == 0", dau2_iso],
            "tautau": ["isOS == 0",
                dau1_iso,
                dau2_iso],
        }
        selection["ss_inviso"] = {
            "mutau": ["isOS == 0", *dau2_loosenedIso],
            "etau": ["isOS == 0", *dau2_loosenedIso],
            "tautau": ["isOS == 0",
                dau1_iso,
                *dau2_loosenedIso],
        }
        regions = []
        for ikey, qcd_key in enumerate(selection): # os_iso, os_inviso, etc
            regions.append(Category(qcd_key, label=Label(region_names[ikey]),
                selection=self.join_selection_channels(selection[qcd_key])))
            for channel in self.channels:
                regions.append(Category("_".join([channel.name, qcd_key]),
                    label=Label(", ".join([channel.label.root, region_names[ikey]])),
                    selection=jrs(channel.selection,
                        jrs(selection[qcd_key][channel.name], op="and"), op="and")))
                for tau_name, tau_cut in [("boostedTaus", "isBoostedTau"), ("HPSTaus", "!isBoostedTau")]:
                    regions.append(Category("_".join([channel.name, qcd_key, tau_name]),
                    label=Label(", ".join([channel.label.root, region_names[ikey], tau_cut])),
                    selection=jrs([
                            channel.selection,
                            jrs(selection[qcd_key][channel.name], op="and"),
                            tau_cut
                        ], op="and")))
        for channel in self.channels:
            regions.append(Category(f"{channel.name}_os",
                label=f"{channel.label.root}, OS (no QCD isolation cut)",
                selection=jrs(channel.selection,
                    "isOS == 1")))
            regions.append(Category(f"{channel.name}_ss",
                label=f"{channel.label.root}, SS (no QCD isolation cut)",
                selection=jrs(channel.selection,
                    "isOS == 0", op="and")))
        regions.append(Category(f"baseline_region",
            label="baseline etau+mutau+tautau",
            selection="pairType>=0 && pairType <= 2"))
        regions.append(Category(f"baseline_hem_affected",
            label="EraCD - baseline etau+mutau+tautau",
            selection="pairType>=0 && pairType <= 2 && hem_affected_run"))
        return ObjectCollection(regions)

    def add_channels(self):
        channels = [
            Category("mutau", Label("#tau_{#mu}#tau_{h}"), selection="pairType == 0"),
            Category("etau", Label("#tau_{e}#tau_{h}"), selection="pairType == 1"),
            Category("tautau", Label("#tau_{h}#tau_{h}"), selection="pairType == 2"),
        ]
        return ObjectCollection(channels)
    
    def get_bjets_requirements(self):
        """ Compute the requirements for btagging for the different categories.
        Returns dict with keys req_1b, req_2b, req_ll 
        Uses self.btag_algo_wps
        """
        reqs = DotDict()
        btag = "Jet_btagDeepFlavB.at(bjet{}_JetIdx)"
        df = lambda i, op, wp: "{} {} {}".format(btag.format(i), op, self.btag_algo_wps[wp])
        reqs.req_1b = jrs(jrs(df(1, ">", "medium"), df(2, "<", "medium"), op="and"),
                jrs(df(1, "<", "medium"), df(2, ">", "medium"), op="and"), op="or")  # exactly one b jet passes medium (for res1b)
        reqs.req_2b = jrs(df(1, ">", "medium"), df(2, ">", "medium")) # both bjets pass medium (for res2b)
        reqs.req_1or2b = jrs(df(1, ">", "medium"), df(2, ">", "medium"), op="or") # at least one b jets passes medium (res1b | res2b), for orthogonality of boosted with resolved
        reqs.req_ll = jrs(df(1, ">", "loose"), df(2, ">", "loose")) # both bjets pass loose (for old boosted, not used now) 

        # TODO see if there is SFs applying here and if we need to use {{ ... }} syntax to have migrating events
        self.boosted_bb_tagging_wp = self.particleNetMD_legacy.low
        reqs.boosted_pnet = f"(FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)/(FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)+FatJet_particleNetLegacy_QCD.at(fatjet_JetIdx)) >= {self.boosted_bb_tagging_wp})"
        return reqs
    
    def get_categories_requirements(self):
        """ Requirements for selecting res1b, res2b & boosted categories """
        
        bjets = self.get_bjets_requirements()
        # req_2jets = "(bjet1_JetIdx >= 0)" # requires that we have 2 AK4 jets selected by hhbtag, prerequisite for resolved (if bjet1_JetIdx is there then bjet2_JetIdx is also there)
        reqs = DotDict()
        reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail = DotDict() # priority to res2b, for HPSTaus category
        reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail.resolved_2b = f"(bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_2b}))" # res2b has priority
        reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail.boosted_bb = f"(!({reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail.resolved_2b}) && fatjet_JetIdx>=0 && ({bjets.boosted_pnet}))" # fatjet passing pnet & not res2b
        reqs.jet_cat_Res2b_Boosted_Res1b_noPNetFail.resolved_1b = f"(bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_1b}) && !(fatjet_JetIdx>=0 && ({bjets.boosted_pnet})))" # 2 jets & exactly one b-tag (->orthogonal res2b) & no fatjet passing pnet (orthogonalize boosted)

        reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail = DotDict() # priority to boosted, for boostedTaus category
        reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail.boosted_bb = f"(fatjet_JetIdx>=0 && ({bjets.boosted_pnet}))" # priority boosted
        reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail.resolved_2b = f"(!{reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail.boosted_bb} && bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_2b}))"
        reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail.resolved_1b = f"(!{reqs.jet_cat_Boosted_Res2b_Res1b_noPNetFail.boosted_bb} && bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_1b}))"

        # old code giving priority to boosted
            # reqs.resolved_1b = f"(isBoosted == 0 && bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_1b}))"
            # reqs.resolved_2b = f"(isBoosted == 0 && bjet1_JetIdx>=0 && bjet2_JetIdx>=0 && ({bjets.req_2b}))"
            # # Following not needed since orthogonalization done at HHJets level
            # ## need to orthogonalize boosted to resolved. -> need isBoosted = 1 (ie there is an AK8 jet passing selection), and :
            # ## - either we have <2 AK4 jets passing the first selections (before hhbtag and btag, ie pt, PUid, deltaR) 
            # ## - or we have >= 2 AK4 jets but the 2 hhbtag-selected jets both fail the medium btag WP
            # ## note the order of evaluation, important to not access Jet collections with -1 index
            # reqs.boosted_bb = f"(isBoosted == 1) && fatjet_JetIdx>=0 && ({bjets.boosted_pnet})"
            # reqs.boosted = reqs.boosted_bb # for backwards compatibility

        # Taus categories
        reqs.HPSTau = "(isBoostedTau == false && pairType >= 0)"
        reqs.boostedTau = "(isBoostedTau == true && pairType >= 0)"

        # reqs.all_categories = f"(pairType >= 0 && (({reqs.boosted_bb}) || ({reqs.resolved_1b}) || ({reqs.resolved_2b})))" # ALl categories (for DNN training)
        return reqs

    def add_categories(self, **kwargs):
        """ NOT USED """
        reject_sel = ["pairType == -31415"]

        sel = DotDict()
        btag = kwargs.pop("btag", "Jet_btagDeepFlavB.at(bjet{}_JetIdx)")
        df = lambda i, op, wp: "{} {} {}".format(btag.format(i), op, self.btag_algo_wps[wp])
        sel["btag"] = DotDict(
            m_first=[df(1, ">", "medium")], # bjet 1 passes medium btag WP
            m_second=[df(2, ">", "medium")],
            m_any=[jrs(df(1, ">", "medium"), df(2, ">", "medium"), op="or")], # at least one of bjet 1 or 2 passes medium WP
            l=[df(1, ">", "loose"), df(2, "<", "loose")], # bjet1 passes loose, bjet 2 fails loose
            ll=[df(1, ">", "loose"), df(2, ">", "loose")], # both bjets pass loose
            m=[jrs(jrs(df(1, ">", "medium"), df(2, "<", "medium"), op="and"),
                jrs(df(1, "<", "medium"), df(2, ">", "medium"), op="and"), op="or")], # exactly one b jet passes medium
            mm=[df(1, ">", "medium"), df(2, ">", "medium")], # both bjets pass medium
            not_mm=[df(1, "<", "medium"), df(2, "<", "medium")], # both bjets fail medium
        )

        # If we use {{}} the name of the feature is replaced by the expression we define in the feature object (including syst in case)
        _excl_vbf_loose_nob = ["{{VBFjj_mass}} > 500", "abs({{VBFjj_deltaEta}}) > 3",
            "isVBFtrigger == 0"]
        _excl_vbf_loose = _excl_vbf_loose_nob + sel.btag.m_any
        _excl_non_vbf_loose = ["!" + jrs(_excl_vbf_loose, op="and")]

        _excl_vbf_tight_nob = ["{{vbfjet1_pt}} > 140", "{{vbfjet2_pt}} > 60", "{{VBFjj_mass}} > 800",
            "abs({{VBFjj_deltaEta}}) > 3", "isVBFtrigger == 1"]
        _excl_vbf_tight = _excl_vbf_tight_nob + sel.btag.m_any
        _excl_non_vbf_tight = ["!" + jrs(_excl_vbf_tight, op="and")]

        _excl_non_vbf = ["!" + jrs(jrs(_excl_vbf_loose, op="and"), jrs(_excl_vbf_tight, op="and"),
            op="or")]

        mass_ellipse_sel = ["(({{Htt_svfit_mass}} - 129.) * ({{Htt_svfit_mass}} - 129.)/ (53. * 53.)"
            " + ({{Hbb_mass}} - 169.) * ({{Hbb_mass}} - 169.) / (145. * 145.)) < 1"]
        mass_boost_sel = ["(({{Htt_svfit_mass}} - 128.) * ({{Htt_svfit_mass}} - 128.) / (60. * 60.)"
            " + ({{Hbb_mass}} - 159.) * ({{Hbb_mass}} - 159.) / (94. * 94.)) < 1"]
        sel["resolved_1b"] = DotDict({
            ch: (sel.btag.m + mass_ellipse_sel + ["isBoosted != 1"]
                + _excl_non_vbf_loose)
            for ch in self.channels.names()
        })
        sel["resolved_1b_combined"] = self.join_selection_channels(sel["resolved_1b"])
        sel["resolved_2b"] = DotDict({
            ch: (sel.btag.mm + mass_ellipse_sel + ["isBoosted != 1"]
                + _excl_non_vbf)
            for ch in self.channels.names()
        })
        sel["resolved_2b_combined"] = self.join_selection_channels(sel["resolved_2b"])
        sel["boosted"] = DotDict({
            ch: (sel.btag.ll + mass_boost_sel + ["isBoosted == 1"]
                + _excl_non_vbf)
            for ch in self.channels.names()
        })
        sel["boosted_combined"] = self.join_selection_channels(sel["boosted"])
        sel["vbf_loose"] = DotDict({
            ch: _excl_vbf_loose
            for ch in self.channels.names()
        })
        sel["vbf_loose_combined"] = self.join_selection_channels(sel.vbf_loose)
        sel["vbf_tight"] = DotDict(
            mutau=reject_sel,  # category not used, should always reject
            etau=reject_sel,  # category not used, should always reject
            tautau=_excl_vbf_tight + sel.btag.m_any,
        )
        sel["vbf_tight_combined"] = self.join_selection_channels(sel.vbf_tight)
        sel["vbf"] = self.combine_selections_per_channel(sel.vbf_tight, sel.vbf_loose)
        sel["vbf_combined"] = self.join_selection_channels(sel.vbf)

        goodtaus = ("("
            "Tau_idDeepTau2017v2p1VSjet>=1 && Tau_idDeepTau2017v2p1VSmu>=1 && Tau_idDeepTau2017v2p1VSe>=2 && " 
            "(Tau_idDecayModeNewDMs == 0 || Tau_idDecayModeNewDMs == 1 || Tau_idDecayModeNewDMs == 10 || Tau_idDecayModeNewDMs == 11) &&"
            "Tau_dz <= 0.2"
            ")"
        )
        base_HPS_emutau = (
            f"ROOT::VecOps::Any({goodtaus}) && (ROOT::VecOps::Any("
            "Muon_eta<=2.4 && Muon_pfRelIso04_all<=0.15 && Muon_dxy<=0.045&&Muon_dz<=0.2&&Muon_tightId"
            ") || ROOT::VecOps::Any("
            "Electron_pt>=18 && Electron_mvaIso_WP80 && Electron_dxy<=0.045 && Electron_dz<=0.2 && Electron_eta<=2.5"
            "))"
        )
        base_HPS = f"(({base_HPS_emutau}) || (Tau_dz[{goodtaus}].size()>=2))"

        base_goodBoostedTaus = "boostedTau_pt>=30 && boostedTau_eta<=2.5 && (boostedTau_decayMode == 0 || boostedTau_decayMode == 1 || boostedTau_decayMode == 10 || boostedTau_decayMode == 11)"
        base_boostedTau_emutau = (
            f"ROOT::VecOps::Any({base_goodBoostedTaus}) && (ROOT::VecOps::Any("
            "Muon_eta<=2.4 && Muon_dxy<=0.045&&Muon_dz<=0.2&&Muon_looseId"
            ") || ROOT::VecOps::Any("
            "Electron_pt>=25 && Electron_dxy<=0.045 && Electron_dz<=0.2 && Electron_eta<=2.5"
            "))"
        )
        base_boostedTaus = f"MET_pt>=150&&(({base_boostedTau_emutau}) || (boostedTau_pt[{base_goodBoostedTaus}].size()>=2))"

        categories = [
            Category("base", "base", selection=""),
            Category("base_noWeights", "no selection, no weights", selection="1"),
            Category("base_fixedGenWeight", "base with genWeight (fixed)", selection="1"),
            Category("base_oldGenWeight", "base with old genWeight (no fix)", selection="1"),
            Category("baseline", "Baseline", selection="pairType >= 0 && pairType <= 2 && ((bjet1_JetIdx>=0&&bjet2_JetIdx)||(fatjet_JetIdx>=0))"),
            Category("base_selection", "base",
                selection=f"({base_HPS}) || ({base_boostedTaus})", selection_HPS=f"({base_HPS})"),
            # Category("baseline_sr", "baseline Signal region",
            #     selection="((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
            #         "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
            #         "((pairType == 2) && (isOS == 1) && "
            #         "(dau2_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0})) "
            #         .format(self.deeptau.vsjet.Medium)),
            # Category("dum", "dummy category", selection="event == 220524669"),
            Category("dum", "dummy category", selection="event == 74472670"),
            Category("debug", "debug category", selection="luminosityBlock == 315421 && event == 315420434"),
            Category("mutau", "#mu#tau channel", selection="pairType == 0"),
            Category("etau", "e#tau channel", selection="pairType == 1"),
            Category("tautau", "#tau#tau channel", selection="pairType == 2"),
            # Category("resolved_1b", label="Resolved 1b category",
            #     selection=sel["resolved_1b_combined"]),
            # Category("resolved_2b", label="Resolved 2b category",
            #     selection=sel["resolved_2b_combined"]),
            # Category("boosted", label="Boosted category",
            #     selection=sel["boosted_combined"]),
            # Category("vbf_loose", label="VBF (loose) category",
            #     selection=sel["vbf_loose_combined"]),
            # Category("vbf_tight", label="VBF (tight) category",
            #     selection=sel["vbf_tight_combined"]),
            # Category("vbf", label="VBF category",
            #     selection=sel["vbf_combined"]),
        ]
        return ObjectCollection(categories)
    
    def add_features(self):
        # important : for Categorization with --syetmatic  it is important that systematics are enabled here
        systematics_mode = "full"
        if systematics_mode in ["reduced", "full", "one_jec"]: # reduced systematics
            if systematics_mode == "reduced":
                self.jec_systs = ["jec_1"] # jec_2
            elif systematics_mode == "one_jec":
                self.jec_systs = ["jec"]
            elif systematics_mode == "full":
                self.jec_systs = ["jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                                "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]
            self.jme_systs = ["jer"] + self.jec_systs
            self.jet_systs_params = dict(central="jer", systematics=self.jme_systs)
            self.tau_systs_params = dict(central="tes", systematics=["tes"])
            if systematics_mode == "reduced":
                self.electron_systs = dict()
                self.lepton_systs_params =  dict(systematics=["tes"]) # you may need to add central="tes", 
            else:
                self.electron_systs = dict(systematics=["ele_scale", "ele_resolution"])
                self.lepton_systs_params =  dict(systematics=["ele_scale", "ele_resolution", "tes"]) # you may need to add central="tes", 
            self.didau_systs_params = self.lepton_systs_params # for dau1 & dau2 at same time (+MET)

            # met systs are special systematics to allow plotting of met variables without PrePlot crashing
            #self.met_systs = dict(central="met_tes_xycorr", systematics=list(map(lambda s:s.replace("_", "_MET_"), self.jec_systs)) + ["tes_MET", "met_unclustered_MET"]) 
            self.met_systs = dict(systematics=self.jec_systs+self.lepton_systs_params["systematics"]+["met_unclustered"])

            self.all_systs = self.lepton_systs_params["systematics"] + ["met_unclustered"] + self.jme_systs
        elif systematics_mode == "no_systs": # no systs
            self.jec_systs = []
            self.jme_systs = []
            self.jet_systs_params = dict(central="jer", systematics=self.jme_systs)
            self.tau_systs_params = dict(central="tes", systematics=[])
            self.electron_systs = dict()
            self.lepton_systs_params =  dict(systematics=[]) # you may need to add central="tes", 
            self.didau_systs_params = self.lepton_systs_params # for dau1 & dau2 at same time

            self.met_systs = dict(central="met_tes_xycorr", systematics=[]) 

            self.all_systs = [] + self.jme_systs
        else:
            raise ValueError()

        # event weight systs only need to be included in the feature that is used in config.weights
        phi_binning = (20, -math.pi, math.pi)
        phi_binning_50 = (50, -math.pi, math.pi)
        features = [
            ########## Base objects features (for checking corrections)
            Feature("jet_pt", "Jet_pt", binning=(30, 0, 300),
                x_title=Label("jet p_{T} (no corrections)"),
                units="GeV", tags=["jet", "baseObjects"]),
            Feature("jet_pt_smeared", "Jet_pt", binning=(30, 0, 300),
                x_title=Label("jet p_{T} (smeared)"), **self.jet_systs_params,
                units="GeV", tags=["jet", "baseObjects"]),
            Feature("jet_eta", "Jet_eta", binning=(50, -5., 5.),
                x_title=Label("jet #eta (all jets)"),
                tags=["jet", "baseObjects"]),
            Feature("jet_phi", "Jet_phi", binning=phi_binning_50,
                x_title=Label("jet #phi (all jets)"),
                tags=["jet", "baseObjects"]),
            Feature("jet_mass", "Jet_mass", binning=(30, 0, 100),
                x_title=Label("jet mass (no corrections)"),
                units="GeV", tags=["jet", "baseObjects"]),
            Feature("jet_mass_smeared", "Jet_mass", binning=(30, 0, 100),
                x_title=Label("jet mass (smeared)"), **self.jet_systs_params,
                units="GeV", tags=["jet", "baseObjects"]),
            
            Feature("nJet", "nJet", binning=(20, 0, 20),
                x_title=Label("nJet"), tags=["jet"]),
            
            # For jet veto maps. jets_hem_preselection is a RVec<bool> computed in hemIssueRDF
            Feature("jet_eta_hem", "Jet_eta[jets_hem_preselection]", binning=(50, -5., 5.),
                x_title=Label("jet #eta (all jets with ID)"),
                tags=["jet", "baseObjects"]),
            Feature("jet_phi_hem", "Jet_phi[jets_hem_preselection]", binning=phi_binning_50,
                x_title=Label("jet #phi (all jets with ID)"),
                tags=["jet", "baseObjects"]),
            
            Feature("btagging", "Jet_btagDeepFlavB", binning=(30,0,1),
                x_title=Label("b-tagging score"), tags=["base", "baseObjects"]),

            # leptons
            Feature("electron_pt", "Electron_pt", binning=(30, 0, 300),
                x_title=Label("Electron p_{T} (ID+ISO SFs only)"),
                units="GeV", tags=["electron", "baseObjects"]),
            Feature("electron_pt_SS", "Electron_pt", binning=(30, 0, 300),
                x_title=Label("Electron p_{T} (scale&smearing)"),
                units="GeV", tags=["electron", "baseObjects"], **self.electron_systs),
            Feature("electron_eta", "Electron_eta", binning=(50, -3., 3.),
                x_title=Label("electron #eta (all electrons)"),
                tags=["electron", "baseObjects"]),
            Feature("electron_phi", "Electron_phi", binning=phi_binning_50,
                x_title=Label("electron #phi (all electrons)"),
                tags=["electron", "baseObjects"]),
            Feature("electron_mass", "Electron_mass", binning=(30, 0, 0.3),
                x_title=Label("electron mass (ID+ISO SFs only)"),
                units="GeV", tags=["electron", "baseObjects"]),
            Feature("electron_mass_SS", "Electron_mass", binning=(30, 0, 0.3),
                x_title=Label("electron mass (SFs&scale&smearing)"), **self.electron_systs,
                units="GeV", tags=["electron", "baseObjects"]),
            
            Feature("muon_pt", "Muon_pt", binning=(30, 0, 300),
                x_title=Label("Muon p_{T}"),
                units="GeV", tags=["muon", "baseObjects"]),
            Feature("muon_eta", "Muon_eta", binning=(50, -3., 3.),
                x_title=Label("muon #eta (all muons)"),
                tags=["muon", "baseObjects"]),
            Feature("muon_phi", "Muon_phi", binning=phi_binning_50,
                x_title=Label("muon #phi (all muons)"),
                tags=["muon", "baseObjects"]),
            Feature("muon_mass", "Muon_mass", binning=(30, 0, 0.2),
                x_title=Label("muon mass"),
                units="GeV", tags=["muon", "baseObjects"]),

            Feature("tau_pt", "Tau_pt", binning=(30, 0, 300),
                x_title=Label("Tau p_{T} (ID SFs only)"),
                units="GeV", tags=["tau", "baseObjects"]),
            Feature("tau_pt_tes", "Tau_pt", binning=(30, 0, 300),
                x_title=Label("Tau p_{T} (SFs&TES)"),
                units="GeV", tags=["tau", "baseObjects"], **self.tau_systs_params),
            Feature("tau_eta", "Tau_eta", binning=(50, -3., 3.),
                x_title=Label("tau #eta (all taus)"),
                tags=["tau", "baseObjects"]),
            Feature("tau_phi", "Tau_phi", binning=phi_binning_50,
                x_title=Label("tau #phi (all taus)"),
                tags=["tau", "baseObjects"]),
            Feature("tau_mass", "Tau_mass", binning=(30, 0, 2.),
                x_title=Label("tau mass (ID SFs only)"),
                units="GeV", tags=["tau", "baseObjects"]),
            Feature("tau_mass_tes", "Tau_mass", binning=(30, 0, 2.),
                x_title=Label("tau mass (SFs&TES)"), **self.tau_systs_params,
                units="GeV", tags=["tau", "baseObjects"]),

            # bjet features
            Feature("bjet1_pt", "Jet_pt.at(bjet1_JetIdx)", binning=(20, 20, 220),
                x_title=Label("b_{1} p_{T}"), selection="bjet1_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("bjet1_pt_high", "Jet_pt.at(bjet1_JetIdx)", binning=(30, 20, 500),
                x_title=Label("b_{1} p_{T}"), selection="bjet1_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("bjet1_eta", "Jet_eta.at(bjet1_JetIdx)", binning=(20, -3., 3.),
                x_title=Label("b_{1} #eta"), selection="bjet1_JetIdx>=0", tags=["base"]),
            Feature("bjet1_phi", "Jet_phi.at(bjet1_JetIdx)", binning=phi_binning,
                x_title=Label("b_{1} #phi"), selection="bjet1_JetIdx>=0", tags=["base"]),
            Feature("bjet1_mass", "Jet_mass.at(bjet1_JetIdx)", binning=(20, 0, 60),
                x_title=Label("b_{1} m"), selection="bjet1_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("bjet1_btagScore", "Jet_btagDeepFlavB.at(bjet1_JetIdx)", binning=(30,0,1),
                x_title=Label("b-tagging score of b-jet 1"), selection="bjet1_JetIdx>=0", tags=["base"]),
            Feature("bjet2_pt", "Jet_pt.at(bjet2_JetIdx)", binning=(20, 20, 220),
                x_title=Label("b_{2} p_{T}"),
                units="GeV", tags=["base"], selection="bjet2_JetIdx>=0",
                **self.jet_systs_params),
            Feature("bjet2_pt_high", "Jet_pt.at(bjet2_JetIdx)", binning=(30, 20, 500),
                x_title=Label("b_{2} p_{T}"),
                units="GeV", tags=["base"], selection="bjet2_JetIdx>=0",
                **self.jet_systs_params),
            Feature("bjet2_eta", "Jet_eta.at(bjet2_JetIdx)", binning=(20, -3., 3.),
                x_title=Label("b_{2} #eta"), selection="bjet2_JetIdx>=0", tags=["base"]),
            Feature("bjet2_phi", "Jet_phi.at(bjet2_JetIdx)", binning=phi_binning,
                x_title=Label("b_{2} #phi"), selection="bjet2_JetIdx>=0", tags=["base"]),
            Feature("bjet2_mass", "Jet_mass.at(bjet2_JetIdx)", binning=(20, 0, 60),
                x_title=Label("b_{2} m"), selection="bjet2_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("bjet2_btagScore", "Jet_btagDeepFlavB.at(bjet2_JetIdx)", binning=(30,0,1),
                x_title=Label("b-tagging score of b-jet 2"), selection="bjet2_JetIdx>=0", tags=["base"]),

            Feature("bjet_difpt", "abs({{bjet1_pt}} - {{bjet2_pt}})", binning=(10, 50, 150),
                x_title=Label("bb #Delta p_t"), selection="bjet1_JetIdx>=0 && bjet2_JetIdx>=0",
                units="GeV", # TODO add tags here
                **self.jet_systs_params),
            
            # fatjet features
            Feature("fatjet_pt", "FatJet_pt.at(fatjet_JetIdx)", binning=(20, 200, 500),
                x_title=Label("FatJet p_{T}"), selection="fatjet_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("fatjet_pt_high", "FatJet_pt.at(fatjet_JetIdx)", binning=(30, 200, 3000),
                x_title=Label("FatJet p_{T}"), selection="fatjet_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("fatjet_eta", "FatJet_eta.at(fatjet_JetIdx)", binning=(20, -3.2, 3.2),
                x_title=Label("FatJet #eta"), selection="fatjet_JetIdx>=0", tags=["base"]),
            Feature("fatjet_phi", "FatJet_phi.at(fatjet_JetIdx)", binning=phi_binning,
                x_title=Label("FatJet #phi"), selection="fatjet_JetIdx>=0", tags=["base"]),
            Feature("fatjet_mass", "FatJet_mass.at(fatjet_JetIdx)", binning=(20, 0, 200),
                x_title=Label("FatJet m"), selection="fatjet_JetIdx>=0",
                units="GeV", tags=["base"],
                **self.jet_systs_params),
            Feature("fatjet_msoftdrop", "FatJet_msoftdrop.at(fatjet_JetIdx)", binning=(20, 0, 200),
                x_title=Label("FatJet SoftDrop mass"), selection="fatjet_JetIdx>=0",
                units="GeV", tags=["base"],
                ), # TODO softdrop systematics ??
            Feature("fatjet_pnet_XbbVsQCD", "FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)/(FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)+FatJet_particleNetLegacy_QCD.at(fatjet_JetIdx))", binning=(40, 0, 1),
                x_title=Label("FatJet ParticleNet XbbVsQCD"), selection="fatjet_JetIdx>=0",
                tags=["base"],
                ),
            Feature("fatjet_pnet_XbbVsQCD_near1", "FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)/(FatJet_particleNetLegacy_Xbb.at(fatjet_JetIdx)+FatJet_particleNetLegacy_QCD.at(fatjet_JetIdx))", binning=(40, self.boosted_bb_tagging_wp, 1),
                x_title=Label("FatJet ParticleNet XbbVsQCD"), selection="fatjet_JetIdx>=0",
                tags=["base"],
                ),

            # jets features
            # Feature("ctjet1_pt", "Jet_pt.at(ctjet_indexes.at(0))", binning=(10, 50, 150),
            #     x_title=Label("add. central jet 1 p_{t}"),
            #     units="GeV", tags=["extra"],
            #     selection="ctjet_indexes.size() > 0",
            #     **self.jet_systs_params),
            # Feature("ctjet1_eta", "Jet_eta.at(ctjet_indexes.at(0))", binning=(20, -5., 5.),
            #     x_title=Label("add. central jet 1 #eta"), tags=["extra"],
            #     selection="ctjet_indexes.size() > 0"),
            # Feature("ctjet1_phi", "Jet_phi.at(ctjet_indexes.at(0))", binning=phi_binning,
            #     x_title=Label("add. central jet 1 #phi"), tags=["extra"],
            #     selection="ctjet_indexes.size() > 0"),
            # Feature("ctjet1_mass", "Jet_mass.at(ctjet_indexes.at(0))", binning=(10, 50, 150),
            #     x_title=Label("add. central jet 1 m"),
            #     units="GeV", tags=["extra"],
            #     selection="ctjet_indexes.size() > 0",
            #     **self.jet_systs_params),
            # Feature("fwjet1_pt", "Jet_pt.at(fwjet_indexes.at(0))", binning=(10, 50, 150),
            #     x_title=Label("add. forward jet 1 p_t"),
            #     units="GeV", tags=["extra"],
            #     selection="fwjet_indexes.size() > 0",
            #     **self.jet_systs_params),
            # Feature("fwjet1_eta", "Jet_eta.at(fwjet_indexes.at(0))", binning=(20, -5., 5.),
            #     x_title=Label("add. forward jet 1 #eta"), tags=["extra"],
            #     selection="fwjet_indexes.size() > 0"),
            # Feature("fwjet1_phi", "Jet_phi.at(fwjet_indexes.at(0))", binning=phi_binning,
            #     x_title=Label("add. forward jet 1  #phi"), tags=["extra"],
            #     selection="fwjet_indexes.size() > 0"),
            # Feature("fwjet1_mass", "Jet_mass.at(fwjet_indexes.at(0))", binning=(10, 50, 150),
            #     x_title=Label("add. forward jet 1  m"),
            #     units="GeV", tags=["extra"],
            #     selection="fwjet_indexes.size() > 0",
            #     **self.jet_systs_params),

            # lepton features
            Feature("lep1_pt", "dau1_pt", binning=(20, 20, 220),
                x_title=Label("#tau_{1} p_{T}"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep1_pt_high", "dau1_pt", binning=(30, 20, 500),
                x_title=Label("#tau_{1} p_{T}"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep1_eta", "dau1_eta", binning=(20, -2.5, 2.5),
                x_title=Label("#tau_{1} #eta"), tags=["base"]),
            Feature("lep1_phi", "dau1_phi", binning=phi_binning,
                x_title=Label("#tau_{1} #phi"), tags=["base"]),
            Feature("lep1_mass", "dau1_mass", binning=(30, -0.5, 5),
                x_title=Label("#tau_{1} m"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep1_idDeepTauVSjet", "dau1_idDeepTau2017v2p1VSjet", binning=(11, 0, 10),
                x_title=Label("#tau_{1} DeepTau2017v2p1VSjet (tautau HPS)"), selection="!isBoostedTau && pairType == 2",
                tags=["base"]),
            Feature("lep1_rawIdDeepTauVSjet", "dau1_rawIdDeepTauVSjet", binning=(30, 0, 1),
                x_title=Label("#tau_{1} raw DeepTau2017v2p1VSjet (tautau HPS)"), selection="!isBoostedTau && pairType == 2",
                tags=["base"]),
            *( # features only for boostedTaus
            (Feature("lep1_rawIdDeepBoostedTauVSjet", "dau1_rawIdDeepTauVSjet", binning=(50, 0, 1),
                x_title=Label("#tau_{1} raw DeepBoostedTau VSjet (di-boostedTau)"), selection="isBoostedTau && pairType == 2",
                tags=["base"]),
            Feature("lep1_rawIdDeepBoostedTauVSjet_nearOne", "dau1_rawIdDeepTauVSjet", binning=(80, self.deepboostedtau.vsjet.LooseWisc, 1),
                x_title=Label("#tau_{1} raw DeepBoostedTau VSjet (di-boostedTau)"), selection="isBoostedTau && pairType == 2",
                tags=["base"]),
            Feature("lep1_rawAntiEle2018", "boostedTau_rawAntiEle2018[dau1_idx]", binning=(50, -1, 1),
                x_title=Label("#tau_{1} raw AntiEle2018 score (di-boostedTau)"), selection="isBoostedTau && pairType == 2",
                tags=["study"]),
            Feature("lep1_idAntiMu", "boostedTau_idAntiMu[dau1_idx]", binning=(3, 0, 3),
                x_title=Label("#tau_{1} anti-muon discriminator (1=loose, 2=tight) (di-boostedTau)"), selection="isBoostedTau && pairType == 2",
                tags=["study"])
            )
            if self.useBoostedTaus else ()
            ),
            Feature("lep2_pt", "dau2_pt", binning=(20, 20, 220),
                x_title=Label("#tau_{2} p_{T}"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep2_pt_high", "dau2_pt", binning=(30, 20, 500),
                x_title=Label("#tau_{2} p_{T}"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep2_eta", "dau2_eta", binning=(20, -2.5, 2.5),
                x_title=Label("#tau_{2} #eta"), tags=["base"]),
            Feature("lep2_phi", "dau2_phi", binning=phi_binning,
                x_title=Label("#tau_{2} #phi"), tags=["base"]),
            Feature("lep2_mass", "dau2_mass", binning=(30, -0.5, 5),
                x_title=Label("#tau_{2} m"),
                units="GeV", tags=["base"],
                **self.lepton_systs_params),
            Feature("lep2_idDeepTauVSjet", "dau2_idDeepTau2017v2p1VSjet", binning=(11, 0, 10),
                x_title=Label("#tau_{2} DeepTau2017v2p1VSjet (HPS taus)"), selection="!isBoostedTau",
                tags=["base"]),
            Feature("lep2_rawIdDeepTauVSjet", "dau2_rawIdDeepTauVSjet", binning=(50, 0, 1),
                x_title=Label("#tau_{2} raw DeepTau2017v2p1VSjet (HPS taus)"), selection="!isBoostedTau",
                tags=["base"]),
            *( # features only for boostedTaus
            (Feature("lep2_rawIdDeepBoostedTauVSjet", "dau2_rawIdDeepTauVSjet", binning=(50, 0, 1),
                x_title=Label("#tau_{2} raw DeepBoostedTau VSjet (boostedTaus)"), selection="isBoostedTau",
                tags=["base"]),
            Feature("lep2_rawIdDeepBoostedTauVSjet_nearOne", "dau2_rawIdDeepTauVSjet", binning=(80, self.deepboostedtau.vsjet.LooseWisc, 1),
                x_title=Label("#tau_{2} raw DeepBoostedTau VSjet (boostedTaus)"), selection="isBoostedTau",
                tags=["base"]),
            Feature("lep2_rawAntiEle2018", "boostedTau_rawAntiEle2018[dau2_idx]", binning=(50, -1, 1),
                x_title=Label("#tau_{2} raw AntiEle2018 score (boostedTaus)"), selection="isBoostedTau",
                tags=["study"]),
            Feature("lep2_idAntiMu", "boostedTau_idAntiMu[daue_idx]", binning=(3, 0, 3),
                x_title=Label("#tau_{2} anti-muon discriminator (1=loose, 2=tight) (boostedTaus)"), selection="isBoostedTau",
                tags=["study"])
            ) if self.useBoostedTaus else ()
            ),
            Feature("dR_tautau", "deltaR(dau1_eta, dau1_phi, dau2_eta, dau2_phi)" # from cmssw/DataFormats/Math/interface/deltaR.h, imported in cmt.base_tasks.base
                    #"sqrt((dau1_eta - dau2_eta)*(dau1_eta - dau2_eta) "
                #" + (dau1_phi - dau2_phi)*(dau1_phi - dau2_phi))"
                ,
                binning=(50, 0, 6),
                x_title=Label("#Delta R (#tau_{1}, #tau_{2})"), tags=["base"]),
            Feature("dR_tautau_low", "deltaR(dau1_eta, dau1_phi, dau2_eta, dau2_phi)", 
                binning=(50, 0, 0.5),
                x_title=Label("#Delta R (#tau_{1}, #tau_{2})"), tags=["base"]),
        ]
        # MET (not all of the features are usually computed, might need to add metShifterRDF to modulesrdf.yaml)
        for binning, suffix in (((20, 0, 200), ""), ((30, 150, 800), "_highRange")):
            features.extend([
            Feature(f"met_pt{suffix}_raw", "MET_pt", binning=binning,
                x_title=Label("MET p_{T} (no smearing, no XY)"),
                units="GeV", tags=["base", "met"],
                central="",
                ),          
            Feature(f"met_pt{suffix}_corr", "MET_tes_electron_xycorr_pt", expression_data="MET_pt", binning=binning,
                x_title=Label("MET p_{T} (TES, XY-corr)"),
                units="GeV", tags=["base", "met"],
                **self.met_systs),
            # here : could add MET smeared&noXY, and nosmear&XY
            ])
            
        features += [
            Feature("met_phi_raw", "MET_phi", binning=phi_binning,
                x_title=Label("MET #phi (no smearing, no XY)"),
                units="GeV", tags=["base"],
                central="",
                ),
            Feature("met_phi_corr", "MET_tes_electron_xycorr_phi", expression_data="MET_phi", binning=(20, -3.2, 3.2),
                x_title=Label("MET #phi (TES, XY-corr)"), tags=["base", "met"],
                **self.met_systs),

            Feature("pairType", "pairType", binning=(5, -1, 3), 
                x_title=Label("pairType"), tags=["base"]),
            Feature("pairType_HPSTaus", "pairType_HPSTaus", binning=(5, -1, 3), 
                x_title=Label("pairType HPS taus"), tags=["base"]),
            Feature("pairType_boostedTaus", "pairType_boostedTaus", binning=(5, -1, 3), 
                x_title=Label("pairType boostedTaus"), tags=["base"]),
            
            Feature("hasBoosted", "fatjet_JetIdx>=0", binning=(2, 0, 2), 
                x_title=Label("Has AK8 candidate (no PNet cut)"), tags=["base"]),
            Feature("isBoostedTau", "isBoostedTau", binning=(2, 0, 2), 
                x_title=Label("is boostedTau"), tags=["base"]),

            # The H/Z dependent features have been moved to base_config_ZZ/ZH/ZbbHtt/ZttHbb 

            # DNN features FullFeatSet: no systematics since the DNN cannot hadle them and we don't want to save theme for plotting
            Feature("zz_kinfit_chi2", "hh_kinfit_chi2", binning=(30, 0, 50),
                x_title=Label("ZZ #chi^{2} (Kin. Fit)"), tags=["dnnInput"],
                selection="!isBoosted",
                systematics=[]),
            Feature("zz_kinfit_m", "hh_kinfit_m", binning=(50, 0, 1000),
                x_title=Label("ZZ mass (Kin. Fit)"), units="GeV", tags=["dnnInput"],
                selection="!isBoosted",
                systematics=[]),
            Feature("sv_mass", "sv_mass", binning=(20, 30, 230),
                x_title=Label("Z(#tau^{+}#tau^{-}) mass (SVFit)"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("dR_l1_l2_x_sv_pT", "dR_l1_l2_x_sv_pT", binning=(30, 0, 400), 
                x_title=Label("#DeltaR (l_{1}, l_{2}) #times p_{T} (Z_{#tau#tau}^{SVFit})"), tags=["dnnInput"],
                systematics=[]),
            Feature("l1_mt", "l_1_mt", binning=(25, 0, 200), 
                x_title=Label("m_{T} (l_{1})"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("l_2_pT", "l_2_pT", binning=(25, 50, 150),
                x_title=Label("#tau_{2} p_{t}"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("dR_l1_l2", "dR_l1_l2", binning=(50, 0, 5), 
                x_title=Label("#DeltaR (l_{1}, l_{2})"), tags=["dnnInput"],
                systematics=[]),
            Feature("dphi_sv_met", "dphi_sv_met", binning=(30, 0, 3.14), 
                x_title=Label("#Delta#phi (Z_{#tau#tau}^{SVFit}, MET)"), tags=["dnnInput"],
                systematics=[]),
            Feature("z_bb_mass", "h_bb_mass", binning=(35, 0, 350),
                x_title=Label("Z(b#bar{b}) mass"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("b_2_hhbtag", "b_2_hhbtag", binning=(50, 0, 1), 
                x_title=Label("ZZbtag bJet_{2}"), tags=["dnnInput"],
                systematics=[]),
            Feature("diZ_mass_sv", "diH_mass_sv", binning=(50, 0, 1000),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit}"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("dphi_zbb_sv", "dphi_hbb_sv", binning=(30, 0, 3.14), 
                x_title=Label("#Delta#phi (Z_{bb}, Z_{#tau#tau}^{SVFit})"), tags=["dnnInput"],
                systematics=[]),
            Feature("z_bb_pT", "h_bb_pT", binning=(10, 50, 150),
                x_title=Label("Z(b#bar{b}) p_{T}"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("dR_l1_l2_boosted_ztt_met", "dR_l1_l2_boosted_htt_met", binning=(50, 0, 5), 
                x_title=Label("#DeltaR (l_{1}, l_{2}) Boost(Z_{#tau#tau}+MET)"), tags=["dnnInput"],
                systematics=[]),
            Feature("l_1_pT", "l_1_pT", binning=(25, 50, 150),
                x_title=Label("#tau_{1} p_{T}"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("b_1_pT", "b_1_pT", binning=(20, 40, 200),
                x_title=Label("b_{1} p_{T}"), units="GeV", tags=["dnnInput"],
                systematics=[]),
            Feature("phi", "phi", binning=(30, 0, 3.14), 
                x_title=Label("#Phi"), tags=["dnnInput"],
                systematics=[]),
            Feature("costheta_l2_zttmet", "costheta_l2_httmet", binning=(20, 0, 1), 
                x_title=Label("cos#Theta"), tags=["dnnInput"],
                systematics=[]),
            Feature("b_1_cvsb", "b_1_cvsb", binning=(4, 0, 4), 
                x_title=Label("CvsB (bJet_{1})"), tags=["dnnInput"],
                systematics=[]),
            Feature("b_1_cvsl", "b_1_cvsl", binning=(4, 0, 4), 
                x_title=Label("CvsL (bJet_{1})"), tags=["dnnInput"],
                systematics=[]),
            Feature("boosted", "isBoosted", binning=(2, 0, 2), 
                x_title=Label("isBoosted"), tags=["dnnInput"]),
            # Feature("is_vbf", "is_vbf", binning=(2, 0, 2), 
            #     x_title=Label("isVBF"), tags=["dnnInput"]),
            Feature("jet_1_quality", "jet_1_quality", binning=(6, 0, 6), 
                x_title=Label("Quality (bJet_{1})"), tags=["dnnInput"]),
            Feature("jet_2_quality", "jet_2_quality", binning=(6, 0, 6), 
                x_title=Label("Quality (bJet_{2})"), tags=["dnnInput"]),
            
            # dnn_ZZbbtt_kl_1 was moved in base_config_ZZ.py
            # Feature("dnn_hhbbtt_kl_1", "dnn_hhbbtt_kl_1", binning=(10, 0, 1),
            #     x_title=Label("DNN HH")),

            # VBFjet features
            # Feature("vbfjet1_pt", "Jet_pt.at(VBFjet1_JetIdx)", binning=(10, 50, 150),
            #     x_title=Label("VBFjet1 p_{t}"),
            #     units="GeV",
            #     central="jet_smearing",
            #     systematics=self.jme_systs),
            # Feature("vbfjet1_eta", "Jet_eta.at(VBFjet1_JetIdx)", binning=(20, -5., 5.),
            #     x_title=Label("VBFjet1 #eta")),
            # Feature("vbfjet1_phi", "Jet_phi.at(VBFjet1_JetIdx)", binning=(20, -3.2, 3.2),
            #     x_title=Label("VBFjet1 #phi")),
            # Feature("vbfjet1_mass", "Jet_mass.at(VBFjet1_JetIdx)", binning=(10, 50, 150),
            #     x_title=Label("VBFjet1 m"),
            #     units="GeV",
            #     central="jet_smearing",
            #     systematics=self.jme_systs),
            # Feature("vbfjet2_pt", "Jet_pt.at(VBFjet2_JetIdx)", binning=(10, 50, 150),
            #     x_title=Label("VBFjet2 p_t"),
            #     units="GeV",
            #     central="jet_smearing",
            #     systematics=self.jme_systs),
            # Feature("vbfjet2_eta", "Jet_eta.at(VBFjet2_JetIdx)", binning=(20, -5., 5.),
            #     x_title=Label("VBFjet2 #eta")),
            # Feature("vbfjet2_phi", "Jet_phi.at(VBFjet2_JetIdx)", binning=(20, -3.2, 3.2),
            #     x_title=Label("VBFjet2 #phi")),
            # Feature("vbfjet2_mass", "Jet_mass.at(VBFjet2_JetIdx)", binning=(10, 50, 150),
            #     x_title=Label("VBFjet2 m"),
            #     units="GeV",
            #     central="jet_smearing",
            #     systematics=self.jme_systs),

            # VBFjj
            # Feature("VBFjj_mass", "VBFjj_mass", binning=(40, 0, 1000),
            #     x_title=Label("VBFjj mass"),
            #     units="GeV",
            #     central="jet_smearing",
            #     systematics=self.jme_systs),
            # Feature("VBFjj_deltaEta", "VBFjj_deltaEta", binning=(40, -8, 8),
            #     x_title=Label("#Delta#eta(VBFjj)"))
            # Feature("VBFjj_deltaPhi", "VBFjj_deltaPhi", binning=(40, -6.4, 6.4),
            #     x_title=Label("#Delta#phi(VBFjj)")),

            # Weights
            Feature("genWeight", "genWeight", binning=(50, 0, 2),
                x_title=Label("genWeight"), tags=["base"], noData=True),
            Feature("genWeightFixed", "genWeightFixed", binning=(50, 0, 2),
                x_title=Label("genWeightFixed"), tags=["base"], noData=True), # genWeight eventually modified to fix Madgraph LO bug
            Feature("DYstitchWeight_log", "DYstitchWeight == 0 ? -19.9 : std::log10(DYstitchWeight)", binning=(100, -20, 0),
                x_title=Label("log10(DY stitching weight), 0 maps to -20"), tags=["base"], noData=True),
            Feature("puWeight", "puWeight", binning=(30, 0.5, 1.5),
                x_title=Label("puWeight"), noData=True,
                systematics=["pu"], tags=["base"]),
            # Feature("prescaleWeight", "prescaleWeight", binning=(20, 0, 2),
            #     x_title=Label("prescaleWeight")),
            Feature("trigSF", "trigSF", binning=(30, 0.5, 1.5),
                x_title=Label("trigSF"), tags=["base"], noData=True,
                systematics=["trigSFele", "trigSFmu", "trigSFDM0", "trigSFDM1", "trigSFDM10", "trigSFDM11", "trigSFmet"]), 
            Feature("L1PreFiringWeight", "L1PreFiringWeight", binning=(30, 0.5, 1.5),
                x_title=Label("L1PreFiringWeight"), tags=["base"], noData=True,
                central="prefiring_central",
                systematics=["prefiring"]),
            Feature("PUjetID_SF", "PUjetID_SF", binning=(30, 0.5, 1.5),
                x_title=Label("PUjetID_SF"), tags=["base"], noData=True,
                systematics=["PUjetID"]),
            Feature("idAndIsoAndFakeSF", "idAndIsoAndFakeSF", binning=(30, 0, 2),
                x_title=Label("idAndIsoAndFakeSF"), tags=["base"], noData=True,
                systematics=["deepTau_stat_highpT_bin1", "deepTau_stat_highpT_bin2", "deepTau_syst_highpT", "deepTau_syst_highpT_extrap",
                             "deepTau_stat1_dm0", "deepTau_stat2_dm0", "deepTau_stat1_dm1", "deepTau_stat2_dm1", "deepTau_stat1_dm10", "deepTau_stat2_dm10", "deepTau_stat1_dm11", "deepTau_stat2_dm11", 
                             "deepTau_syst_alleras", "deepTau_syst_era", "deepTau_syst_dm0", "deepTau_syst_dm1", "deepTau_syst_dm10", "deepTau_syst_dm11",
                              "etauFR", "mutauFR", "eleReco", "eleIso", "muIso", "muId"]),
            Feature("bTagweightReshape", "bTagweightReshape", binning=(30, 0, 2),
                x_title=Label("b-tag reshaping weight"), tags=["base"], noData=True,
                central="jer", systematics=self.jme_systs + ["CMS_btag_cferr1", "CMS_btag_cferr2", "CMS_btag_hf", "CMS_btag_hfstats1", "CMS_btag_hfstats2", "CMS_btag_lf", "CMS_btag_lfstats1", "CMS_btag_lfstats2"]),
            Feature("fatjet_pnet_SF", "fatjet_pNet_LP_SF", binning=(30, 0, 2.),
                x_title=Label("FatJet ParticleNet SF"), tags=["base"], noData=True,
                systematics=["fatjet_pnet"]),
            ############## TODO TODO self.jec_systs+

            # LHE variables (MC only)
            Feature("LHE_Vpt", "LHE_Vpt", binning=(100, 0, 1000), noData=True,
                x_title=Label("LHE PtZ"), units="GeV", tags=["lhe"]),
            Feature("LHE_HT", "LHE_HT", binning=(100, 0, 1000), noData=True,
                x_title=Label("LHE HT"), units="GeV", tags=["lhe"]),
            Feature("LHE_HT_low", "LHE_HT", binning=(100, 0, 130), noData=True,
                x_title=Label("LHE HT"), units="GeV", tags=["lhe"]),
            Feature("LHE_HT_high", "LHE_HT", binning=(100, 0, 3000), noData=True,
                x_title=Label("LHE HT"), units="GeV", tags=["lhe"]),
            Feature("LHE_Njets", "LHE_Njets", binning=(5, 0, 5), noData=True,
              x_title=Label("LHE Njets"), tags=["lhe"]),
            Feature("LHE_NpLO", "LHE_NpLO", binning=(5, 0, 5), noData=True,
              x_title=Label("LHE Nb of partons at LO"), tags=["lhe"]),
            Feature("LHE_NpNLO", "LHE_NpNLO", binning=(5, 0, 5), noData=True,
              x_title=Label("LHE Nb of partons at NLO"), tags=["lhe"]),
            
            # Gen variables (MC only & only when enabled, usually signal only)
            Feature("genXbb_pgdId", "genXbb_pgdId", binning=(30, 0, 30), noData=True,
                x_title=Label("PDG ID of X->bb at gen level"), tags=["signal"]),
            Feature("genXbb_pt", "genXbb_pt", binning=(20, 20, 220),
                x_title=Label("gen X(to bb) p_{T}"), selection="genXbb_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("genXbb_pt_high", "genXbb_pt", binning=(30, 20, 500),
                x_title=Label("gen X(to bb) p_{T}"), selection="genXbb_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("genXbb_eta", "genXbb_eta", binning=(20, -3., 3.),
                x_title=Label("gen X(to bb) #eta"), selection="genXbb_GenPartIdx>=0", tags=["signal"]),
            Feature("genXbb_phi", "genXbb_phi", binning=phi_binning,
                x_title=Label("gen X(to bb) #phi"), selection="genXbb_GenPartIdx>=0", tags=["signal"]),
            Feature("genXbb_mass", "genXbb_mass", binning=(40, 0, 150),
                x_title=Label("X(bb) mass"),
                units="GeV", tags=["signal"]),
            
            # Feature("genXtautau_pgdId", "genXtautau_pgdId", binning=(30, 0, 30), noData=True,
            #     x_title=Label("PDG ID of X->tautau at gen level"), tags=["signal"]),
            Feature("genXtautau_pt", "genXtautau_pt", binning=(20, 20, 220),
                x_title=Label("gen X(to bb) p_{T}"), selection="genXtautau_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("genXtautau_pt_high", "genXtautau_pt", binning=(30, 20, 500),
                x_title=Label("gen X(to bb) p_{T}"), selection="genXtautau_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("genXtautau_eta", "genXtautau_eta", binning=(20, -3., 3.),
                x_title=Label("gen X(to bb) #eta"), selection="genXtautau_GenPartIdx>=0", tags=["signal"]),
            Feature("genXtautau_phi", "genXtautau_phi", binning=phi_binning,
                x_title=Label("gen X(to bb) #phi"), selection="genXtautau_GenPartIdx>=0", tags=["signal"]),
            Feature("genXtautau_mass", "genXtautau_mass", binning=(40, 0, 150),
                x_title=Label("X(#tau^{+}#tau^{-}) mass"),
                units="GeV", tags=["signal"]),
            
            Feature("gen_b1_pt", "gen_b1_pt", binning=(20, 20, 220),
                x_title=Label("gen b_{1} p_{T}"), selection="gen_b1_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("gen_b1_pt_high", "gen_b1_pt", binning=(30, 20, 500),
                x_title=Label("gen b_{1} p_{T}"), selection="gen_b1_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("gen_b1_eta", "gen_b1_eta", binning=(20, -3., 3.),
                x_title=Label("gen b_{1} #eta"), selection="gen_b1_GenPartIdx>=0", tags=["signal"]),
            Feature("gen_b1_phi", "gen_b1_phi", binning=phi_binning,
                x_title=Label("gen b_{1} #phi"), selection="gen_b1_GenPartIdx>=0", tags=["signal"]),
            Feature("gen_b2_pt", "gen_b2_pt", binning=(20, 20, 220),
                x_title=Label("gen b_{2} p_{T}"), selection="gen_b2_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("gen_b2_pt_high", "gen_b2_pt", binning=(30, 20, 500),
                x_title=Label("gen b_{2} p_{T}"), selection="gen_b2_GenPartIdx>=0",
                units="GeV", tags=["signal"]),
            Feature("gen_b2_eta", "gen_b2_eta", binning=(20, -3., 3.),
                x_title=Label("gen b_{2} #eta"), selection="gen_b2_GenPartIdx>=0", tags=["signal"]),
            Feature("gen_b2_phi", "gen_b2_phi", binning=phi_binning,
                x_title=Label("gen b_{2} #phi"), selection="gen_b2_GenPartIdx>=0", tags=["signal"]),

            Feature("gen_dR_tautau", "gen_deltaR_tautau",
                binning=(50, 0, 6),
                x_title=Label("Gen #Delta R (#tau_{1}, #tau_{2}) (incl. #mu)"), tags=["signal"]),
            Feature("gen_dR_tautau_low", "gen_deltaR_tautau", 
                binning=(50, 0, 0.5),
                x_title=Label("Gen #Delta R (#tau_{1}, #tau_{2}) (incl. #mu)"), tags=["signal"]),
            Feature("gen_dR_daudau", "gen_deltaR_daudau",
                binning=(50, 0, 6),
                x_title=Label("Gen #Delta R (#tau_{1}, #tau_{2}) (visible energy)"), tags=["signal"]),
            Feature("gen_dR_daudau_low", "gen_deltaR_daudau", 
                binning=(50, 0, 0.5),
                x_title=Label("Gen #Delta R (#tau_{1}, #tau_{2}) (visible energy)"), tags=["signal"]),
            Feature("gen_dR_bb", "gen_deltaR_bb",
                binning=(50, 0, 6),
                x_title=Label("Gen #Delta R (b_{1}, b_{2})"), tags=["signal"]),
            Feature("gen_dR_bb_low", "gen_deltaR_bb", 
                binning=(50, 0, 0.5),
                x_title=Label("Gen #Delta R (b_{1}, b_{2})"), tags=["signal"]),
            
            Feature("gen_deltaR_XX", "gen_deltaR_XX",
                binning=(50, 0, 6),
                x_title=Label("Gen #Delta R (Xbb,X#tau#tau)"), tags=["signal"]),
        ]
        return ObjectCollection(features)
    
    def add_weights(self):
        weights = DotDict()
        weights.default = "1"

        # These weights are used for PreCounter
        weights.total_events_weights = ["genWeightFixed", "puWeight"] # DYstitchWeight

        weights.base_noWeights = ["genWeight", "DYstitchWeight"]

        weights.all = ["genWeightFixed", "puWeight", "trigSF",
            "idAndIsoAndFakeSF", "L1PreFiringWeight", "PUjetID_SF",
            "bTagweightReshape", "fatjet_pnet_SF",
            "DYstitchWeight", "hem_weight"
            ]
        for category in self.categories:
            weights[category.name] = weights.all
        
        return weights

    def add_systematics(self):
        # See https://gitlab.cern.ch/cms-analysis/general/systematics for naming conventions

        cats_lepton_systs = [] # categories that have event migration due to tau energy scale or electron scale/smearing
        cats_jet_systs = [] # same but JEC/JES
        for category in self.categories:
            # Because of pairType filter in hhlepton we actually need to add lepton systs for all categories
            cats_lepton_systs.append(category.name)
            # for preprocess we need to run svfit with variations (to be able to use it easily in Categorization, otherwise it's not strictly necessary)
            cats_jet_systs.append(category.name)


            #if category.name in ["baseline", "baseline_sr", "etau", "mutau", "tautau"]:
            #    cats_lepton_systs.append(category.name)
            #if "elliptical_cut" in category.name or "orthogonal_cut" in category.name:
                #cats_lepton_systs.append(category.name)
                #cats_jet_systs.append(category.name)

        systematics = [
            # Tau energy scale
            # should decorrelate between real taus and electrons faking tau
            Systematic("tes", "_corr", label=f"CMS_scale_t_{self.year}", module_syst_type=["tau_syst", "met_syst"], affected_categories=cats_lepton_systs),

            # JER (jet energy resolution, smearing of jet energy applied on MC only). NOT PROPAGATED TO MET (not recommended by default by JME, but could be tried)
            Systematic("jer", "_smeared", label="JES", llr_name="CMS_res_j_2018", decorrelate="year", module_syst_type=["jet_syst"], affected_categories=cats_jet_systs), # systematic variation of smearing
            ## JEC (jet energy corrections). Propagated to MET as . Includes JER nominal
            # Split 11-ways
            Systematic("jec_1", "_smeared_FlavorQCD", label="FlavorQCD", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_2", "_smeared_RelativeBal", label="RelativeBal", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_3", "_smeared_HF", label="HF", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_4", "_smeared_BBEC1", label="BBEC1", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_5", "_smeared_EC2", label="EC2", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_6", "_smeared_Absolute", label="Absolute", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_7", f"_smeared_BBEC1_{self.year}", label=f"BBEC1_{self.year}", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_8", f"_smeared_EC2_{self.year}", label=f"EC2_{self.year}", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_9", f"_smeared_Absolute_{self.year}", label=f"Absolute_{self.year}", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_10", f"_smeared_HF_{self.year}", label=f"HF_{self.year}", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            Systematic("jec_11", f"_smeared_RelativeSample_{self.year}", label=f"RelativeSample_{self.year}", module_syst_type=["jet_syst", "met_syst"], affected_categories=cats_jet_systs), 
            # unsplit (to be used instead of the 11-ways)
            Systematic("jec", "_Total", module_syst_type=["jet_syst", "met_syst"], decorrelate="year", affected_categories=cats_jet_systs), 

            # MET central values
            Systematic("met_smearing", ("MET", "MET_smeared")),
            Systematic("met_smearing_xycorr", ("MET", "MET_smeared_xycorr")),
            Systematic("met_tes_electron_xycorr", ("MET", "MET_tes_electron_xycorr")),
            # MET uncertainties
            Systematic("met_unclustered", "_unclustered", label="Unclustered energy", module_syst_type=["met_syst"], affected_categories=cats_jet_systs),

            # used only to plot MET corrected variables with systematics. NOT TO BE RUN AS AN ACTUAL SYSTEMATIC IN PREPROCESS
            # I think it is intended for plotting MET with a smear tag, so that it replaces "MET" with "MET_smeared...." only for MC
            # actually does not work as PrePlot does not use the systematic input, but the central one, because the syst name is not the same...
            # Systematic("jer_MET", ("MET", "MET_smeared"), up="_up", down='_down'), # no MET smearing
            # Systematic("tes_MET", ("MET", "MET_tes_xycorr"), up="_corr_up", down='_corr_down'),
            # Systematic("jec_MET_1", ("MET", "MET_tes_xycorr"), up="_FlavorQCD_up", down='_FlavorQCD_down'),
            # Systematic("jec_MET_2", ("MET", "MET_tes_xycorr"), up="_RelativeBal_up", down='_RelativeBal_down'),
            # Systematic("jec_MET_3", ("MET", "MET_tes_xycorr"), up="_HF_up", down='_HF_down'),
            # Systematic("jec_MET_4", ("MET", "MET_tes_xycorr"), up="_BBEC1_up", down='_BBEC1_down'),
            # Systematic("jec_MET_5", ("MET", "MET_tes_xycorr"), up="_EC2_up", down='_EC2_down'),
            # Systematic("jec_MET_6", ("MET", "MET_tes_xycorr"), up="_Absolute_up", down='_Absolute_down'),
            # Systematic("jec_MET_7", ("MET", "MET_tes_xycorr"), up=f"_BBEC1_{self.year}_up", down=f'_BBEC1_{self.year}_down'),
            # Systematic("jec_MET_8", ("MET", "MET_tes_xycorr"), up=f"_EC2_{self.year}_up", down=f'_EC2_{self.year}_down'),
            # Systematic("jec_MET_9", ("MET", "MET_tes_xycorr"), up=f"_Absolute_{self.year}_up", down=f'_Absolute_{self.year}_down'),
            # Systematic("jec_MET_10", ("MET", "MET_tes_xycorr"), up=f"_HF_{self.year}_up", down=f'_HF_{self.year}_down'),
            # Systematic("jec_MET_11", ("MET", "MET_tes_xycorr"), up=f"_RelativeSample_{self.year}_up", down=f'_RelativeSample_{self.year}_down'),
            # Systematic("jec_MET", ("MET", "MET_tes_xycorr"), up="_Total_up", down='_Total_down'),
            # Systematic("met_unclustered_MET", ("MET", "MET_tes_xycorr"), up="_unclustered_up", down="_unclustered_down", label="Unclustered energy"),

            # Electrons (see https://twiki.cern.ch/twiki/bin/view/CMS/EgammaRunIIRecommendations#Recommendations_on_Combining_Sys for correlation instructions)
            # note : no leading underscore in up/down, due to framework bug (basically if central="" then no underscore in up/down)
            Systematic("ele_scale", "_scale", module_syst_type=["electron_syst", "met_syst"], affected_categories=cats_lepton_systs, decorrelate="year"),
            Systematic("ele_resolution", "_smear", module_syst_type=["electron_syst", "met_syst"], affected_categories=cats_lepton_systs),

            Systematic("prefiring_central", "_Nom"),
            Systematic("prefiring", "", up="_Up", down="_Dn", decorrelate="year"),

            # event weights systematics, from idAndIsoAndFakeSF
            # DeepTauVSJet pt binned
            Systematic("deepTau_stat_highpT_bin1", "_tau_vsjet_pt_stat_highpT_bin1", label=f"CMS_eff_t_high_pt_bin1_{self.year}"),
            Systematic("deepTau_stat_highpT_bin2", "_tau_vsjet_pt_stat_highpT_bin1", label=f"CMS_eff_t_high_pt_bin2_{self.year}"),
            Systematic("deepTau_syst_highpT", "_tau_vsjet_pt_syst_highpT", label=f"CMS_eff_t_high_pt"),
            Systematic("deepTau_syst_highpT_extrap", "_tau_vsjet_pt_syst_highpT_extrap", label=f"CMS_eff_t_high_pt_extrap"),
            # DeepTauVSJet dm-binned
            Systematic("deepTau_stat1_dm0", "_tau_vsjet_dm_stat1_dm0", label=f"CMS_eff_t_stat1_DM0_{self.year}"),
            Systematic("deepTau_stat2_dm0", "_tau_vsjet_dm_stat2_dm0", label=f"CMS_eff_t_stat2_DM0_{self.year}"),
            Systematic("deepTau_stat1_dm1", "_tau_vsjet_dm_stat1_dm1", label=f"CMS_eff_t_stat1_DM1_{self.year}"),
            Systematic("deepTau_stat2_dm1", "_tau_vsjet_dm_stat2_dm1", label=f"CMS_eff_t_stat2_DM1_{self.year}"),
            Systematic("deepTau_stat1_dm10", "_tau_vsjet_dm_stat1_dm10", label=f"CMS_eff_t_stat1_DM10_{self.year}"),
            Systematic("deepTau_stat2_dm10", "_tau_vsjet_dm_stat2_dm10", label=f"CMS_eff_t_stat2_DM10_{self.year}"),
            Systematic("deepTau_stat1_dm11", "_tau_vsjet_dm_stat1_dm11", label=f"CMS_eff_t_stat1_DM11_{self.year}"),
            Systematic("deepTau_stat2_dm11", "_tau_vsjet_dm_stat2_dm11", label=f"CMS_eff_t_stat2_DM11_{self.year}"),
            Systematic("deepTau_syst_alleras", "_tau_vsjet_dm_syst_alleras", label=f"CMS_eff_t_syst"),
            Systematic(f"deepTau_syst_era", f"_tau_vsjet_dm_syst_{self.year}{('_'+ self.runPeriod if self.runPeriod else '')}", label=f"CMS_eff_t_{self.year}{self.runPeriod}"),
            Systematic("deepTau_syst_dm0", f"_tau_vsjet_dm_syst_{self.year}{('_'+ self.runPeriod if self.runPeriod else '')}_dm0", label=f"CMS_eff_t_syst_DM0_{self.year}"),
            Systematic("deepTau_syst_dm1", f"_tau_vsjet_dm_syst_{self.year}{('_'+ self.runPeriod if self.runPeriod else '')}_dm1", label=f"CMS_eff_t_syst_DM1_{self.year}"),
            Systematic("deepTau_syst_dm10", f"_tau_vsjet_dm_syst_{self.year}{('_'+ self.runPeriod if self.runPeriod else '')}_dm10", label=f"CMS_eff_t_syst_DM10_{self.year}"),
            Systematic("deepTau_syst_dm11", f"_tau_vsjet_dm_syst_{self.year}{('_'+ self.runPeriod if self.runPeriod else '')}_dm11", label=f"CMS_eff_t_syst_DM11_{self.year}"),

            #Systematic("jetTauFakes", "", up="_tau_vsjet_up", down="_tau_vsjet_down", decorrelate="year"),
            Systematic("etauFR", "_tau_vse", label=f"CMS_scale_t_eFake_{self.year}", decorrelate="year"), # should be split by eta bin
            Systematic("mutauFR", "_tau_vsmu", label=f"CMS_scale_t_muFake_{self.year}", decorrelate="year"), # should be split by eta region

            Systematic("eleReco", "", up="_ele_reco_up", down="_ele_reco_down"), # eleReco & eleIso correlated : https://twiki.cern.ch/twiki/bin/view/CMS/EgammaRunIIRecommendations
            Systematic("eleIso", "", up="_ele_iso_up", down="_ele_iso_down"), # actually electron MVA ID SFs, correlated https://twiki.cern.ch/twiki/bin/view/CMS/EgammaRunIIRecommendations#Recommendations_on_Combining_Sys
            # https://twiki.cern.ch/twiki/bin/view/CMS/MuonUL2018
            Systematic("muIso", "", up="_muon_iso_up", down="_muon_iso_down"),
            Systematic("muId", "", up="_muon_id_up", down="_muon_id_down"),

            Systematic("trigSFele", "", up="_eleUp", down="_eleDown", decorrelate="year"),
            Systematic("trigSFmu", "", up="_muUp", down="_muDown", decorrelate="year"),
            Systematic("trigSFDM0", "", up="_DM0Up", down="_DM0Down", decorrelate="year"),
            Systematic("trigSFDM1", "", up="_DM1Up", down="_DM1Down", decorrelate="year"),
            Systematic("trigSFDM10", "", up="_DM10Up", down="_DM10Down", decorrelate="year"),
            Systematic("trigSFDM11", "", up="_DM11Up", down="_DM11Down", decorrelate="year"),
            Systematic("trigSFmet", "", up="_met_statup", down="_met_statdown", decorrelate="year"),

            Systematic("PUjetID", "", up="_up", down="_down", decorrelate="year"),
            Systematic("pu", "", up="Up", down="Down", decorrelate="year"),
            Systematic("empty", "", up="", down=""),

            # btag shape uncertainties (there is also the JEC variations to use as well)
            Systematic("CMS_btag_cferr1", "_smeared_cferr1"),
            Systematic("CMS_btag_cferr2", "_smeared_cferr2"),
            Systematic("CMS_btag_hf", "_smeared_hf"),
            Systematic("CMS_btag_hfstats1", "_smeared_hfstats1", decorrelate="year"),
            Systematic("CMS_btag_hfstats2", "_smeared_hfstats2", decorrelate="year"),
            Systematic("CMS_btag_lf", "_smeared_lf"),
            Systematic("CMS_btag_lfstats1", "_smeared_lfstats1", decorrelate="year"),
            Systematic("CMS_btag_lfstats2", "_smeared_lfstats2", decorrelate="year"),

            Systematic("fatjet_pnet", "", decorrelate="year"), # FatJet ParticleNet XbbVsQCD scale factors 

            # Systematic("jes"), # 
        ]
        return ObjectCollection(systematics)

    # other methods

    def get_channel_from_region(self, region):
        for sign in ["os", "ss"]:
            if region is not None and sign in region.name:
                if region.name.startswith(sign):
                    return ""
                return region.name[:region.name.index("_%s" % sign)]
        return ""

    def get_qcd_regions(self, region, category, wp="", shape_region="os_inviso",
            signal_region_wp="os_iso", sym=True):
        # the region must be set and tagged os_iso
        if not region:
            raise Exception("region must not be empty")
        # if not region.has_tag("qcd_os_iso"):
        #     raise Exception("region must be tagged as 'qcd_os_iso' but isn't")

        # the category must be compatible with the estimation technique
        # if category.has_tag("qcd_incompatible"):
        #     raise Exception("category '{}' incompatible with QCD estimation".format(category.name))

        if wp != "":
            wp = "__" + wp

        # get other qcd regions
        prefix = region.name[:-len(signal_region_wp)]
        qcd_regions = {"ss_inviso": self.regions.get(prefix + "ss_inviso" + wp)}
        # for the inverted regions, allow different working points
        default_config = ["os_inviso", "ss_iso"]
        for key in default_config:
            region_name = (prefix + key + wp if key != "ss_iso"
                else prefix + "ss_" + signal_region_wp[len("os_"):])
            qcd_regions[key] = self.regions.get(region_name)

        if sym:
            qcd_regions["shape1"] = self.regions.get(prefix + shape_region + wp)
            qcd_regions["shape2"] = self.regions.get(
                prefix + "ss_" + signal_region_wp[len("os_"):])
        else:
            if shape_region == "os_inviso":
                qcd_regions["shape"] = self.regions.get(prefix + shape_region + wp)
            else:
                qcd_regions["shape"] = self.regions.get(
                    prefix + "ss_" + signal_region_wp[len("os_"):])
        return DotDict(qcd_regions)

    def get_norm_systematics(self, processes_datasets, region):
        """
        Method to extract all normalization systematics from the KLUB files.
        It considers the processes given by the process_group_name and their parents.
        Returns dict : systematic_name -> process name -> string that is either a single number or of style "0.9/1.1" (combine datacard syntax)
        """
        # systematics
        systematics = {}
        all_signal_names = []
        all_background_names = []
        for p in self.processes:
            if p.isSignal:
                all_signal_names.append(p.get_aux("llr_name")
                    if p.get_aux("llr_name", None) else p.name)
            elif not p.isData:
                all_background_names.append(p.get_aux("llr_name")
                    if p.get_aux("llr_name", None) else p.name)

        from cmt.analysis.systReader import systReader
        syst_folder = "files/systematics_ZZ_ZH/"
        print(syst_folder + "systematics_{}.cfg".format(self.year))
        syst = systReader(Task.retrieve_file(self, syst_folder + "systematics_{}.cfg".format(
            self.year)), all_signal_names, all_background_names, None)
        syst.writeOutput(False)
        syst.verbose(False)

        channel = self.get_channel_from_region(region)
        if(channel == "mutau"):
            syst.addSystFile(Task.retrieve_file(self, syst_folder
                + "systematics_mutau_%s.cfg" % self.year))
        elif(channel == "etau"):
            syst.addSystFile(Task.retrieve_file(self, syst_folder
                + "systematics_etau_%s.cfg" % self.year))
        syst.addSystFile(Task.retrieve_file(self, syst_folder + "syst_th.cfg"))
        syst.writeSystematics()
        for isy, syst_name in enumerate(syst.SystNames):
            if "CMS_scale_t" in syst.SystNames[isy] or "CMS_scale_j" in syst.SystNames[isy]:
                continue
            for process in processes_datasets:
                original_process = process
                while True:
                    process_name = (process.get_aux("llr_name")
                        if process.get_aux("llr_name", None) else process.name)
                    if process_name in syst.SystProcesses[isy]:
                        iproc = syst.SystProcesses[isy].index(process_name)
                        systVal = syst.SystValues[isy][iproc]
                        if syst_name not in systematics:
                            systematics[syst_name] = {}
                        systematics[syst_name][original_process.name] = systVal #eval(systVal)
                        break
                    elif process.parent_process:
                        process=self.processes.get(process.parent_process)
                    else:
                        break
        return systematics