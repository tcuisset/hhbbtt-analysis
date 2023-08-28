from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict

from cmt.config.base_config import Config as cmt_config


class Config(cmt_config):
    def __init__(self, *args, **kwargs):
        # https://twiki.cern.ch/twiki/bin/viewauth/CMS/BtagRecommendation102X
        self.btag=DotDict(tight=0.7264, medium=0.2770, loose=0.0494)
        self.deeptau=DotDict(
            vsjet=DotDict(VVVLoose=1, VVLoose=3, VLoose=7, Loose=15, Medium=31,
                Tight=63, VTight=127, VVTight=255),
            vse=DotDict(VVVLoose=1, VVLoose=3, VLoose=7, Loose=15, Medium=31,
                Tight=63, VTight=127, VVTight=255),
            vsmu=DotDict(VLoose=1, Loose=3, Medium=7, Tight=15),
        )

        self.channels = self.add_channels()
        self.regions = self.add_regions()
        self.categories = self.add_categories()
        super(Config, self).__init__(*args, **kwargs)

    def join_selection_channels(self, selection):
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
        selection["os_iso"] = {
            "mutau": ["isOS == 1",
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 1",
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 1",
                "dau1_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
        }
        selection["os_inviso"] = {
            "mutau": ["isOS == 1", "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 1", "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 1",
                "dau1_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
        }
        selection["ss_iso"] = {
            "mutau": ["isOS == 0",
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 0",
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 0",
                "dau1_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium],
        }
        selection["ss_inviso"] = {
            "mutau": ["isOS == 0", "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 0", "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 0",
                "dau1_idDeepTau2017v2p1VSjet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_idDeepTau2017v2p1VSjet >= 1",
                "dau2_idDeepTau2017v2p1VSjet < %s" % self.deeptau.vsjet.Medium],
        }
        regions = []
        for ikey, key in enumerate(selection):
            regions.append(Category(key, label=Label(region_names[ikey]),
                selection=self.join_selection_channels(selection[key])))
            for channel in self.channels:
                regions.append(Category("_".join([channel.name, key]),
                    label=Label(", ".join([channel.label.root, region_names[ikey]])),
                    selection=jrs(channel.selection,
                        jrs(selection[key][channel.name], op="and"), op="and")))
        return ObjectCollection(regions)

    def add_channels(self):
        channels = [
            Category("mutau", Label("#tau_{#mu}#tau_{h}"), selection="pairType == 0"),
            Category("etau", Label("#tau_{e}#tau_{h}"), selection="pairType == 1"),
            Category("tautau", Label("#tau_{h}#tau_{h}"), selection="pairType == 2"),
        ]
        return ObjectCollection(channels)

    def add_categories(self, **kwargs):
        reject_sel = ["pairType == -31415"]

        sel = DotDict()
        btag = kwargs.pop("btag", "Jet_btagDeepFlavB.at(bjet{}_JetIdx)")
        df = lambda i, op, wp: "{} {} {}".format(btag.format(i), op, self.btag[wp])
        sel["btag"] = DotDict(
            m_first=[df(1, ">", "medium")],
            m_second=[df(2, ">", "medium")],
            m_any=[jrs(df(1, ">", "medium"), df(2, ">", "medium"), op="or")],
            l=[df(1, ">", "loose"), df(2, "<", "loose")],
            ll=[df(1, ">", "loose"), df(2, ">", "loose")],
            m=[jrs(jrs(df(1, ">", "medium"), df(2, "<", "medium"), op="and"),
                jrs(df(1, "<", "medium"), df(2, ">", "medium"), op="and"), op="or")],
            mm=[df(1, ">", "medium"), df(2, ">", "medium")],
            not_mm=[df(1, "<", "medium"), df(2, "<", "medium")],
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

        categories = [
            Category("base", "base category", selection="event >= 0"),
            Category("baseline", "Baseline", selection="pairType >= 0 && pairType <= 2"),
            Category("base_selection", "base category",
                nt_selection="(Sum$(Tau_pt->fElements > 17) > 0"
                    " && ((Sum$(Muon_pt->fElements > 17) > 0"
                    " || Sum$(Electron_pt->fElements > 17) > 0)"
                    " || Sum$(Tau_pt->fElements > 17) > 1)"
                    " && Sum$(Jet_pt->fElements > 17) > 1)",
                selection="Tau_pt[Tau_pt > 17].size() > 0 "
                    "&& ((Muon_pt[Muon_pt > 17].size() > 0"
                    "|| Electron_pt[Electron_pt > 17].size() > 0)"
                    "|| Tau_pt[Tau_pt > 17].size() > 1)"
                    "&& Jet_pt[Jet_pt > 17].size() > 0"),
            Category("ZZ_elliptical_cut_80", "ZZ mass cut E=80%",
                selection="(({{Ztt_svfit_mass}} - 105.) * ({{Ztt_svfit_mass}} - 105.) / (51. * 51.)"
                " + ({{Zbb_mass}} - 118.) * ({{Zbb_mass}} - 118.) / (113. * 113.)) < 1"),
            Category("ZZ_elliptical_cut_90", "Elliptical cut E=90%",
                selection="(({{Ztt_svfit_mass}} - 121.) * ({{Ztt_svfit_mass}} - 121.) / (82. * 82.)"
                " + ({{Zbb_mass}} - 177.) * ({{Zbb_mass}} - 177.) / (173. * 173.)) < 1"),
            Category("baseline_sr", "baseline Signal region",
                selection="((pairType == 0) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 1) && (isOS == 1) && (dau2_idDeepTau2017v2p1VSjet >= {0})) || "
                    "((pairType == 2) && (isOS == 1) && "
                    "(dau2_idDeepTau2017v2p1VSjet >= {0}) && (dau2_idDeepTau2017v2p1VSjet >= {0})) "
                    .format(self.deeptau.vsjet.Medium)),
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
            # Category("dum", "dummy category", selection="event == 220524669"),
            Category("dum", "dummy category", selection="event == 74472670"),
            Category("debug", "debug category", selection="(event >= 31122668) && (event <= 31185105)"),
            Category("mutau", "#mu#tau channel", selection="pairType == 0"),
            Category("etau", "e#tau channel", selection="pairType == 1"),
            # Category("etau", "e#tau channel", selection="pairType >= -999"),
            # Category("etau", "e#tau channel", selection="1."),
            Category("tautau", "#tau#tau channel", selection="pairType == 2"),
            Category("resolved_1b", label="Resolved 1b category",
                selection=sel["resolved_1b_combined"]),
            Category("resolved_2b", label="Resolved 2b category",
                selection=sel["resolved_2b_combined"]),
            Category("boosted", label="Boosted category",
                selection=sel["boosted_combined"]),
            Category("vbf_loose", label="VBF (loose) category",
                selection=sel["vbf_loose_combined"]),
            Category("vbf_tight", label="VBF (tight) category",
                selection=sel["vbf_tight_combined"]),
            Category("vbf", label="VBF category",
                selection=sel["vbf_combined"]),
        ]
        return ObjectCollection(categories)

    def add_processes(self):
        processes = [
            Process("zz_sl_signal", Label("ZZ_{bb#tau#tau}"), color=(153, 247, 171), 
                    isZZsignal=True, isSignal=True, llr_name="ZZ"),

            # W
            Process("wjets", Label("Wjets"), color=(244, 44, 4), parent_process="zz_background", llr_name="WJets"),
            # DY
            Process("dy", Label("DY"), color=(255, 149, 5), parent_process="zz_background", llr_name="DY", isDY=True),
            Process("dy_high", Label("DY"), color=(255, 149, 5), llr_name="DY", isDY=True),
            # EWK
            Process("ewk_z",      Label("EWK Z"),     color=(255, 230, 0), parent_process="ewk"),
            Process("ewk_wplus",  Label("EWK W^{+}"), color=(255, 230, 0), parent_process="ewk"),
            Process("ewk_wminus", Label("EWK W^{-}"), color=(255, 230, 0), parent_process="ewk"),
            Process("ewk", Label("EWK"), color=(255, 230, 0), parent_process="zz_background", llr_name="EWK"),

            # TT
            Process("tt_dl", Label("t#bar{t} DL"), color=(40, 194, 255), parent_process="tt"),
            Process("tt_sl", Label("t#bar{t} SL"), color=(40, 194, 255), parent_process="tt"),
            Process("tt_fh", Label("t#bar{t} FH"), color=(40, 194, 255), parent_process="tt"),
            Process("tt", Label("t#bar{t}"), color=(40, 194, 255), parent_process="zz_background", llr_name="TT"),
            # TW
            Process("tw", Label("t+W"), color=(255, 230, 0), parent_process="zz_background", llr_name="TW"),
            # singleT
            Process("singlet", Label("st"), color=(255, 230, 0), parent_process="zz_background", llr_name="singleT"),

            # VV
            Process("zz", Label("ZZ"), color=(20, 60, 255), parent_process="vv"),
            Process("wz", Label("WZ"), color=(20, 60, 255), parent_process="vv"),
            Process("ww", Label("WW"), color=(20, 60, 255), parent_process="vv"),
            Process("vv", Label("VV"), color=(20, 60, 255), parent_process="zz_background", llr_name="VV"),
            # VVV
            Process("zzz", Label("ZZZ"), color=(20, 60, 255), parent_process="vvv"),
            Process("wzz", Label("WZZ"), color=(20, 60, 255), parent_process="vvv"),
            Process("www", Label("WWW"), color=(20, 60, 255), parent_process="vvv"),
            Process("wwz", Label("WWZ"), color=(20, 60, 255), parent_process="vvv"),
            Process("vvv", Label("VVV"), color=(20, 60, 255), parent_process="zz_background", llr_name="VVV"),

            # TTX
            Process("ttw", Label("TTW"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttz", Label("TTZ"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttww", Label("TTWW"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttwz", Label("TTWZ"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttwh", Label("TTWH"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttzh", Label("TTZH"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttzz", Label("TTZZ"), color=(4, 240, 106), parent_process="ttx"),
            Process("ttx", Label("TTX"), color=(4, 240, 106), parent_process="zz_background", llr_name="TTX"),

            # ZH_hbb
            Process("zh_hbb", Label("zh_hbb"), color=(4, 240, 106), parent_process="higgs", llr_name="ZH_hbb"),
            # ttH_hbb
            Process("tth_bb", Label("t#bar{t}H bb"), color=(4, 240, 136), parent_process="higgs", llr_name="ttH_hbb"),

            Process("tth", Label("t#bar{t}H"), color=(4, 240, 106), 
                parent_process="zz_background", llr_name="ttH"),
            Process("tth_tautau", Label("t#bar{t}H #tau#tau"), color=(4, 240, 166), 
                parent_process="tth"),
            Process("tth_nonbb", Label("t#bar{t}H "), color=(4, 240, 196), 
                parent_process="tth"),

            Process("others", Label("Others"), color=(255, 230, 0),
                parent_process="zz_background"),

            Process("zz_background", Label("Background"), color=(0, 0, 255)),

            # Data
            Process("data", Label("Data"), color=(0, 0, 0), isData=True),
            Process("data_tau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),
            Process("data_etau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),
            Process("data_mutau", Label("Data"), color=(0, 0, 0), parent_process="data", isData=True),






            Process("ggf", Label("HH_{ggF}"), color=(130, 39, 197), isSignal=False, llr_name="ggH",
                parent_process="zz_background"),
            Process("ggf_sm", Label("HH_{ggF}"), color=(130, 39, 197), isSignal=False,
                parent_process="ggf", llr_name="ggHH_kl_1_kt_1_hbbhtt"),
            Process("ggf_0_1", Label("HH_{ggF}^{(0, 1)}"), color=(0, 0, 0), isSignal=False,
                parent_process="ggf"),
            Process("ggf_2p45_1", Label("HH_{ggF}^{(2.45, 1)}"), color=(0, 0, 0), isSignal=False,
                parent_process="ggf"),
            Process("ggf_5_1", Label("HH_{ggF}^{(5, 1)}"), color=(0, 0, 0), isSignal=False,
                parent_process="ggf"),

            Process("vbf", Label("HH_{VBF}"), color=(0, 0, 0), isSignal=False, llr_name="qqH"),
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

        ]

        process_group_names = {
            "zz_total_split": [
                "zz_sl_signal",
                "ggf_sm",
                "zz_sl",
                "zz_dl",
                "zz_fh",
                "zzz",
                "wjets",
                "dy",
                "tt_dl",
                "tt_sl",
                "tt_fh",
                "tth_bb",
                "tth_tautau",
                "tth_nonbb",
                "singlet",
                "tw",
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
            "zz_background": [
                "zz_background",
            ],
            "zz_signal": [
                "zz_sl_signal",
            ],
            "zz_sig_vs_bkg": [
                "zz_background",
                "zz_sl_signal"
            ],
            "default": [
                "ggf_sm",
                "data_tau",
                "tt_dl",
            ],
            "test": [
                "ggf_sm",
                "dy",
                "tt_dl",
                "tt_sl",
            ],
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

    def add_features(self):
        features = [
            Feature("jet_pt", "Jet_pt", binning=(10, 50, 150),
                x_title=Label("jet p_{t}"),
                units="GeV"),

            # bjet features
            Feature("bjet1_pt", "Jet_pt.at(bjet1_JetIdx)", binning=(10, 50, 150),
                x_title=Label("b_{1} p_{t}"),
                units="GeV",
                central="jet_smearing",
                selection="abs({{bjet1_eta}}) < 2.1"),
            Feature("bjet1_eta", "Jet_eta.at(bjet1_JetIdx)", binning=(20, -5., 5.),
                x_title=Label("b_{1} #eta")),
            Feature("bjet1_phi", "Jet_phi.at(bjet1_JetIdx)", binning=(20, -3.2, 3.2),
                x_title=Label("b_{1} #phi")),
            Feature("bjet1_mass", "Jet_mass.at(bjet1_JetIdx)", binning=(10, 50, 150),
                x_title=Label("b_{1} m"),
                units="GeV",
                central="jet_smearing"),
            Feature("bjet2_pt", "Jet_pt.at(bjet2_JetIdx)", binning=(10, 50, 150),
                x_title=Label("b_2 p_t"),
                units="GeV",
                central="jet_smearing"),
            Feature("bjet2_eta", "Jet_eta.at(bjet2_JetIdx)", binning=(20, -5., 5.),
                x_title=Label("b_{2} #eta")),
            Feature("bjet2_phi", "Jet_phi.at(bjet2_JetIdx)", binning=(20, -3.2, 3.2),
                x_title=Label("b_{2} #phi")),
            Feature("bjet2_mass", "Jet_mass.at(bjet2_JetIdx)", binning=(10, 50, 150),
                x_title=Label("b_{2} m"),
                units="GeV",
                central="jet_smearing"),

            Feature("ctjet1_pt", "Jet_pt.at(ctjet_indexes.at(0))", binning=(10, 50, 150),
                x_title=Label("add. central jet 1 p_{t}"),
                units="GeV",
                central="jet_smearing",
                selection="ctjet_indexes.size() > 0"),
            Feature("ctjet1_eta", "Jet_eta.at(ctjet_indexes.at(0))", binning=(20, -5., 5.),
                x_title=Label("add. central jet 1 #eta"),
                selection="ctjet_indexes.size() > 0"),
            Feature("ctjet1_phi", "Jet_phi.at(ctjet_indexes.at(0))", binning=(20, -3.2, 3.2),
                x_title=Label("add. central jet 1 #phi"),
                selection="ctjet_indexes.size() > 0"),
            Feature("ctjet1_mass", "Jet_mass.at(ctjet_indexes.at(0))", binning=(10, 50, 150),
                x_title=Label("add. central jet 1 m"),
                units="GeV",
                central="jet_smearing",
                selection="ctjet_indexes.size() > 0"),
            Feature("fwjet1_pt", "Jet_pt.at(fwjet_indexes.at(0))", binning=(10, 50, 150),
                x_title=Label("add. forward jet 1 p_t"),
                units="GeV",
                central="jet_smearing",
                selection="fwjet_indexes.size() > 0"),
            Feature("fwjet1_eta", "Jet_eta.at(fwjet_indexes.at(0))", binning=(20, -5., 5.),
                x_title=Label("add. forward jet 1 #eta"),
                selection="fwjet_indexes.size() > 0"),
            Feature("fwjet1_phi", "Jet_phi.at(fwjet_indexes.at(0))", binning=(20, -3.2, 3.2),
                x_title=Label("add. forward jet 1  #phi"),
                selection="fwjet_indexes.size() > 0"),
            Feature("fwjet1_mass", "Jet_mass.at(fwjet_indexes.at(0))", binning=(10, 50, 150),
                x_title=Label("add. forward jet 1  m"),
                units="GeV",
                central="jet_smearing",
                selection="fwjet_indexes.size() > 0"),

            Feature("bjet_difpt", "abs({{bjet1_pt}} - {{bjet2_pt}})", binning=(10, 50, 150),
                x_title=Label("bb #Delta p_t"),
                units="GeV",
                central="jet_smearing"),

            # lepton features
            Feature("lep1_pt", "dau1_pt", binning=(10, 50, 150),
                x_title=Label("#tau_{1} p_{t}"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("lep1_eta", "dau1_eta", binning=(20, -5., 5.),
                x_title=Label("#tau_{1} #eta")),
            Feature("lep1_phi", "dau1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("#tau_{1} #phi")),
            Feature("lep1_mass", "dau1_mass", binning=(10, 50, 150),
                x_title=Label("#tau_{1} m"),
                units="GeV",
                systematics=["tes"]),

            Feature("lep2_pt", "dau2_pt", binning=(10, 50, 150),
                x_title=Label("#tau_{2} p_{t}"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("lep2_eta", "dau2_eta", binning=(20, -5., 5.),
                x_title=Label("#tau_{2} #eta")),
            Feature("lep2_phi", "dau2_phi", binning=(20, -3.2, 3.2),
                x_title=Label("#tau_{2} #phi")),
            Feature("lep2_mass", "dau2_mass", binning=(10, 50, 150),
                x_title=Label("#tau_{2} m"),
                units="GeV",
                systematics=["tes"]),

            # MET
            Feature("met_pt", "MET_pt", binning=(10, 50, 150),
                x_title=Label("MET p_t"),
                units="GeV",
                central="met_smearing"),
            Feature("met_phi", "MET_phi", binning=(20, -3.2, 3.2),
                x_title=Label("MET #phi"),
                central="met_smearing"),

            # Hbb
            Feature("Hbb_pt", "Hbb_pt", binning=(10, 50, 150),
                x_title=Label("Z(b #bar{b}) p_t"),
                units="GeV"),
            Feature("Hbb_eta", "Hbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b #bar{b}) #eta")),
            Feature("Hbb_phi", "Hbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b #bar{b}) #phi")),
            Feature("Hbb_mass", "Hbb_mass", binning=(100, 0, 500),
                x_title=Label("Z(b #bar{b}) m"),
                units="GeV"),

            # Htt
            Feature("Htt_pt", "Htt_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+} #tau^{-}) p_t"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("Htt_eta", "Htt_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+} #tau^{-}) #eta"),),
                # systematics=["tes"]),
            Feature("Htt_phi", "Htt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+} #tau^{-}) #phi"),),
                # systematics=["tes"]),
            Feature("Htt_mass", "Htt_mass", binning=(30, 0, 300),
                x_title=Label("H(#tau^{+} #tau^{-}) m"),
                units="GeV"),
                #systematics=["tes"]),

            # Htt (SVFit)
            Feature("Htt_svfit_pt", "Htt_svfit_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+} #tau^{-}) p_t (SVFit)"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("Htt_svfit_eta", "Htt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+} #tau^{-}) #eta (SVFit)"),),
                # systematics=["tes"]),
            Feature("Htt_svfit_phi", "Htt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+} #tau^{-}) #phi (SVFit)"),),
                # systematics=["tes"]),
            Feature("Htt_svfit_mass", "Htt_svfit_mass", binning=(70, 0, 350),
                x_title=Label("H(#tau^{+} #tau^{-}) m (SVFit)"),
                units="GeV"),
                # systematics=["tes"]),

            # HH
            Feature("HH_pt", "HH_pt", binning=(10, 50, 150),
                x_title=Label("ZZ p_{T}"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("HH_eta", "HH_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta")),
                # systematics=["tes"]),
            Feature("HH_phi", "HH_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi")),
                # systematics=["tes"]),
            Feature("HH_mass", "HH_mass", binning=(50, 0, 1000),
                x_title=Label("m_{bb#tau#tau}"),
                units="GeV"),
                # systematics=["tes"]),

            # HH (SVFit)
            Feature("HH_svfit_pt", "HH_svfit_pt", binning=(10, 50, 150),
                x_title=Label("HH p_t (SVFit)"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("HH_svfit_eta", "HH_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("HH #eta (SVFit)")),
                #systematics=["tes"]),
            Feature("HH_svfit_phi", "HH_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("HH #phi (SVFit)")),
                #systematics=["tes"]),
            Feature("HH_svfit_mass", "HH_svfit_mass", binning=(50, 0, 1000),
                x_title=Label("HH m (SVFit)"),
                units="GeV"),
                # systematics=["tes"]),

            # HH KinFit
            Feature("HHKinFit_mass", "HHKinFit_mass", binning=(50, 0, 1000),
                x_title=Label("HH m (Kin. Fit)"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("HHKinFit_chi2", "HHKinFit_chi2", binning=(30, 0, 10),
                x_title=Label("HH #chi^2 (Kin. Fit)"),),
                # systematics=["tes"]),

            # ZZ pt balance
            Feature("ZZ_pt_balance", "({{Hbb_pt}} - {{Htt_svfit_pt}}) / ({{Hbb_pt}} + {{Htt_svfit_pt}})",
                binning=(30, -1, 1),
                x_title=Label("(p_{T}^{Z_{1}} - p_{T}^{Z_{2}}) / (p_{T}^{Z_{1}} + p_{T}^{Z_{2}})"),
                units="GeV"),
            # ZZ angular variables
            Feature("ZZ_deta", "({{Hbb_eta}} - {{Htt_svfit_eta}})", 
                binning=(30, -5., 5.),
                x_title=Label("#Delta #eta")),
            Feature("ZZ_dphi", "({{Hbb_phi}} - {{Htt_svfit_phi}})",
                binning=(30, -3.2, 3.2),
                x_title=Label("#Delta#phi_{ZZ}")),
            Feature("ZZ_dR", "sqrt({{ZZ_deta}}*{{ZZ_deta}} + {{ZZ_dphi}}*{{ZZ_dphi}})", 
                binning=(30, 0, 10),
                x_title=Label("#Delta R_{ZZ}")),

            # Zbb
            Feature("Zbb_pt", "Zbb_pt", binning=(10, 50, 150),
                x_title=Label("Z(b #bar{b}) p_t"),
                units="GeV"),
            Feature("Zbb_eta", "Zbb_eta", binning=(20, -5., 5.),
                x_title=Label("Z(b #bar{b}) #eta")),
            Feature("Zbb_phi", "Zbb_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(b #bar{b}) #phi")),
            Feature("Zbb_mass", "Zbb_mass", binning=(100, 0, 500),
                x_title=Label("Z(b #bar{b}) m"),
                units="GeV"),

            # Ztt
            Feature("Ztt_pt", "Ztt_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+} #tau^{-}) p_t"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("Ztt_eta", "Ztt_eta", binning=(20, -5., 5.),
                x_title=Label("Z(#tau^{+} #tau^{-}) #eta"),),
                # systematics=["tes"]),
            Feature("Ztt_phi", "Ztt_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+} #tau^{-}) #phi"),),
                # systematics=["tes"]),
            Feature("Ztt_mass", "Ztt_mass", binning=(30, 0, 300),
                x_title=Label("Z(#tau^{+} #tau^{-}) m"),
                units="GeV"),
                #systematics=["tes"]),

            # Ztt (SVFit)
            Feature("Ztt_svfit_pt", "Ztt_svfit_pt", binning=(10, 50, 150),
                x_title=Label("Z(#tau^{+} #tau^{-}) p_t (SVFit)"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("Ztt_svfit_eta", "Ztt_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+} #tau^{-}) #eta (SVFit)"),),
                # systematics=["tes"]),
            Feature("Ztt_svfit_phi", "Ztt_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("Z(#tau^{+} #tau^{-}) #phi (SVFit)"),),
                # systematics=["tes"]),
            Feature("Ztt_svfit_mass", "Ztt_svfit_mass", binning=(70, 0, 350),
                x_title=Label("Z(#tau^{+} #tau^{-}) m (SVFit)"),
                units="GeV"),
                # systematics=["tes"]),

            # ZZ
            Feature("ZZ_pt", "ZZ_pt", binning=(10, 50, 150),
                x_title=Label("ZZ p_{T}"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("ZZ_eta", "ZZ_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta")),
                # systematics=["tes"]),
            Feature("ZZ_phi", "ZZ_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi")),
                # systematics=["tes"]),
            Feature("ZZ_mass", "ZZ_mass", binning=(50, 0, 1000),
                x_title=Label("m_{bb#tau#tau}"),
                units="GeV"),
                # systematics=["tes"]),

            # ZZ (SVFit)
            Feature("ZZ_svfit_pt", "ZZ_svfit_pt", binning=(10, 50, 150),
                x_title=Label("ZZ p_t (SVFit)"),
                units="GeV",),
                # systematics=["tes"]),
            Feature("ZZ_svfit_eta", "ZZ_svfit_eta", binning=(20, -5., 5.),
                x_title=Label("ZZ #eta (SVFit)")),
                #systematics=["tes"]),
            Feature("ZZ_svfit_phi", "ZZ_svfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("ZZ #phi (SVFit)")),
                #systematics=["tes"]),
            Feature("ZZ_svfit_mass", "ZZ_svfit_mass", binning=(50, 0, 1000),
                x_title=Label("ZZ_{bb#tau#tau}^{SVFit}"),
                units="GeV",
                systematics=["tes", "jer"]),

            # ZZ KinFit
            Feature("ZZKinFit_mass", "ZZKinFit_mass", binning=(50, 0, 1000),
                x_title=Label("ZZ m (Kin. Fit)"),
                units="GeV"),
                # systematics=["tes"]),
            Feature("ZZKinFit_chi2", "ZZKinFit_chi2", binning=(30, 0, 50),
                x_title=Label("ZZ #chi^2 (Kin. Fit)"),),
                # systematics=["tes"]),

            # dnn features
            Feature("CvsB_b1", "dnn_CvsB_b1", binning=(50, 0, 1), x_title=Label("CvsB (bJet_{1})")),
            Feature("CvsL_b1", "dnn_CvsL_b1", binning=(50, 0, 1), x_title=Label("CvsL (bJet_{1})")),
            Feature("dR_l1_l2_x_sv_pT", "dnn_dR_l1_l2_x_sv_pT", binning=(50, 0, 800), 
                x_title=Label("#DeltaR (l_{1}, l_{2}) #times p_{T} (Z_{#tau#tau}^{SVFit})")),
            Feature("dau1_mt", "dnn_dau1_mt", binning=(50, 0, 200), x_title=Label("m_{T} (l_{1})"), units="GeV"),
            Feature("dR_l1_l2", "dnn_dR_l1_l2", binning=(50, 0, 5), x_title=Label("#DeltaR (l_{1}, l_{2})")),
            Feature("dphi_sv_met", "dnn_dphi_sv_met", binning=(50, 0, 3.14), 
                x_title=Label("#Delta#phi (Z_{#tau#tau}^{SVFit}, MET)")),
            Feature("HHbtag_b2", "dnn_HHbtag_b2", binning=(50, 0, 1), x_title=Label("ZZbtag bJet_{2}")),
            Feature("dphi_Zbb_sv", "dnn_dphi_Zbb_sv", binning=(50, 0, 3.14), 
                x_title=Label("#Delta#phi (Z_{bb}, Z_{#tau#tau}^{SVFit})")),
            Feature("dR_l1_l2_boosted_Ztt_met", "dnn_dR_l1_l2_boosted_Ztt_met", binning=(50, 0, 5), 
                x_title=Label("#DeltaR (l_{1}, l_{2}) Boost(Z_{#tau#tau}+MET)")),
            Feature("Phi", "dnn_Phi", binning=(50, 0, 3.14), x_title=Label("#Phi")),
            Feature("dnn_bjet1_pt", "dnn_bjet1_pt", binning=(50, 0, 200), x_title=Label("p_{T} (bJet_{1})")),
            Feature("costheta_l2_Zttmet", "dnn_costheta_l2_Zttmet", binning=(50, 0, 1), x_title=Label("cos#Theta")),
            

            # VBFjet features
            Feature("vbfjet1_pt", "Jet_pt.at(VBFjet1_JetIdx)", binning=(10, 50, 150),
                x_title=Label("VBFjet1 p_{t}"),
                units="GeV",
                central="jet_smearing"),
            Feature("vbfjet1_eta", "Jet_eta.at(VBFjet1_JetIdx)", binning=(20, -5., 5.),
                x_title=Label("VBFjet1 #eta")),
            Feature("vbfjet1_phi", "Jet_phi.at(VBFjet1_JetIdx)", binning=(20, -3.2, 3.2),
                x_title=Label("VBFjet1 #phi")),
            Feature("vbfjet1_mass", "Jet_mass.at(VBFjet1_JetIdx)", binning=(10, 50, 150),
                x_title=Label("VBFjet1 m"),
                units="GeV",
                central="jet_smearing"),
            Feature("vbfjet2_pt", "Jet_pt.at(VBFjet2_JetIdx)", binning=(10, 50, 150),
                x_title=Label("VBFjet2 p_t"),
                units="GeV",
                central="jet_smearing"),
            Feature("vbfjet2_eta", "Jet_eta.at(VBFjet2_JetIdx)", binning=(20, -5., 5.),
                x_title=Label("VBFjet2 #eta")),
            Feature("vbfjet2_phi", "Jet_phi.at(VBFjet2_JetIdx)", binning=(20, -3.2, 3.2),
                x_title=Label("VBFjet2 #phi")),
            Feature("vbfjet2_mass", "Jet_mass.at(VBFjet2_JetIdx)", binning=(10, 50, 150),
                x_title=Label("VBFjet2 m"),
                units="GeV",
                central="jet_smearing"),

            # VBFjj
            Feature("VBFjj_mass", "VBFjj_mass", binning=(40, 0, 1000),
                x_title=Label("VBFjj mass"),
                units="GeV"),
            Feature("VBFjj_deltaEta", "VBFjj_deltaEta", binning=(40, -8, 8),
                x_title=Label("#Delta#eta(VBFjj)")),
            Feature("VBFjj_deltaPhi", "VBFjj_deltaPhi", binning=(40, -6.4, 6.4),
                x_title=Label("#Delta#phi(VBFjj)")),

            # Weights
            Feature("genWeight", "genWeight", binning=(20, 0, 2),
                x_title=Label("genWeight")),
            Feature("puWeight", "puWeight", binning=(20, 0, 2),
                x_title=Label("puWeight"),
                systematics=["pu"]),
            Feature("prescaleWeight", "prescaleWeight", binning=(20, 0, 2),
                x_title=Label("prescaleWeight")),
            Feature("trigSF", "trigSF", binning=(20, 0, 2),
                x_title=Label("trigSF")),
            Feature("L1PreFiringWeight", "L1PreFiringWeight", binning=(20, 0, 2),
                x_title=Label("L1PreFiringWeight"),
                central="prefiring",
                systematics=["prefiring_syst"]),
            Feature("PUjetID_SF", "PUjetID_SF", binning=(20, 0, 2),
                x_title=Label("PUjetID_SF")),

            Feature("dnn_zzbbtt_kl_1", "dnn_zzbbtt_kl_1", binning=(10, 0, 1),
                x_title=Label("DNN ZZ")),
            Feature("dnn_new_zzbbtt_kl_1", "dnn_new_zzbbtt_kl_1", binning=(10, 0, 1),
                x_title=Label("DNN New ZZ"),
                systematics=["tes"]),
            Feature("dnn_hhbbtt_kl_1", "dnn_hhbbtt_kl_1", binning=(10, 0, 1),
                x_title=Label("DNN HH")),

            Feature("genHH_mass", "genHH_mass", binning=(100, 0, 2500),
                x_title=Label("generator HH mass"),
                units="GeV"),
        ]
        return ObjectCollection(features)

    def add_weights(self):
        weights = DotDict()
        weights.default = "1"

        # weights.total_events_weights = ["genWeight", "puWeight", "DYstitchWeight"]
        weights.total_events_weights = ["genWeight", "puWeight"]

        weights.mutau = ["genWeight", "puWeight", "prescaleWeight", "trigSF",
            "L1PreFiringWeight", "PUjetID_SF"]

        weights.etau = weights.mutau
        weights.tautau = weights.mutau
        weights.base = weights.mutau

        # weights.channels_mult = {channel: jrs(weights.channels[channel], op="*")
            # for channel in weights.channels}
        return weights

    def add_systematics(self):
        systematics = [
            Systematic("jet_smearing", "_nom"),
            Systematic("jet_smearing_syst", "_smeared"),
            Systematic("met_smearing", ("MET", "MET_smeared")),
            Systematic("jer", "_smeared", up="up_up", down='down_down'),
            Systematic("jec", "_Total"),
            # Systematic("prefiring", "_Nom"),
            # Systematic("prefiring_syst", "", up="_Up", down="_Dn"),
            Systematic("pu", "", up="Up", down="Down"),
            Systematic("tes", "_corr"),
            Systematic("empty", "", up="", down="")
        ]
        return ObjectCollection(systematics)

    # other methods

    def get_channel_from_region(self, region):
        for sign in ["os", "ss"]:
            if sign in region.name:
                if region.name.startswith(sign):
                    return ""
                return region.name[:region.name.index("_%s" % sign)]
        return ""

    def get_qcd_regions(self, region, category, wp="", shape_region="os_inviso",
            signal_region_wp="os_iso", sym=False):
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


config = Config("base", year=2018, ecm=13, lumi_pb=59741)
