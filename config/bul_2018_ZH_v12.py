""" ZH datasets for 2018 """
from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict

from config.base_config_ZH import resonant_masses_ZH
from config.bul_2018_v12 import get_common_datasets_v12

def get_datasets_ZH_2018(self):
    datasets = get_common_datasets_v12(self)

    # ZH datasets
    # ZH_HToTT_ZToBB is split in 2 processes :
    # - zh_zbb_htt_signal (with filter for bbtautau decay) 
    # - zh_zbb_htt_background (with inverted filter)
    # ZH_HToBB_ZToTT is considered as background
    # ZZ_SL is considered as background

    p = "/eos/grif/cms/llr/store/user/tcuisset/boostedTaus/2018_MC/"
    datasets += ObjectCollection([

        ###################################### ZH Signal ##############################################
        ###############################################################################################

        #### ZH_Htt_Zbb
        Dataset("zh_zbb_htt_signal",
            folder=p + "ZHToTauTau_M125",
            process=self.processes.get("zh_zbb_htt_signal"),
            xs=self.cross_section_dict["zh_zbb_htt_signal"], # genfilter_denominator_weights=True
            categorization_merging={'': 1},
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "nonResOnly", "limited", "genfilter", "zh", "nonResSignal"]),
        
        
        #### ZH_Hbb_Zll
        Dataset("zh_ztt_hbb_signal",
            folder=p + "ZH_Hbb_Zll",
            process=self.processes.get("zh_ztt_hbb_signal"),
            xs=self.cross_section_dict["zh_ztt_hbb_signal"], # genfilter_denominator_weights=True
            categorization_merging={'': 1},
            categorization_batching={"resolved_2b" : 11},
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "nonResOnly", "limited", "genfilter", "zh", "nonResSignal"]),


        ###################################### ZH Background ##########################################
        ###############################################################################################
        ####################### ZHToTauTau_M125
        Dataset("zh_zbb_htt_background", # genfilter ZbbHtt reversed -> background for both resonant and non resonant analyses
            folder=p + "ZHToTauTau_M125",
            process=self.processes.get("zh_zbb_htt_background"),
            xs=self.cross_section_dict["zh_zbb_htt_background"], #genfilter_denominator_weights=True,
            categorization_merging={'boosted_bb_boostedTau': 1, 'boosted_bb_HPSTau': 1, 'resolved_1b_HPSTau': 1, 'resolved_2b_HPSTau': 1},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "limited", "genfilter", "zh"]),

        
        # Z->bb, H->tt considered as background for resonant analysis (genfilter bbtautau)
        # (exact same zh_zbb_htt_signal, you can even symlink the dataset to avoid reprocessing)
        Dataset("zh_zbb_htt",
            folder=p + "ZHToTauTau_M125",
            process=self.processes.get("zh_zbb_htt"),
            xs=self.cross_section_dict["zh_zbb_htt_signal"], # genfilter_denominator_weights=True
            categorization_merging={'': 1},
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "res", "limited", "genfilter", "zh"]),

        
        ####################### ZH_Hbb_Zll
        Dataset("zh_ztt_hbb_background", # genfilter reversed : background for both non-res and res analyses
            folder=p + "ZH_Hbb_Zll",
            process=self.processes.get("zh_ztt_hbb_background"),
            xs=self.cross_section_dict["zh_ztt_hbb_background"], # genfilter_denominator_weights=True
            categorization_merging={'boosted_bb_boostedTau': 1, 'boosted_bb_HPSTau': 1, 'resolved_1b_HPSTau': 1, 'resolved_2b_HPSTau': 1},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "limited", "genfilter", "zh"]),


        # #### ZH_Hbb_Zll : intended as background for ZbbHtt analysis, not used now that we combine ZbbHtt and ZttHbb
        # Dataset("zh_hbb_zll",
        #     folder=p + "ZH_Hbb_Zll",
        #     process=self.processes.get("zh_hbb"),
        #     xs=self.cross_section_dict["zh_hbb_zll"],
        #     secondary_dataset="zh_hbb_zll_aux",
        #     # categorization_max_events=10000,
        #     prefix="eos.grif.fr//",
        #     tags=["ul", "nanoV10"]),

        # Z->tt, H->bb considered as background for resonant analysis (genfilter bbtautau)
        # (exact same zh_zbb_htt_signal, you can even symlink the dataset to avoid reprocessing)
        Dataset("zh_ztt_hbb",
            folder=p + "ZH_Hbb_Zll",
            process=self.processes.get("zh_ztt_hbb_signal"),
            xs=self.cross_section_dict["zh_ztt_hbb_signal"], # genfilter_denominator_weights=True
            categorization_merging={'': 1},
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "res", "limited", "genfilter", "zh"]),



        ###################################### ZZ Background ##########################################
        ###############################################################################################
        # zz_sl_signal but with isSignal=False. Includes only ZZ->bbtautau with genfilter. Used for non-res & res analyses
        Dataset("zz_bbtt",
            folder=p + "ZZTo2Q2L",
            process=self.processes.get("zz_bbtt"),
            xs=self.cross_section_dict["zz_sl_signal"], # genfilter_denominator_weights=True
            categorization_merging={'boosted_bb': 1, 'resolved_1b_HPSTau': 2, 'resolved_2b_HPSTau': 1},
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "zh"]),
        
        #### ZZ_SL, everything not bbtautau, used for all analyses
        Dataset("zz_sl_background",
            folder=p + "ZZTo2Q2L",
            process=self.processes.get("zz_sl_background"),
            xs=self.cross_section_dict["zz_sl"], # genfilter_denominator_weights=False
            #secondary_dataset="zz_sl_background_aux",
            categorization_merging={'boosted_bb_boostedTau': 1, 'boosted_bb_HPSTau': 1, 'resolved_1b_HPSTau': 1, 'resolved_2b_HPSTau': 1},
            prefix="eos.grif.fr//",
            tags=["ul", "nanoV10", "bul", "genfilter"]),


        ###################################### ZH Resonant ############################################
        ###############################################################################################

        #### ZH Resonance high mass
        *(
        Dataset(f"ZprimeToZH_ZToBB_HToTauTau_M{mass}",
            folder=p + f"ZprimeToZH_ZToBB_HToTauTau_M{mass}",
            process=self.processes.get(f"Zprime_Zh_Zbbhtautau_M{mass}"),
            prefix="eos.grif.fr//",
            xs=self.cross_section_dict["ZprimeToZH_ZToBB_HToTauTau"],
            categorization_merging={"boosted_bb_boostedTau": 4 if mass >= 1300 else 2 if mass > 900 else 1, '': 1},
            merging={
                "boosted_bb_boostedTau" : 3 if mass == 3500 else 4 if mass >= 1300 else 2 if mass > 900 else 1 # hack to fix 3500 issue which has only 3 Preprocess inputs.....
            },
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}} if (mass >= 500 and mass <= 900) else {"boosted_bb_boostedTau":{"request_cpus":8}} if mass >=1300 else {},
            tags=["ul", "nanoV10", "bul", "res", "zh", "resSignal"] + (["resExtra"] if mass not in [200, 1000, 2000, 3000, 4000, 5000] else ["resLimited"]))
        
        for mass in resonant_masses_ZH
        ),
        *(
        Dataset(f"ZprimeToZH_ZToTauTau_HToBB_M{mass}",
            folder=p + f"ZprimeToZH_ZToTauTau_HToBB_M{mass}",
            process=self.processes.get(f"Zprime_Zh_Ztautauhbb_M{mass}"),
            prefix="eos.grif.fr//",
            xs=self.cross_section_dict["ZprimeToZH_ZToTauTau_HToBB"],
            categorization_merging={"boosted_bb_boostedTau": 4 if mass >= 1300 else 2 if mass > 900 else 1, '': 1},
            merging={
                "boosted_bb_boostedTau" : 4 if mass >= 1300 else 2 if mass > 900 else 1
            },
            preplot_htcondor_workflow_params={"resolved_2b_HPSTau":{"request_cpus":8}} if (mass >= 500 and mass <= 900) else {"boosted_bb_boostedTau":{"request_cpus":8}} if mass >=1300 else {},
            tags=["ul", "nanoV10", "bul", "res", "zh", "resSignal"] + (["resExtra"] if mass not in [200, 1000, 2000, 3000, 4000, 5000] else ["resLimited"]))
        
        for mass in resonant_masses_ZH
        ),

        ###################################### DNN training private samples ###########################
        ###############################################################################################
        Dataset("zh_zbb_htt_dnnTraining", 
            folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/DNNTrainingSamples/2018/ZbbHtt_v2",
            process=self.processes.get("zh_zbb_htt_dnnTraining"),
            xs=self.cross_section_dict["zh_zbb_htt_signal"], # xs to be verified 
            categorization_merging={'': 1},
            tags=["ul", "nanoV10", "bul", "nonResOnly", "nonDefault", "dnnTraining"]),
        Dataset("zh_zbb_htt_vptFilter_dnnTraining", # ZZ->bbtautau private sample for DNN training
            folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/DNNTrainingSamples/2018/ZbbHtt_v1_VpTGt200",
            process=self.processes.get("zh_zbb_htt_dnnTraining"),
            xs=self.cross_section_dict["zh_zbb_htt_signal"], # xs should be checked
            categorization_merging={'': 1},
            tags=["ul", "nanoV10", "bul", "nonResOnly", "nonDefault", "dnnTraining"]),

        Dataset("zh_ztt_hbb_dnnTraining", 
            folder=["/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/DNNTrainingSamples/2018/ZttHbb_v1", "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/DNNTrainingSamples/2018/ZttHbb_v2"],
            process=self.processes.get("zh_ztt_hbb_dnnTraining"),
            xs=self.cross_section_dict["zh_ztt_hbb_signal"], # xs to be verified 
            categorization_merging={'': 1},
            tags=["ul", "nanoV10", "bul", "nonResOnly", "nonDefault", "dnnTraining"]),
        Dataset("zh_ztt_hbb_vptFilter_dnnTraining", # ZZ->bbtautau private sample for DNN training
            folder="/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/DNNTrainingSamples/2018/ZttHbb_v1_VpTGt200",
            process=self.processes.get("zh_ztt_hbb_dnnTraining"),
            xs=self.cross_section_dict["zh_ztt_hbb_vptFilter"], # xs should be checked
            categorization_merging={'': 1},
            tags=["ul", "nanoV10", "bul", "nonResOnly", "nonDefault", "dnnTraining"]),
    ])

    return datasets