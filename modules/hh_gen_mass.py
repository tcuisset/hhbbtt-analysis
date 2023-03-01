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
