from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict
from analysis_tools.utils import join_root_selection as jrs
from plotting_tools import Label
from collections import OrderedDict
import os

from config.base_config import Config as cmt_config


class Config(cmt_config):
    def __init__(self, *args, **kwargs):
        super(Config, self).__init__(*args, **kwargs)
        self.deeptau=DotDict(
            vsjet=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=8),
            vse=DotDict(VVVLoose=1, VVLoose=2, VLoose=3, Loose=4, Medium=5,
                Tight=6, VTight=7, VVTight=5),
            vsmu=DotDict(VLoose=1, Loose=2, Medium=3, Tight=4),
        )
        self.regions = self.add_regions()

    def add_regions(self):
        selection = OrderedDict()
        region_names = ["Signal region", "OS inv. iso", "SS iso", "SS inv. iso"]
        selection["os_iso"] = {
            "mutau": ["isOS == 1", "dau1_iso < 0.15",
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 1", "dau1_eleMVAiso == 1",
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 1",
                "dau1_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
        }
        selection["os_inviso"] = {
            "mutau": ["isOS == 1", "dau1_iso < 0.15", "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 1", "dau1_eleMVAiso == 1", "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 1",
                "dau1_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
        }
        selection["ss_iso"] = {
            "mutau": ["isOS == 0", "dau1_iso < 0.15",
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 0", "dau1_eleMVAiso == 1",
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 0",
                "dau1_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium],
        }
        selection["ss_inviso"] = {
            "mutau": ["isOS == 0", "dau1_iso < 0.15", "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
            "etau": ["isOS == 0", "dau1_eleMVAiso == 1", "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
            "tautau": ["isOS == 0",
                "dau1_deepTauVsJet >= %s" % self.deeptau.vsjet.Medium,
                "dau2_deepTauVsJet >= 1",
                "dau2_deepTauVsJet < %s" % self.deeptau.vsjet.Medium],
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

    def add_categories(self):
        reject_sel = ["pairType == -31415"]

        sel = DotDict()
        df = lambda i, op, wp: "bjet{}_bID_deepFlavor {} {}".format(i, op, self.btag[wp])
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
            Category("base", "base category"),
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
            # Category("dum", "dummy category", selection="event == 220524669"),
            Category("dum", "dummy category", selection="event == 74472670"),
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

    def add_features(self):
        features = [

            # bjet features
            Feature("bjet1_pt", "bjet1_pt", binning=(10, 50, 150),
                x_title=Label("b_{1} p_{t}"),
                units="GeV"),
            Feature("bjet1_eta", "bjet1_eta", binning=(20, -5., 5.),
                x_title=Label("b_{1} #eta")),
            Feature("bjet1_phi", "bjet1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("b_{1} #phi")),
            Feature("bjet1_mass", "bjet1_mass", binning=(10, 50, 150),
                x_title=Label("b_{1} m"),
                units="GeV"),
            Feature("bjet2_pt", "bjet2_pt", binning=(10, 50, 150),
                x_title=Label("b_2 p_t"),
                units="GeV"),
            Feature("bjet2_eta", "bjet2_eta", binning=(20, -5., 5.),
                x_title=Label("b_{2} #eta")),
            Feature("bjet2_phi", "bjet2_phi", binning=(20, -3.2, 3.2),
                x_title=Label("b_{2} #phi")),
            Feature("bjet2_mass", "bjet2_mass", binning=(10, 50, 150),
                x_title=Label("b_{2} m"),
                units="GeV"),

            Feature("ctjet1_pt", "addJetCentr1_pt", binning=(10, 50, 150),
                x_title=Label("add. central jet 1 p_{t}"),
                units="GeV"),
            Feature("ctjet1_eta", "addJetCentr1_eta", binning=(20, -5., 5.),
                x_title=Label("add. central jet 1 #eta")),
            Feature("ctjet1_phi", "addJetCentr1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("add. central jet 1 #phi")),
            Feature("ctjet1_mass", "addJetCentr1_mass", binning=(10, 50, 150),
                x_title=Label("add. central jet 1 m"),
                units="GeV"),
            Feature("fwjet1_pt", "addJetForw1_pt", binning=(10, 50, 150),
                x_title=Label("add. forward jet 1 p_t"),
                units="GeV"),
            Feature("fwjet1_eta", "addJetForw1_eta", binning=(20, -5., 5.),
                x_title=Label("add. forward jet 1 #eta")),
            Feature("fwjet1_phi", "addJetForw1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("add. forward jet 1  #phi")),
            Feature("fwjet1_mass", "addJetForw1_mass", binning=(10, 50, 150),
                x_title=Label("add. forward jet 1  m"),
                units="GeV"),

            Feature("bjet_difpt", "abs({{bjet1_pt}} - {{bjet2_pt}})", binning=(10, 50, 150),
                x_title=Label("bb #Delta p_t"),
                units="GeV"),

            # lepton features
            Feature("lep1_pt", "dau1_pt", binning=(10, 50, 150),
                x_title=Label("#tau_{1} p_{t}"),
                units="GeV"),
            Feature("lep1_eta", "dau1_eta", binning=(20, -5., 5.),
                x_title=Label("#tau_{1} #eta")),
            Feature("lep1_phi", "dau1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("#tau_{1} #phi")),
            Feature("lep1_mass", "dau1_mass", binning=(10, 50, 150),
                x_title=Label("#tau_{1} m"),
                units="GeV"),
            Feature("lep2_pt", "dau2_pt", binning=(10, 50, 150),
                x_title=Label("#tau_{2} p_{t}"),
                units="GeV"),
            Feature("lep2_eta", "dau2_eta", binning=(20, -5., 5.),
                x_title=Label("#tau_{2} #eta")),
            Feature("lep2_phi", "dau2_phi", binning=(20, -3.2, 3.2),
                x_title=Label("#tau_{2} #phi")),
            Feature("lep2_mass", "dau2_mass", binning=(10, 50, 150),
                x_title=Label("#tau_{2} m"),
                units="GeV"),

            # MET
            Feature("met_pt", "met_et", binning=(10, 50, 150),
                x_title=Label("MET p_t"),
                units="GeV"),
            Feature("met_phi", "met_phi", binning=(20, -3.2, 3.2),
                x_title=Label("MET #phi")),

            # Hbb
            Feature("Hbb_pt", "bH_pt", binning=(10, 50, 150),
                x_title=Label("H(b #bar{b}) p_t"),
                units="GeV"),
            Feature("Hbb_eta", "bH_eta", binning=(20, -5., 5.),
                x_title=Label("H(b #bar{b}) #eta")),
            Feature("Hbb_phi", "bH_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(b #bar{b}) #phi")),
            Feature("Hbb_mass", "bH_mass", binning=(30, 0, 300),
                x_title=Label("H(b #bar{b}) m"),
                units="GeV"),

            # Htt
            Feature("Htt_pt", "tauH_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+} #tau^{-}) p_t"),
                units="GeV"),
            Feature("Htt_eta", "tauH_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+} #tau^{-}) #eta")),
            Feature("Htt_phi", "tauH_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+} #tau^{-}) #phi")),
            Feature("Htt_mass", "tauH_mass", binning=(30, 0, 300),
                x_title=Label("H(#tau^{+} #tau^{-}) m"),
                units="GeV"),
                #systematics=["tes"]),

            # Htt (SVFit)
            Feature("Htt_svfit_pt", "tauH_SVFIT_pt", binning=(10, 50, 150),
                x_title=Label("H(#tau^{+} #tau^{-}) p_t (SVFit)"),
                units="GeV",
                systematics=["tes"]),
            Feature("Htt_svfit_eta", "tauH_SVFIT_eta", binning=(20, -5., 5.),
                x_title=Label("H(#tau^{+} #tau^{-}) #eta (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_phi", "tauH_SVFIT_phi", binning=(20, -3.2, 3.2),
                x_title=Label("H(#tau^{+} #tau^{-}) #phi (SVFit)"),
                systematics=["tes"]),
            Feature("Htt_svfit_mass", "tauH_SVFIT_mass", binning=(30, 0, 300),
                x_title=Label("H(#tau^{+} #tau^{-}) m (SVFit)"),
                units="GeV"),
                #systematics=["tes"]),

            # HH
            Feature("HH_pt", "HH_pt", binning=(10, 50, 150),
                x_title=Label("HH p_t"),
                units="GeV",
                systematics=["tes"]),
            Feature("HH_eta", "HH_eta", binning=(20, -5., 5.),
                x_title=Label("HH #eta"),
                systematics=["tes"]),
            Feature("HH_phi", "HH_phi", binning=(20, -3.2, 3.2),
                x_title=Label("HH #phi"),
                systematics=["tes"]),
            Feature("HH_mass", "HH_mass", binning=(50, 0, 1000),
                x_title=Label("HH m"),
                units="GeV",
                systematics=["tes"]),

            # HH (SVFit)
            Feature("HH_svfit_pt", "HHsvfit_pt", binning=(10, 50, 150),
                x_title=Label("HH p_t (SVFit)"),
                units="GeV"),
            Feature("HH_svfit_eta", "HHsvfit_eta", binning=(20, -5., 5.),
                x_title=Label("HH #eta (SVFit)")),
            Feature("HH_svfit_phi", "HHsvfit_phi", binning=(20, -3.2, 3.2),
                x_title=Label("HH #phi (SVFit)")),
            Feature("HH_svfit_mass", "HHsvfit_mass", binning=(50, 0, 1000),
                x_title=Label("HH m (SVFit)"),
                units="GeV"),

            # HH KinFit
            Feature("HHKinFit_mass", "HHKin_mass_raw", binning=(50, 0, 1000),
                x_title=Label("HH m (Kin. Fit)"),
                units="GeV"),
            Feature("HHKinFit_chi2", "HHKin_mass_raw_chi2", binning=(30, 0, 10),
                x_title=Label("HH #chi^2 (Kin. Fit)")),

            # VBFjet features
            Feature("vbfjet1_pt", "VBFjet1_pt", binning=(10, 50, 150),
                x_title=Label("VBFjet1 p_{t}"),
                units="GeV"),
            Feature("vbfjet1_eta", "VBFjet1_eta", binning=(20, -5., 5.),
                x_title=Label("VBFjet1 #eta")),
            Feature("vbfjet1_phi", "VBFjet1_phi", binning=(20, -3.2, 3.2),
                x_title=Label("VBFjet1 #phi")),
            Feature("vbfjet1_mass", "VBFjet1_mass", binning=(10, 50, 150),
                x_title=Label("VBFjet1 m"),
                units="GeV"),
            Feature("vbfjet2_pt", "VBFjet2_pt", binning=(10, 50, 150),
                x_title=Label("VBFjet2 p_t"),
                units="GeV"),
            Feature("vbfjet2_eta", "VBFjet2_eta", binning=(20, -5., 5.),
                x_title=Label("VBFjet2 #eta")),
            Feature("vbfjet2_phi", "VBFjet2_phi", binning=(20, -3.2, 3.2),
                x_title=Label("VBFjet2 #phi")),
            Feature("vbfjet2_mass", "VBFjet2_mass", binning=(10, 50, 150),
                x_title=Label("VBFjet2 m"),
                units="GeV"),

            # VBFjj
            Feature("VBFjj_mass", "VBFjj_mass", binning=(40, 0, 1000),
                x_title=Label("VBFjj mass"),
                units="GeV"),
            Feature("VBFjj_deltaEta", "VBFjj_deltaEta", binning=(40, -8, 8),
                x_title=Label("#Delta#eta(VBFjj)")),
            Feature("VBFjj_deltaPhi", "VBFjj_deltaPhi", binning=(40, -6.4, 6.4),
                x_title=Label("#Delta#phi(VBFjj)")),
        ]
        return ObjectCollection(features)
        
    
    def add_datasets(self):
        skim_directory = "/eos/user/j/jmotta/SKIMMED_Legacy2018_16Feb2021_HHbtag"
        datasets = [
            Dataset("vbf_sm",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_C2V_1_C3_1_xs"),
                process=self.processes.get("vbf_sm"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_0p5_1_1",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_0_5_C2V_1_C3_1_xs"),
                process=self.processes.get("vbf_0p5_1_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_1p5_1_1",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_5_C2V_1_C3_1_xs"),
                process=self.processes.get("vbf_1p5_1_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_1_0_1",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_C2V_0_C3_1_xs"),
                process=self.processes.get("vbf_1_0_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_1_1_0",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_C2V_1_C3_0_xs"),
                process=self.processes.get("vbf_1_1_0"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_1_1_2",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_C2V_1_C3_2_xs"),
                process=self.processes.get("vbf_1_1_2"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("vbf_1_2_1",
                folder=os.path.join(skim_directory, "SKIM_VBFHH_CV_1_C2V_2_C3_1_xs"),
                process=self.processes.get("vbf_1_2_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

        ]
        return ObjectCollection(datasets)

    def add_weights(self):
        weights = DotDict()
        weights.default = "1"

        weights.mutau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight", "prescaleWeight",
            "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "bTagweightReshape", "0.9890"]
        weights.etau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight", "prescaleWeight",
            "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "bTagweightReshape", "0.9831"]
        weights.tautau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight",
            "prescaleWeight", "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "customTauIdSF",
            "bTagweightReshape", "0.9831"]

        # weights.channels_mult = {channel: jrs(weights.channels[channel], op="*")
            # for channel in weights.channels}
        return weights


config = Config("base", year=2018, ecm=13, lumi_pb=59741)
