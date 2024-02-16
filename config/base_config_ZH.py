""" Base configuration for X->ZH->bbtautau analysis (no specific year). Inherits from base_config.py """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from plotting_tools import Label

from config.base_config import get_common_processes, BaseConfig

def get_ZH_common_features():
    """ Returns the features that are common to both ZH analyses"""
    return ObjectCollection([
        # ZH
        Feature("ZH_pt", "ZH_pt", binning=(10, 50, 150),
            x_title=Label("ZH p_{T}"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_eta", "ZH_eta", binning=(20, -5., 5.),
            x_title=Label("ZH #eta"),
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_phi", "ZH_phi", binning=(20, -3.2, 3.2),
            x_title=Label("ZH #phi"),
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_mass", "ZH_mass", binning=(50, 0, 1000),
            x_title=Label("ZH_{bb#tau#tau} mass"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_mass_fine", "ZH_mass", binning=(600, 0, 3000),
            x_title=Label("ZH_{bb#tau#tau} mass"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

        # ZH (SVFit)
        Feature("ZH_svfit_pt", "ZH_svfit_pt", binning=(10, 50, 150),
            x_title=Label("ZH p_{T} (SVFit)"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_svfit_eta", "ZH_svfit_eta", binning=(20, -5., 5.),
            x_title=Label("ZH #eta (SVFit)"),
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_svfit_phi", "ZH_svfit_phi", binning=(20, -3.2, 3.2),
            x_title=Label("ZH #phi (SVFit)"),
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_svfit_mass", "ZH_svfit_mass", binning=(50, 0, 1000),
            x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZH_svfit_mass_fine", "ZH_svfit_mass", binning=(600, 0, 3000),
            x_title=Label("ZH_{bb#tau#tau}^{SVFit} mass"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),

        # ZH KinFit
        Feature("ZHKinFit_mass", "ZHKinFit_mass", binning=(50, 0, 1000),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZHKinFit_highmass", "ZHKinFit_mass", binning=(175, 0, 3500),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZHKinFit_mass_res", "ZHKinFit_mass", binning=(50, 180, 1180),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZHKinFit_highmass_res", "ZHKinFit_mass", binning=(175, 180, 3680),
            x_title=Label("ZH mass (Kin. Fit)"),
            units="GeV",
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
        Feature("ZHKinFit_chi2", "ZHKinFit_chi2", binning=(30, 0, 50),
            x_title=Label("ZH #chi^{2} (Kin. Fit)"),
            systematics=["tes", "jer", "jec_1", "jec_2", "jec_3", "jec_4", "jec_5", "jec_6", 
                            "jec_7", "jec_8", "jec_9", "jec_10", "jec_11"]),
    ])

#def get_ZH_common_processes():
#    """ Returns the processes that are common to both ZH analyses"""

