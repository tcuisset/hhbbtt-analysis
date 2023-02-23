import sympy
from sympy import *
from sympy import Matrix
from array import array
import sys
import ROOT


#########################
### General functions ###
#########################

# General function to rescale any histogram to a specific value
def scaleTo(hIn, val):
    hIn.Scale(val)

# General function to build a sympy.Matrix from a list of "inputSample"
# def build_matrix(sample_list):    
    # if len(sample_list) != 6:
        # print("[ERROR] : expecting 6 samples in input")
        # raise RuntimeError("malformed input sample list")

    # M_tofill = [
        # [None,None,None,None,None,None],
        # [None,None,None,None,None,None],
        # [None,None,None,None,None,None],
        # [None,None,None,None,None,None],
        # [None,None,None,None,None,None],
        # [None,None,None,None,None,None]
    # ]

    # # Implement the 6 scalings
    # for isample, sample in enumerate(sample_list):
        # M_tofill[isample][0] = sample.val_kv**2 * sample.val_kl**2
        # M_tofill[isample][1] = sample.val_kv**4
        # M_tofill[isample][2] = sample.val_k2v**2
        # M_tofill[isample][3] = sample.val_kv**3 * sample.val_kl
        # M_tofill[isample][4] = sample.val_kv    * sample.val_k2v    * sample.val_kl
        # M_tofill[isample][5] = sample.val_kv**2 * sample.val_k2v
    
    # res = Matrix(M_tofill)
    # return res


################################################
### Class for handling the three input samples ###
################################################
class InputSample:
    def __init__(self, val_kl, val_kt, val_xs):
        self.kl  = val_kl
        self.kt  = val_kt
        self.xs  = val_xs

########################################
### Class for actual ggF reweighting ###
########################################
class ggFReweight:
    def __init__(self, samples):
        self.n_samples = len(samples)
        self.sample_list = samples
        self.M = sympy.Matrix([
            [
                sample.kt**4,
                sample.kt**2 * sample.kl**2,
                sample.kt**3 * sample.kl,
            ]
            for i, sample in enumerate(samples)
        ])

        # the vector of couplings
        kl, kt = sympy.symbols("kl kt")
        c = sympy.Matrix([
            [kt**4],
            [kt**2 * kl**2],
            [kt**3 * kl],
        ])

        self.kl = kl
        self.kt = kt

        # the vector of symbolic sample cross sections
        s = sympy.Matrix([
            [sympy.Symbol("xs{}".format(i))]
            for i in range(self.n_samples)
        ])

        self.xs0 = s[0]
        self.xs1 = s[1]
        self.xs2 = s[2]

        # actual computation, i.e., matrix inversion and multiplications with vectors
        M_inv = self.M.pinv()
        self.coeffs = c.transpose() * M_inv
        self.sigma = self.coeffs * s

    # Returns the modeled cross section and histogram given the target couplings
    def modelSignal(self, t_kl, t_kt, histos, target_xs=-1.):
        # Eval the final cross section
        total_xs = self.sigma[0].evalf(subs={
            self.kl  : t_kl,
            self.kt  : t_kt,
            self.xs0  : self.sample_list[0].xs,
            self.xs1  : self.sample_list[1].xs,
            self.xs2  : self.sample_list[2].xs,
        })

        # Eval the single coefficients
        eval_coeffs = []
        for coeff in self.coeffs:
            eval_coeffs.append(coeff.evalf(subs={self.kl:t_kl, self.kt:t_kt}))

        # Get a clone of the input histograms to be scaled and summed
        hists = []
        for histo in histos:
            hists.append(histo.Clone())

        # Normalize each histo to his coefficient * xs
        for i,sample in enumerate(self.sample_list):
            if target_xs == -1.:
                scaleTo(hists[i], eval_coeffs[i])
            else:
                scaleTo(hists[i], eval_coeffs[i] * target_xs)
                #scaleTo(hists[i], eval_coeffs[i] * target_xs / sample.val_xs)

        # Get the final histogram by adding the six hists
        for i,histo in enumerate(hists):
            if i == 0:
                tot_histo = histo.Clone('ggHH_kl_'+str(t_kl)+'_kt_'+str(t_kt))
            else:
                tot_histo.Add(histo)

        return total_xs, tot_histo
