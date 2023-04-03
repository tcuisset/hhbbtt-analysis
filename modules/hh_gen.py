from analysis_tools.utils import import_root

ROOT = import_root()

class HHGenMassRDFProducer():
    def __init__(self):
        ROOT.gInterpreter.Declare("""
            #include <TLorentzVector.h>
            using Vfloat = const ROOT::RVec<float>&;
            double get_invariant_mass(Vfloat pt, Vfloat eta, Vfloat phi, Vfloat mass) {
                auto H1 = TLorentzVector();
                auto H2 = TLorentzVector();
                auto HH = TLorentzVector();
                H1.SetPtEtaPhiM(pt[0], eta[0], phi[0], mass[0]);
                H2.SetPtEtaPhiM(pt[1], eta[1], phi[1], mass[1]);
                HH = H1 + H2;
                return HH.M();
            }
        """)
        
    def run(self, df):
        df = df.Define("genHH_mass", """get_invariant_mass(
            GenPart_pt[{0}],
            GenPart_eta[{0}],
            GenPart_phi[{0}],
            GenPart_mass[{0}]        
        )""".format("GenPart_pdgId == 25 && GenPart_status == 22"))
        return df, ["genHH_mass"]


def HHGenMassRDF():
    return lambda: HHGenMassRDFProducer()


class HHGenDeltaEtaRDFProducer():        
    def run(self, df):
        df = df.Define("genHH_deltaEta", "fabs(GenPart_eta[{0}][0] - GenPart_eta[{0}][1])".format(
            "GenPart_pdgId == 25 && GenPart_status == 22"))
        return df, ["genHH_deltaEta"]


def HHGenDeltaEtaRDF():
    return lambda: HHGenDeltaEtaRDFProducer()


class HHMaxGenMassRDFProducer():
    def __init__(self):
        ROOT.gInterpreter.Declare("""
            #include <TLorentzVector.h>
            using Vfloat = const ROOT::RVec<float>&;
            double get_max_invariant_mass(Vfloat pt, Vfloat eta, Vfloat phi, Vfloat mass) {
                double max_inv_mass = -999.;
                for (size_t i = 0; i < pt.size() - 1; i++) {
                    for (size_t j = i + 1; j < pt.size(); j++) {
                        auto jet1 = TLorentzVector();
                        auto jet2 = TLorentzVector();
                        auto jj = TLorentzVector();
                        jet1.SetPtEtaPhiM(pt[i], eta[i], phi[i], mass[i]);
                        jet2.SetPtEtaPhiM(pt[j], eta[j], phi[j], mass[j]);
                        jj = jet1 + jet2;
                        if (jj.M() > max_inv_mass)
                            max_inv_mass = jj.M();
                    }
                }
                return max_inv_mass;
            }
        """)

    def run(self, df):
        df = df.Define("max_genjj_mass",
            "get_max_invariant_mass(GenJet_pt, GenJet_eta, GenJet_phi, GenJet_mass)")
        return df, ["max_genjj_mass"]


def HHMaxGenMassRDF():
    return lambda: HHMaxGenMassRDFProducer()


class HHMaxGenDeltaEtaRDFProducer():
    def __init__(self):
        ROOT.gInterpreter.Declare("""
            #include <TLorentzVector.h>
            using Vfloat = const ROOT::RVec<float>&;
            double get_max_delta_eta(Vfloat eta) {
                double max_delta_eta = -999.;
                for (size_t i = 0; i < eta.size() - 1; i++) {
                    for (size_t j = i + 1; j < eta.size(); j++) {
                        if (fabs(eta[i] - eta[j]) > max_delta_eta)
                            max_delta_eta = fabs(eta[i] - eta[j]);
                    }
                }
                return max_delta_eta;
            }
        """)

    def run(self, df):
        df = df.Define("max_genjj_delta_eta", "get_max_delta_eta(GenJet_eta)")
        return df, ["max_genjj_delta_eta"]


def HHMaxGenDeltaEtaRDF():
    return lambda: HHMaxGenDeltaEtaRDFProducer()