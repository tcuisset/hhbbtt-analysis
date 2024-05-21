# weights and datasets common to zz and zh analyses, NanoAOD v9

from analysis_tools import ObjectCollection, Category, Process, Dataset, Feature, Systematic
from analysis_tools.utils import DotDict

def get_common_datasets_v9(self):
    datasets = [
        
        ######################################## Single boson #########################################
        ###############################################################################################

        # W
        # Dataset("wjets_FXFX",
        #     dataset="/WJetsToLNu_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx"),
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=61526.7, # XSDB
        #     tags=["ul"]),

        # Dataset("wjets_FXFX_0j",
        #     dataset="/WJetsToLNu_0J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx_0j"),
        #     xs=52780.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_FXFX_1j",
        #     dataset="/WJetsToLNu_1J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx_1j"),
        #     xs=8832.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_FXFX_2j",
        #     dataset="/WJetsToLNu_2J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets"),
        #     xs=3276.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),

        Dataset("wjets_MLM",
            dataset="/WJetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_mlm"),
            xs=self.cross_section_dict["wjets_MLM"],
            setGenWeightToOne=True,
            tags=["ul"]),

        # Dataset("wjets_MLM_1j",
        #     dataset="/W1JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_1j"),
        #     xs=self.cross_section_dict["wjets_MLM_1j"],
        #     tags=["ul"]),
        # Dataset("wjets_MLM_2j",
        #     dataset="/W2JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_2j"),
        #     xs=self.cross_section_dict["wjets_MLM_2j"],
        #     tags=["ul"]),
        # Dataset("wjets_MLM_3j",
        #     dataset="/W3JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_3j"),
        #     xs=self.cross_section_dict["wjets_MLM_3j"],
        #     tags=["ul"]),
        # Dataset("wjets_MLM_4j",
        #     dataset="/W4JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_4j"),
        #     xs=self.cross_section_dict["wjets_MLM_4j"],
        #     tags=["ul"]),

        # wjets_ht1_aux is actually not used since we normalize wjets_ht1 with inclusive sample
        # Dataset("wjets_ht1",
        #     dataset="/WJetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_ht1"),
        #     #selection="(LHE_HT < 100)",
        #     xs=self.cross_section_dict["wjets_MLM"],
        #     setGenWeightToOne=True,
        #     splitting=200000,
        #     tags=["ul"]),
        Dataset("wjets_ht2",
            dataset="/WJetsToLNu_HT-100To200_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht2"),
            xs=self.cross_section_dict["wjets_ht2"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht3",
            dataset="/WJetsToLNu_HT-200To400_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht3"),
            xs=self.cross_section_dict["wjets_ht3"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht4",
            dataset="/WJetsToLNu_HT-400To600_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht4"),
            xs=self.cross_section_dict["wjets_ht4"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht5",
            dataset="/WJetsToLNu_HT-600To800_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht5"),
            xs=self.cross_section_dict["wjets_ht5"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht6",
            dataset="/WJetsToLNu_HT-800To1200_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v3/NANOAODSIM",
            process=self.processes.get("wjets_ht6"),
            xs=self.cross_section_dict["wjets_ht6"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht7",
            dataset="/WJetsToLNu_HT-1200To2500_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht7"),
            xs=self.cross_section_dict["wjets_ht7"],
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht8",
            dataset="/WJetsToLNu_HT-2500ToInf_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("wjets_ht8"),
            xs=self.cross_section_dict["wjets_ht8"],
            setGenWeightToOne=True,
            tags=["ul"]),

        # DY
        Dataset("dy",
            dataset="/DYJetsToLL_M-50_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("dy_incl"),
            xs=self.cross_section_dict["dy"],
            merging={
                "tautau": 20,
                "etau": 20,
                "mutau": 20,
            },
            tags=["ul"]),

        Dataset("dy_ptz1",
            dataset="/DYJetsToLL_LHEFilterPtZ-0To50_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz1"),
            xs=self.cross_section_dict["dy_ptz1"],
            tags=["ul"]),
        Dataset("dy_ptz2",
            dataset="/DYJetsToLL_LHEFilterPtZ-50To100_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz2"),
            xs=self.cross_section_dict["dy_ptz2"],
            tags=["ul"]),
        Dataset("dy_ptz3",
            dataset="/DYJetsToLL_LHEFilterPtZ-100To250_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz3"),
            xs=self.cross_section_dict["dy_ptz3"],
            tags=["ul"]),
        Dataset("dy_ptz4",
            dataset="/DYJetsToLL_LHEFilterPtZ-250To400_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz4"),
            xs=self.cross_section_dict["dy_ptz4"],
            tags=["ul"]),
        Dataset("dy_ptz5",
            dataset="/DYJetsToLL_LHEFilterPtZ-400To650_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz5"),
            xs=self.cross_section_dict["dy_ptz5"],
            tags=["ul"]),
        Dataset("dy_ptz6",
            dataset="/DYJetsToLL_LHEFilterPtZ-650ToInf_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz6"),
            xs=self.cross_section_dict["dy_ptz6"],
            tags=["ul"]),

        Dataset("dy_0j",
            dataset="/DYJetsToLL_0J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_0j"),
            xs=self.cross_section_dict["dy_0j"],
            tags=["ul"]),
        Dataset("dy_1j",
            dataset="/DYJetsToLL_1J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_1j"),
            xs=self.cross_section_dict["dy_1j"],
            tags=["ul"]),
        Dataset("dy_2j",
            dataset="/DYJetsToLL_2J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("dy_2j"),
            xs=self.cross_section_dict["dy_2j"],
            tags=["ul"]),

        # EWK
        Dataset("ewk_z",
            dataset="/EWKZ2Jets_ZToLL_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ewk_z"),
            xs=self.cross_section_dict["ewk_z"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ewk_wplus",
            dataset="/EWKWPlus2Jets_WToLNu_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ewk_wplus"),
            xs=self.cross_section_dict["ewk_wplus"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ewk_wminus",
            dataset="/EWKWMinus2Jets_WToLNu_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ewk_wminus"),
            xs=self.cross_section_dict["ewk_wminus"],
            splitting=200000,
            tags=["ul"]),

        ######################################## Top ##################################################
        ###############################################################################################

        # TT
        Dataset("tt_dl",
            dataset="/TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("tt_dl"),
            xs=self.cross_section_dict["tt_dl"],
            merging={
                "tautau": 20,
                "mutau": 20,
                "etau": 40,
            },
            scaling=(0.988, 0.006),
            tags=["ul"]),
        Dataset("tt_sl",
            dataset="/TTToSemiLeptonic_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("tt_sl"),
            xs=self.cross_section_dict["tt_sl"],
            merging={
                "tautau": 20,
                "mutau": 60,
                "etau": 40,
            },
            scaling=(0.988, 0.006),
            tags=["ul"]),
        Dataset("tt_fh",
            dataset="/TTToHadronic_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("tt_fh"),
            xs=self.cross_section_dict["tt_fh"],
            scaling=(0.988, 0.006),
            tags=["ul"]),

        # TW
        Dataset("st_tw_antitop",
            dataset="/ST_tW_antitop_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("tw"),
            xs=self.cross_section_dict["st_tw_antitop"],
            splitting=200000,
            tags=["ul"]),
        Dataset("st_tw_top",
            dataset="/ST_tW_top_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("tw"),
            xs=self.cross_section_dict["st_tw_top"],
            splitting=200000,
            tags=["ul"]),

        # singleT
        Dataset("st_antitop",
            dataset="/ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("singlet"),
            xs=self.cross_section_dict["st_antitop"],
            splitting=200000,
            tags=["ul"]),
        Dataset("st_top",
            dataset="/ST_t-channel_top_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("singlet"),
            xs=self.cross_section_dict["st_top"],
            splitting=200000,
            tags=["ul"]),

        ######################################## Di- and Tri-boson ####################################
        ###############################################################################################

        # VV
        Dataset("zz_dl",
            dataset="/ZZTo4L_TuneCP5_13TeV_powheg_pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("zz"),
            xs=self.cross_section_dict["zz_dl"],
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_fh",
            dataset="/ZZTo4Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            xs=self.cross_section_dict["zz_fh"],
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_lnu",
            dataset="/ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            xs=self.cross_section_dict["zz_lnu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_qnu",
            dataset="/ZZTo2Nu2Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            xs=self.cross_section_dict["zz_qnu"],
            tags=["ul"]),
        Dataset("wz_lllnu",
            dataset="/WZTo3LNu_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("wz"),
            xs=self.cross_section_dict["wz_lllnu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_lnuqq",
            dataset="/WZTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wz"),
            xs=self.cross_section_dict["wz_lnuqq"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_lnununu",
            dataset="/WZTo1L3Nu_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wz"),
            xs=self.cross_section_dict["wz_lnununu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_llqq",
            dataset="/WZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("wz"),
            xs=self.cross_section_dict["wz_llqq"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_llnunu",
            dataset="/WWTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ww"),
            xs=self.cross_section_dict["ww_llnunu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_lnuqq",
            dataset="/WWTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ww"),
            xs=self.cross_section_dict["ww_lnuqq"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_qqqq",
            dataset="/WWTo4Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ww"),
            xs=self.cross_section_dict["ww_qqqq"],
            splitting=200000,
            tags=["ul"]),

        # VVV
        Dataset("zzz",
            dataset="/ZZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("zzz"),
            xs=self.cross_section_dict["zzz"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wzz",
            dataset="/WZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wzz"),
            xs=self.cross_section_dict["wzz"],
            splitting=200000,
            tags=["ul"]),
        Dataset("www",
            dataset="/WWW_4F_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("www"),
            xs=self.cross_section_dict["www"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wwz",
            dataset="/WWZ_4F_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wwz"),
            xs=self.cross_section_dict["wwz"],
            splitting=200000,
            tags=["ul"]),

        ######################################## Others ###############################################
        ###############################################################################################

        # TTX
        Dataset("ttw_lnu",
            dataset="/TTWJetsToLNu_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttw"),
            xs=self.cross_section_dict["ttw_lnu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttw_qq",
            dataset="/TTWJetsToQQ_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttw"),
            xs=self.cross_section_dict["ttw_qq"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttww",
            dataset="/TTWW_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttww"),
            xs=self.cross_section_dict["ttww"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttwz",
            dataset="/TTWZ_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttwz"),
            xs=self.cross_section_dict["ttwz"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttwh",
            dataset="/TTWH_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ttwh"),
            xs=self.cross_section_dict["ttwh"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttzh",
            dataset="/TTZH_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ttzh"),
            xs=self.cross_section_dict["ttzh"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttz_llnunu",
            dataset="/TTZToLLNuNu_M-10_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttz"),
            xs=self.cross_section_dict["ttz_llnunu"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttz_qq",
            dataset="/TTZToQQ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttz"),
            xs=self.cross_section_dict["ttz_qq"],
            splitting=200000,
            tags=["ul"]),
        Dataset("ttzz",
            dataset="/TTZZ_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ttzz"),
            xs=self.cross_section_dict["ttzz"],
            splitting=200000,
            tags=["ul"]),

        ######################################## Higgs ###############################################
        ###############################################################################################      
        
        ## ZH_HToBB_ZToLL and ZHToTauTau are in ZZ and ZH specific configurations
        
        # ZH_hbb : does not work from CMSDAS for some reason
        # Dataset("zh_hbb_zqq",
        #     dataset="/ZH_HToBB_ZToQQ_M-125_TuneCP5_13TeV-powheg-pythia8/"
        #     "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("zh_hbb"),
        #     xs=self.cross_section_dict["zh_hbb_zqq"],
        #     splitting=200000,
        #     tags=["ul"]),

        # WH_htt
        Dataset("wminush_htt",
            dataset="/WminusHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wh_htt"),
            xs=self.cross_section_dict["wminush_htt"],
            splitting=200000,
            tags=["ul"]),
        Dataset("wplush_htt",
            dataset="/WplusHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("wh_htt"),
            xs=self.cross_section_dict["wplush_htt"],
            splitting=200000,
            tags=["ul"]),

        # vbf_htt (not in the datacard)
        # Dataset("vbf_htt", # (removed cause it takes very long and it's not in the datacard for HHbbtt) 
        #     dataset="/VBFHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
        #     process=self.processes.get("vbf_htt"),
        #     xs=self.cross_section_dict["vbf_htt"],
        #     splitting=200000,
        #     tags=["ul"]),

        # ttH_hbb
        Dataset("tth_bb",
            dataset="/ttHTobb_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("tth_bb"),
            xs=self.cross_section_dict["tth_bb"],
            splitting=200000,
            tags=["ul"]),
        Dataset("tth_tautau",
            dataset="/ttHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("tth_tautau"),
            xs=self.cross_section_dict["tth_tautau"],
            splitting=200000,
            tags=["ul"]),
        # Dataset("tth_nonbb", # (removed cause it takes very long and it's not in the datacard for HHbbtt) 
        #     dataset="/ttHToNonbb_M125_TuneCP5_13TeV-powheg-pythia8/"
        #         "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
        #     process=self.processes.get("tth_nonbb"),
        #     xs=self.cross_section_dict["tth_nonbb"],
        #     splitting=200000,
        #     tags=["ul"]),

        # ggH_ZZ 
        Dataset("ggH_ZZ",
            dataset="/GluGluHToZZTo2L2Q_M125_TuneCP5_13TeV_powheg2_JHUGenV7011_pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v2/NANOAODSIM",
            process=self.processes.get("ggH_ZZ"),
            xs=self.cross_section_dict["ggH_ZZ"],
            splitting=200000,
            tags=["ul"]),

        ######################################## HH bbtautau ##########################################
        ###############################################################################################

        # ggf 
        Dataset("ggf_sm",
            dataset="/GluGluToHHTo2B2Tau_TuneCP5_PSWeights_node_SM_13TeV-madgraph-pythia8/"
                "RunIISummer20UL17NanoAODv9-106X_mc2017_realistic_v9-v1/NANOAODSIM",
            process=self.processes.get("ggf_sm"),
            xs=self.cross_section_dict["ggf_sm"],
            tags=["ul"]),

        ######################################## Data #################################################
        ###############################################################################################

        # Tau 2017
        Dataset("data_tau_a",
            dataset="/Tau/Run2017B-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="B",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_b",
            dataset="/Tau/Run2017C-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="C",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_c",
            dataset="/Tau/Run2017D-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="D",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_d",
            dataset="/Tau/Run2017E-UL2017_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="E",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_e",
            dataset="/Tau/Run2017F-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="F",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),

        # SingleElectron 2017
        Dataset("data_etau_a",
            dataset="/SingleElectron/Run2017B-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="B",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_b",
            dataset="/SingleElectron/Run2017C-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="C",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_c",
            dataset="/SingleElectron/Run2017D-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="D",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_d",
            dataset="/SingleElectron/Run2017E-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="E",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_e",
            dataset="/SingleElectron/Run2017F-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="F",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),

        # SingleMuon 2017
        Dataset("data_mutau_a",
            dataset="/SingleMuon/Run2017B-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            selection="pairType == 0",
            process=self.processes.get("data_mutau"),
            runEra="B",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_b",
            dataset="/SingleMuon/Run2017C-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="C",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_c",
            dataset="/SingleMuon/Run2017D-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="D",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_d",
            dataset="/SingleMuon/Run2017E-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="E",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_e",
            dataset="/SingleMuon/Run2017F-UL2017_MiniAODv2_NanoAODv9-v1/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="F",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),

    ]
    return ObjectCollection(datasets)

