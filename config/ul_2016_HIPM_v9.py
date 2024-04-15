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
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx"),
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=61526.7, # XSDB
        #     tags=["ul"]),

        # Dataset("wjets_FXFX_0j",
        #     dataset="/WJetsToLNu_0J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx_0j"),
        #     xs=52780.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_FXFX_1j",
        #     dataset="/WJetsToLNu_1J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_fxfx_1j"),
        #     xs=8832.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_FXFX_2j",
        #     dataset="/WJetsToLNu_2J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets"),
        #     xs=3276.0/64888.0*61526.7, # CMSDAS
        #     tags=["ul"]),

        Dataset("wjets_MLM",
            dataset="/WJetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            selection="(event != 198018547)", # to remove high weight event
            process=self.processes.get("wjets_mlm"),
            # prefix="xrootd-cms.infn.it//",
            xs=61526.7, # XSDB
            tags=["ul"]),

        # Dataset("wjets_MLM_1j",
        #     dataset="/W1JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_1j"),
        #     xs=9024.0, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_MLM_2j",
        #     dataset="/W2JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_2j"),
        #     xs=2832.0, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_MLM_3j",
        #     dataset="/W3JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_3j"),
        #     xs=820.7, # CMSDAS
        #     tags=["ul"]),
        # Dataset("wjets_MLM_4j",
        #     dataset="/W4JetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("wjets_mlm_4j"),
        #     xs=385.5, # CMSDAS
        #     tags=["ul"]),

        # wjets_ht1_aux is actually not used since we normalize wjets_ht1 with inclusive sample
        # Dataset("wjets_ht1",
        #     dataset="/WJetsToLNu_TuneCP5_13TeV-madgraphMLM-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
        #     process=self.processes.get("wjets_ht1"),
        #     selection="(event != 198018547)", # to remove high weight event
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=61526.7, # 3 * https://twiki.cern.ch/twiki/bin/viewauth/CMS/StandardModelCrossSectionsat13TeV#:~:text=l%CE%BD%2C%20l%3D%CE%BC-,20508.9,-%2B165.7%20%2D88.2%20(%C2%B1%20770.9
        #     setGenWeightToOne=True,    
        #     splitting=200000,
        #     tags=["ul"]),
        Dataset("wjets_ht2",
            dataset="/WJetsToLNu_HT-100To200_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht2"),
            xs=1244.0, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht3",
            dataset="/WJetsToLNu_HT-200To400_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht3"),
            xs=337.8, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht4",
            dataset="/WJetsToLNu_HT-400To600_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht4"),
            xs=44.93, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht5",
            dataset="/WJetsToLNu_HT-600To800_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht5"),
            xs=11.19, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht6",
            dataset="/WJetsToLNu_HT-800To1200_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht6"),
            xs=4.926, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht7",
            dataset="/WJetsToLNu_HT-1200To2500_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wjets_ht7"),
            xs=1.152, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),
        Dataset("wjets_ht8",
            dataset="/WJetsToLNu_HT-2500ToInf_TuneCP5_13TeV-madgraphMLM-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("wjets_ht8"),
            xs=0.02646, # XSDB
            setGenWeightToOne=True,
            tags=["ul"]),

        # DY
        Dataset("dy",
            dataset="/DYJetsToLL_M-50_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_incl"),
            # prefix="xrootd-cms.infn.it//",
            # prefix="cms-xrd-global.cern.ch//",
            xs=6424.0, # XSDB
            merging={
                "tautau": 20,
                "etau": 20,
                "mutau": 20,
            },
            tags=["ul"]),

        Dataset("dy_ptz1",
            dataset="/DYJetsToLL_LHEFilterPtZ-0To50_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz1"),
            xs=1485.0, # XSDB
            tags=["ul"]),
        Dataset("dy_ptz2",
            dataset="/DYJetsToLL_LHEFilterPtZ-50To100_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz2"),
            xs=397.4, # XSDB
            tags=["ul"]),
        Dataset("dy_ptz3",
            dataset="/DYJetsToLL_LHEFilterPtZ-100To250_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz3"),
            xs=97.2, # XSDB
            tags=["ul"]),
        Dataset("dy_ptz4",
            dataset="/DYJetsToLL_LHEFilterPtZ-250To400_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz4"),
            xs=3.701, # XSDB
            tags=["ul"]),
        Dataset("dy_ptz5",
            dataset="/DYJetsToLL_LHEFilterPtZ-400To650_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz5"),
            xs=0.5086, # XSDB
            tags=["ul"]),
        Dataset("dy_ptz6",
            dataset="/DYJetsToLL_LHEFilterPtZ-650ToInf_MatchEWPDG20_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_ptz6"),
            xs=0.040981055, # XSDB
            tags=["ul"]),

        Dataset("dy_0j",
            dataset="/DYJetsToLL_0J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_0j"),
            xs=5090.0, # XSDB
            tags=["ul"]),
        Dataset("dy_1j",
            dataset="/DYJetsToLL_1J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_1j"),
            xs=983.5, # XSDB
            tags=["ul"]),
        Dataset("dy_2j",
            dataset="/DYJetsToLL_2J_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("dy_2j"),
            xs=353.6, # XSDB
            tags=["ul"]),

        # EWK
        Dataset("ewk_z",
            dataset="/EWKZ2Jets_ZToLL_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ewk_z"),
            # prefix="xrootd-cms.infn.it//",
            xs=6.215, # XSDB NLO
            splitting=200000,
            tags=["ul"]),
        Dataset("ewk_wplus",
            dataset="/EWKWPlus2Jets_WToLNu_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ewk_wplus"),
            # prefix="xrootd-cms.infn.it//",
            xs=39.05, # XSDB NLO
            splitting=200000,
            tags=["ul"]),
        Dataset("ewk_wminus",
            dataset="/EWKWMinus2Jets_WToLNu_M-50_TuneCP5_withDipoleRecoil_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ewk_wminus"),
            # prefix="xrootd-cms.infn.it//",
            xs=32.05, # XSDB NLO
            splitting=200000,
            tags=["ul"]),

        ######################################## Top ##################################################
        ###############################################################################################

        # TT
        Dataset("tt_dl",
            dataset="/TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("tt_dl"),
            # prefix="xrootd-cms.infn.it//",
            xs=88.29, # XSDB NNLO
            merging={
                "tautau": 20,
                "mutau": 20,
                "etau": 40,
            },
            scaling=(0.908, 0.006),
            tags=["ul"]),
        Dataset("tt_sl",
            dataset="/TTToSemiLeptonic_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("tt_sl"),
            # prefix="xrootd-cms.infn.it//",
            xs=365.34, # XSDB NNLO
            merging={
                "tautau": 20,
                "mutau": 60,
                "etau": 40,
            },
            scaling=(0.908, 0.006),
            tags=["ul"]),
        Dataset("tt_fh",
            dataset="/TTToHadronic_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("tt_fh"),
            # prefix="xrootd-cms.infn.it//",
            xs=377.96, # XSDB NNLO
            scaling=(0.908, 0.006),
            tags=["ul"]),

        # TW
        Dataset("st_tw_antitop",
            dataset="/ST_tW_antitop_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("tw"),
            # prefix="xrootd-cms.infn.it//",
            xs=35.85, # 0.5 * https://twiki.cern.ch/twiki/bin/view/LHCPhysics/SingleTopRefXsec#:~:text=a2-,71.7,-%2B1.326
            splitting=200000,
            tags=["ul"]),
        Dataset("st_tw_top",
            dataset="/ST_tW_top_5f_inclusiveDecays_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("tw"),
            # prefix="xrootd-cms.infn.it//",
            xs=35.85, # 0.5 * https://twiki.cern.ch/twiki/bin/view/LHCPhysics/SingleTopRefXsec#:~:text=a2-,71.7,-%2B1.326
            splitting=200000,
            tags=["ul"]),

        # singleT
        Dataset("st_antitop",
            dataset="/ST_t-channel_antitop_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("singlet"),
            # prefix="xrootd-cms.infn.it//",
            xs=80.95, # https://twiki.cern.ch/twiki/bin/view/LHCPhysics/SingleTopRefXsec#:~:text=anti%2Dtop-,80.95,-%2B2.53%20%2D1.71
            splitting=200000,
            tags=["ul"]),
        Dataset("st_top",
            dataset="/ST_t-channel_top_4f_InclusiveDecays_TuneCP5_13TeV-powheg-madspin-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("singlet"),
            # prefix="xrootd-cms.infn.it//",
            xs=136.02, # https://twiki.cern.ch/twiki/bin/view/LHCPhysics/SingleTopRefXsec#:~:text=top-,136.02,-%2B4.09%20%2D2.92
            splitting=200000,
            tags=["ul"]),

        ######################################## Di- and Tri-boson ####################################
        ###############################################################################################

        # VV
        Dataset("zz_dl",
            dataset="/ZZTo4L_TuneCP5_13TeV_powheg_pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            # prefix="xrootd-cms.infn.it//",
            xs=1.26, # AN 
            # xs=1.325, # XSDB NLO
            # xs=1.212, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#W_jets:~:text=SMP%2DRunIISpring15DR74%2D00026-,1.212,-NLO%2C%20up%20to
            # xs=1.204, # https://xsdb-temp.app.cern.ch/?searchQuery=DAS=ZZTo4L_13TeV-amcatnloFXFX-pythia8
            # xs=1.2564, # 9 * 4 * https://twiki.cern.ch/twiki/bin/viewauth/CMS/StandardModelCrossSectionsat13TeV#:~:text=%CE%BC%CE%BC%20Z%20%E2%86%92%20ee-,0.0349,-%C2%B1%200.0011%20(%C2%B1%200.0016)
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_fh",
            dataset="/ZZTo4Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            # prefix="xrootd-cms.infn.it//",
            xs=3.262, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_lnu",
            dataset="/ZZTo2L2Nu_TuneCP5_13TeV_powheg_pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.564, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=XXX-,0.564,-NLO
            # xs=0.6008, # XSDB
            splitting=200000,
            tags=["ul"]),
        Dataset("zz_qnu",
            dataset="/ZZTo2Nu2Q_5f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("zz"),
            # prefix="xrootd-cms.infn.it//",
            xs=4.07, # AN
            # xs=4.04, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15wmLHE%2D00099-,4.04,-NLO%2C%20up%20to
            # xs=4.033, # XSDB unknown
            # splitting=200000,
            tags=["ul"]),
        Dataset("wz_lllnu",
            dataset="/WZTo3LNu_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wz"),
            # prefix="xrootd-cms.infn.it//",
            xs=4.43, # AN
            # xs=5.26, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SMP%2DRunIISpring15DR74%2D00024-,5.26,-NLO%2C%20up%20to
            # xs=5.052, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_lnuqq",
            dataset="/WZTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wz"),
            # prefix="xrootd-cms.infn.it//",
            xs=10.71, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIISpring15DR74%2D00155-,10.71,-NLO%2C%20up%20to
            # xs=9.119, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_lnununu",
            dataset="/WZTo1L3Nu_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wz"),
            # prefix="xrootd-cms.infn.it//",
            xs=3.414, # XSDB unknown
            # xs=3.033, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIISpring15MiniAODv2%2D00044-,3.033e,-%2B00%20%2B%2D%202.060e%2D02
            splitting=200000,
            tags=["ul"]),
        Dataset("wz_llqq",
            dataset="/WZTo2Q2L_mllmin4p0_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("wz"),
            # prefix="xrootd-cms.infn.it//",
            xs=5.595, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIIWinter15wmLHE%2D00095-,5.595,-NLO%2C%20up%20to
            # xs=6.565, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_llnunu",
            dataset="/WWTo2L2Nu_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ww"),
            # prefix="xrootd-cms.infn.it//",
            xs=12.178, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIISpring15DR74%2D00113-,12.178,-NNLO
            # xs=10.48, # XSDB NLO
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_lnuqq",
            dataset="/WWTo1L1Nu2Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ww"),
            # prefix="xrootd-cms.infn.it//",
            xs=49.997, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIISpring15DR74%2D00169-,49.997,-NNLO
            # xs=51.65, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ww_qqqq",
            dataset="/WWTo4Q_4f_TuneCP5_13TeV-amcatnloFXFX-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v3/NANOAODSIM",
            process=self.processes.get("ww"),
            # prefix="xrootd-cms.infn.it//",
            xs=51.723, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=HIG%2DRunIISpring15DR74%2D00114-,51.723,-NNLO
            # xs=51.03, # XSDB unknown
            splitting=200000,
            tags=["ul"]),

        # VVV
        Dataset("zzz",
            dataset="/ZZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("zzz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.0147, # AN
            # xs=0.01398, # XSDB unknown and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIIWinter15wmLHE%2D00058-,0.01398,-pb
            splitting=200000,
            tags=["ul"]),
        Dataset("wzz",
            dataset="/WZZ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wzz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.057, # AN
            # xs=0.05565, # XSDB unknown and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=NLO-,WZZ,-/WZZ_TuneCUETP8M1_13TeV%2Damcatnlo%2Dpythia8
            splitting=200000,
            tags=["ul"]),
        Dataset("www",
            dataset="/WWW_4F_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("www"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.209, # AN
            # xs=0.2086, # XSDB unknown and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIISummer15GS%2D00151-,0.2086,-pb
            splitting=200000,
            tags=["ul"]),
        Dataset("wwz",
            dataset="/WWZ_4F_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("wwz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.168, # AN
            # xs=0.1651, # XSDB unknown and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIIWinter15wmLHE%2D00059-,0.1651,-pb
            splitting=200000,
            tags=["ul"]),

        ######################################## Others ###############################################
        ###############################################################################################

        # TTX
        Dataset("ttw_lnu",
            dataset="/TTWJetsToLNu_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("ttw"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.2043, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIISpring15DR74%2D00048-,0.2043,-%C2%B1%200.0020
            # xs=0.2149, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ttw_qq",
            dataset="/TTWJetsToQQ_TuneCP5_13TeV-amcatnloFXFX-madspin-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("ttw"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.4062, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIISpring15DR74%2D00068-,0.4062,-%C2%B1%200.0021
            # xs=0.4316, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ttww",
            dataset="/TTWW_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ttww"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.00698, # AN
            # xs=0.006979, # XSDB LO
            splitting=200000,
            tags=["ul"]),
        Dataset("ttwz",
            dataset="/TTWZ_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ttwz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.002441, # AN and XSDB LO
            splitting=200000,
            tags=["ul"]),
        Dataset("ttwh",
            dataset="/TTWH_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("ttwh"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.00158, # AN
            # xs=0.001141, # XSDB LO
            splitting=200000,
            tags=["ul"]),
        Dataset("ttzh",
            dataset="/TTZH_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("ttzh"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.00154, # AN
            # xs=0.00113, # XSDB LO
            splitting=200000,
            tags=["ul"]),
        Dataset("ttz_llnunu",
            dataset="/TTZToLLNuNu_M-10_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ttz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.2529, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=27%25%20neg%20weights)-,TTZ(llnunu),-/TTZToLLNuNu_M%2D10_TuneCUETP8M1_13TeV%2Damcatnlo
            # xs=0.2432, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ttz_qq",
            dataset="/TTZToQQ_TuneCP5_13TeV-amcatnlo-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ttz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.5297, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=SUS%2DRunIISpring15DR74%2D00037-,0.5297,-%C2%B1%200.0008
            # xs=0.5104, # XSDB unknown
            splitting=200000,
            tags=["ul"]),
        Dataset("ttzz",
            dataset="/TTZZ_TuneCP5_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ttzz"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.001386, # AN and XSDB LO
            splitting=200000,
            tags=["ul"]),

        ######################################## Higgs ###############################################
        ###############################################################################################      
        
        ## ZH_HToBB_ZToLL and ZHToTauTau are in ZZ and ZH specific configurations
        
        # ZH_hbb : does not work from CMSDAS for some reason
        # Dataset("zh_hbb_zqq",
        #     dataset="/ZH_HToBB_ZToQQ_M-125_TuneCP5_13TeV-powheg-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
        #     process=self.processes.get("zh_hbb"),
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=0.36, # AN
        #     # xs=0.5612, # XSDB NLO
        #     splitting=200000,
        #     tags=["ul"]),

        # WH_htt
        Dataset("wminush_htt",
            dataset="/WminusHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("wh_htt"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.0334, # AN
            # xs=0.5412, # XSDB NLO
            splitting=200000,
            tags=["ul"]),
        Dataset("wplush_htt",
            dataset="/WplusHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("wh_htt"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.05268, # AN
            # xs=0.867, # XSDB NLO
            splitting=200000,
            tags=["ul"]),

        # vbf_htt (not in the datacard)
        # Dataset("vbf_htt", # (removed cause it takes very long and it's not in the datacard for HHbbtt) 
        #     dataset="/VBFHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("vbf_htt"),
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=0.237, # AN
        #     # xs=3.861, # XSDB NLO
        #     # xs=3.748, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#Diboson:~:text=1478412-,3.748,-x%200.0632
        #     splitting=200000,
        #     tags=["ul"]),

        # ttH_hbb
        Dataset("tth_bb",
            dataset="/ttHTobb_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("tth_bb"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.2953, # AN and https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#ttH:~:text=pb%20*%205.77E%2D01%20%3D-,0.2934,-pb
            # xs=0.5269, # XSDB NLO
            splitting=200000,
            tags=["ul"]),
        Dataset("tth_tautau",
            dataset="/ttHToTauTau_M125_TuneCP5_13TeV-powheg-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
            process=self.processes.get("tth_tautau"),
            # prefix="xrootd-cms.infn.it//",
            xs=0.031805, # AN
            # xs=0.5269, # XSDB NLO
            # xs=0.0321, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#ttH:~:text=pb%20*%206.32E%2D02%20%3D-,0.0321,-pb
            splitting=200000,
            tags=["ul"]),
        # Dataset("tth_nonbb", # (removed cause it takes very long and it's not in the datacard for HHbbtt) 
        #     dataset="/ttHToNonbb_M125_TuneCP5_13TeV-powheg-pythia8/"
        #         "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v2/NANOAODSIM",
        #     process=self.processes.get("tth_nonbb"),
        #     # prefix="xrootd-cms.infn.it//",
        #     xs=0.17996, # AN
        #     # xs=0.5638, # XSDB NLO
        #     # xs=0.2151, # https://twiki.cern.ch/twiki/bin/view/CMS/SummaryTable1G25ns#ttH:~:text=1%20%2D%205.77E%2D01)%20%3D-,0.2151,-pb
        #     splitting=200000,
        #     tags=["ul"]),

        # ggH_ZZ 
        Dataset("ggH_ZZ",
            dataset="/GluGluHToZZTo2L2Q_M125_TuneCP5_13TeV_powheg2_JHUGenV7011_pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ggH_ZZ"),
            # prefix="xrootd-cms.infn.it//",
            xs=28.87, # XSDB NLO
            splitting=200000,
            tags=["ul"]),

        ######################################## HH bbtautau ##########################################
        ###############################################################################################

        # ggf 
        Dataset("ggf_sm",
            dataset="/GluGluToHHTo2B2Tau_TuneCP5_PSWeights_node_SM_13TeV-madgraph-pythia8/"
                "RunIISummer20UL16NanoAODAPVv9-106X_mcRun2_asymptotic_preVFP_v11-v1/NANOAODSIM",
            process=self.processes.get("ggf_sm"),
            xs=0.002268, # KLUB
            # xs=0.01313, # XSDB LO
            tags=["ul"]),

        ######################################## Data #################################################
        ###############################################################################################

        Dataset("data_tau_a",
            dataset="/Tau/Run2016B-ver2_HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="B",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_b",
            dataset="/Tau/Run2016C-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="C",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_c",
            dataset="/Tau/Run2016D-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="D",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_d",
            dataset="/Tau/Run2016E-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="E",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),
        Dataset("data_tau_e",
            dataset="/Tau/Run2016F-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 2",
            process=self.processes.get("data_tau"),
            runEra="F",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "tautau": 20,
            },
            tags=["ul"]),

        # SingleElectron 2016 HIPM
        Dataset("data_etau_a",
            dataset="/SingleElectron/Run2016B-ver2_HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="B",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_b",
            dataset="/SingleElectron/Run2016C-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="C",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_c",
            dataset="/SingleElectron/Run2016D-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="D",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_d",
            dataset="/SingleElectron/Run2016E-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="E",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),
        Dataset("data_etau_e",
            dataset="/SingleElectron/Run2016F-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 1",
            process=self.processes.get("data_etau"),
            runEra="F",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "etau": 10,
            },
            tags=["ul"]),

        # SingleMuon 2016 HIPM
        Dataset("data_mutau_a",
            dataset="/SingleMuon/Run2016B-ver2_HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            selection="pairType == 0",
            process=self.processes.get("data_mutau"),
            runEra="B",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_b",
            dataset="/SingleMuon/Run2016C-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="C",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_c",
            dataset="/SingleMuon/Run2016D-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="D",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_d",
            dataset="/SingleMuon/Run2016E-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="E",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),
        Dataset("data_mutau_e",
            dataset="/SingleMuon/Run2016F-HIPM_UL2016_MiniAODv2_NanoAODv9-v2/NANOAOD",
            process=self.processes.get("data_mutau"),
            selection="pairType == 0",
            runEra="F",
            # prefix="xrootd-cms.infn.it//",
            splitting=-1,
            merging={
                "mutau": 20,
            },
            tags=["ul"]),

    ]
    
    return ObjectCollection(datasets)

