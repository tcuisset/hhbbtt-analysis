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
        self.categories = self.add_categories(btag = "bjet{}_bID_deepFlavor")
        self.tree_name = "HTauTauTree"

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
            Feature("HHKinFit_mass", "HHKin_mass_raw", binning=(50, 0, 2000),
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

            # weights
            Feature("PUjetID_SF", "PUjetID_SF", binning=(100, 0, 2),
                x_title=Label("PUjetID_SF"), tags=["weight"], systematic=["pujetsyst"]),
            Feature("PUReweight", "PUReweight", binning=(100, 0, 0.05),
                x_title=Label("PUReweight"), tags=["weight"]),
            Feature("bTagweightReshape", "bTagweightReshape", binning=(100, 0, 2),
                x_title=Label("bTagweightReshape"), tags=["weight"],
                systematics=["jet_1", "jet_2", "jet_3", "jet_4", "jet_5", "jet_6",
                    "jet_7", "jet_8", "jet_9", "jet_10", "jet_11",
                    "jes", "ls", "hf", "hfstats1", "hfstats2", "lfstats1", "cferr1", "cferr2"]),
            Feature("trigSF", "trigSF", binning=(100, 0, 2),
                x_title=Label("trigSF"), tags=["weight"],
                systematics=["muon_general", "electron_general", "dm0", "dm1", "dm10", "dm11", "vbfjet"]),
            Feature("IdAndIsoSF_deep_pt", "IdAndIsoAndFakeSF_deep_pt", binning=(100, 0, 2),
                x_title=Label("IdAndIsoSF_deep_pt"), tags=["weight"],
                systematics=["idAndIsoAndFakeSF_tauid_pt20to25", "idAndIsoAndFakeSF_tauid_pt25to30",
                    "idAndIsoAndFakeSF_tauid_pt30to35", "idAndIsoAndFakeSF_tauid_pt35to40",
                    "idAndIsoAndFakeSF_tauid_pt40toInf", "idAndIsoAndFakeSF_mutauFR_etaLt0p4",
                    "idAndIsoAndFakeSF_mutauFR_eta0p4to0p8", "idAndIsoAndFakeSF_mutauFR_eta0p8to1p2",
                    "idAndIsoAndFakeSF_mutauFR_eta1p2to1p7", "idAndIsoAndFakeSF_mutauFR_etaGt1p7",
                    "idAndIsoAndFakeSF_etauFR_barrel", "idAndIsoAndFakeSF_etauFR_endcap"]),
            Feature("smearing_factor", "{bjet1_smearFactor, bjet1_smearFactor2}", binning=(100, 0, 2),
                x_title=Label("smearing_factor"), tags=["weight"]),
            Feature("L1pref_weight", "L1pref_weight", binning=(100, 0, 2),
                x_title=Label("L1pref_weight"), tags=["weight"]),
            Feature("prescaleWeight", "prescaleWeight", binning=(100, 0, 2),
                x_title=Label("prescaleWeight"), tags=["weight"]),

            # DNN
            Feature("dnn", "DNNoutSM_kl_1", binning=(50, 0, 1),
                x_title=Label("DNN output"),
                systematics=["muon", "electron_dm0", "electron_dm1",
                    "tau_dm0", "tau_dm1", "tau_dm10", "tau_dm11",
                    "jet_1", "jet_2", "jet_3", "jet_4", "jet_5", "jet_6",
                    "jet_7", "jet_8", "jet_9", "jet_10", "jet_11"]),
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

            Dataset("ggf_sm",
                folder=os.path.join(skim_directory, "SKIM_GGHH_NLO_cHHH1_xs"),
                process=self.processes.get("ggf_sm"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("ggf_sm_syst",
                folder=os.path.join(skim_directory, "SKIM_GGHH_NLO_cHHH1_xs"),
                process=self.processes.get("ggf_sm"),
                file_pattern="syst_output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("ggf_0_1",
                folder=os.path.join(skim_directory, "SKIM_GGHH_NLO_cHHH0_xs"),
                process=self.processes.get("ggf_0_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("ggf_2p45_1",
                folder=os.path.join(skim_directory, "SKIM_GGHH_NLO_cHHH2p45_xs"),
                process=self.processes.get("ggf_2p45_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            Dataset("ggf_5_1",
                folder=os.path.join(skim_directory, "SKIM_GGHH_NLO_cHHH5_xs"),
                process=self.processes.get("ggf_5_1"),
                file_pattern="output_.*root",
                xs=1.),  # already normalised to xs

            # Backgrounds
            Dataset("tt_dl",
                folder=os.path.join(skim_directory, "SKIM_TT_fullyLep"),
                process=self.processes.get("tt_dl"),
                file_pattern="output_.*root",
                merging={
                    "resolved_1b": 5,
                    "resolved_2b": 5,
                    "vbf": 5,
                },
                xs=1.),  # already normalised to xs

            Dataset("tt_sl",
                folder=os.path.join(skim_directory, "SKIM_TT_semiLep"),
                process=self.processes.get("tt_sl"),
                file_pattern="output_.*root",
                merging={
                    "resolved_1b": 5,
                    "resolved_2b": 5,
                    "vbf": 5,
                },
                xs=1.),  # already normalised to xs

            Dataset("dy",
                folder=os.path.join(skim_directory, "SKIM_DY"),
                process=self.processes.get("dy_high"),
                file_pattern="output_.*root",
                merging={
                    "resolved_1b": 2,
                    "resolved_2b": 2,
                    "vbf": 2,
                },
                xs=1.),  # already normalised to xs
        ]
        return ObjectCollection(datasets)

    def add_weights(self):
        weights = DotDict()
        weights.default = "1"

        # The last number is the needed scaling to correct the bTagweightReshape weights
        # each channel has its own, and this should be propagated correctly to each category.
        # when considering the three channels at once, for now we take the etau number, but 
        # this should be fixed

        weights.mutau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight", "prescaleWeight",
            "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "bTagweightReshape", "0.9890"]
        weights.etau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight", "prescaleWeight",
            "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "bTagweightReshape", "0.9831"]
        weights.tautau = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight",
            "prescaleWeight", "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "customTauIdSF",
            "bTagweightReshape", "1.0038"]
        weights.baseline = ["MC_weight", "PUReweight", "PUjetID_SF", "L1pref_weight",
            "prescaleWeight", "trigSF", "IdAndIsoAndFakeSF_deep_pt", "DYscale_MTT", "customTauIdSF",
            "bTagweightReshape", "0.9831"]

        # weights.channels_mult = {channel: jrs(weights.channels[channel], op="*")
            # for channel in weights.channels}
        return weights

    def add_systematics(self):
        systematics = [
            Systematic("muon_general", "_mu"),
            Systematic("electron_general", "_ele"),
            Systematic("dm0", "_DM0"),
            Systematic("dm1", "_DM1"),
            Systematic("dm10", "_DM10"),
            Systematic("dm11", "_DM11"),
            Systematic("muon", "_mu", up="up", down="down"),
            Systematic("electron_dm0", "_ele", up="up_DM0", down="down_DM0"),
            Systematic("electron_dm1", "_ele", up="up_DM1", down="down_DM1"),
            Systematic("tau_dm0", "_tau", up="up_DM0", down="down_DM0"),
            Systematic("tau_dm1", "_tau", up="up_DM1", down="down_DM1"),
            Systematic("tau_dm10", "_tau", up="up_DM10", down="down_DM10"),
            Systematic("tau_dm11", "_tau", up="up_DM11", down="down_DM11"),
            Systematic("jet_1", "_jet", up="up1", down="down1"),
            Systematic("jet_2", "_jet", up="up2", down="down2"),
            Systematic("jet_3", "_jet", up="up3", down="down3"),
            Systematic("jet_4", "_jet", up="up4", down="down4"),
            Systematic("jet_5", "_jet", up="up5", down="down5"),
            Systematic("jet_6", "_jet", up="up6", down="down6"),
            Systematic("jet_7", "_jet", up="up7", down="down7"),
            Systematic("jet_8", "_jet", up="up8", down="down8"),
            Systematic("jet_9", "_jet", up="up9", down="down9"),
            Systematic("jet_10", "_jet", up="up10", down="down10"),
            Systematic("jet_11", "_jet", up="up11", down="down11"),
            Systematic("pujetsyst", ""),
            Systematic("jes", "_jes"),
            Systematic("ls", "_lf"),
            Systematic("hf", "_hf"),
            Systematic("hfstats1", "_hfstats1"),
            Systematic("hfstats2", "_hfstats2"),
            Systematic("lfstats1", "_lfstats1"),
            Systematic("cferr1", "_cferr1"),
            Systematic("cferr2", "_cferr2"),
            Systematic("vbfjet", "_vbfjet"),
            Systematic("idAndIsoAndFakeSF_tauid_pt20to25", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_tauid_pt20to25")),
            Systematic("idAndIsoAndFakeSF_tauid_pt25to30", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_tauid_pt25to30")),
            Systematic("idAndIsoAndFakeSF_tauid_pt30to35", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_tauid_pt30to35")),
            Systematic("idAndIsoAndFakeSF_tauid_pt35to40", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_tauid_pt35to40")),
            Systematic("idAndIsoAndFakeSF_tauid_pt40toInf", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_tauid_pt40toInf")),
            Systematic("idAndIsoAndFakeSF_mutauFR_etaLt0p4", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_mutauFR_etaLt0p4")),
            Systematic("idAndIsoAndFakeSF_mutauFR_eta0p4to0p8", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_mutauFR_eta0p4to0p8")),
            Systematic("idAndIsoAndFakeSF_mutauFR_eta0p8to1p2", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_mutauFR_eta0p8to1p2")),
            Systematic("idAndIsoAndFakeSF_mutauFR_eta1p2to1p7", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_mutauFR_eta1p2to1p7")),
            Systematic("idAndIsoAndFakeSF_mutauFR_etaGt1p7", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_mutauFR_etaGt1p7")),
            Systematic("idAndIsoAndFakeSF_etauFR_barrel", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_etauFR_barrel")),
            Systematic("idAndIsoAndFakeSF_etauFR_endcap", ("IdAndIsoAndFakeSF_deep_pt", "idAndIsoAndFakeSF_etauFR_endcap")),
        ]
        return ObjectCollection(systematics)


config = Config("base", year=2018, ecm=13, lumi_pb=59741)
