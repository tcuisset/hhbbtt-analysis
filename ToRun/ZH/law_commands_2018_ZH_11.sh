# New preprocess June

# Caveats / TODO
# - find a way to plot ZttHbb signal in ZbbHtt region (also how to trigger preplot for it ?)


YEAR=2018
source setup.sh
# New ZH combination datasets
DATASETS_ZH_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top

DATASETS_ZH_nonres=zh_zbb_htt_signal,zh_ztt_hbb_signal,$DATASETS_ZH_base

# removed 4500 5000 5500 6000
RESONANT_MASSES="500 600 700 800 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000"
# TODO figure out what masses we want to use
DATASETS_ZbbHtt_res_only=ZprimeToZH_ZToBB_HToTauTau_M500,ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M700,ZprimeToZH_ZToBB_HToTauTau_M800,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M1200,ZprimeToZH_ZToBB_HToTauTau_M1400,ZprimeToZH_ZToBB_HToTauTau_M1600,ZprimeToZH_ZToBB_HToTauTau_M1800,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M2500,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M3500,ZprimeToZH_ZToBB_HToTauTau_M4000
DATASETS_ZttHbb_res_only=ZprimeToZH_ZToTauTau_HToBB_M500,ZprimeToZH_ZToTauTau_HToBB_M600,ZprimeToZH_ZToTauTau_HToBB_M700,ZprimeToZH_ZToTauTau_HToBB_M800,ZprimeToZH_ZToTauTau_HToBB_M1000,ZprimeToZH_ZToTauTau_HToBB_M1200,ZprimeToZH_ZToTauTau_HToBB_M1400,ZprimeToZH_ZToTauTau_HToBB_M1600,ZprimeToZH_ZToTauTau_HToBB_M1800,ZprimeToZH_ZToTauTau_HToBB_M2000,ZprimeToZH_ZToTauTau_HToBB_M2500,ZprimeToZH_ZToTauTau_HToBB_M3000,ZprimeToZH_ZToTauTau_HToBB_M3500,ZprimeToZH_ZToTauTau_HToBB_M4000

DATASETS_ZH_res=$DATASETS_ZbbHtt_res_only,$DATASETS_ZttHbb_res_only,$DATASETS_ZH_base,zh_zbb_htt,zh_ztt_hbb


# put all possible data_*_*, in case it does not exist for a year it just gets ignored
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e 
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e

# TODO remember to add missing DNN mass points 500,700, dnn_ZHbbtt_kl_1_1600,dnn_ZHbbtt_kl_1_1800,dnn_ZHbbtt_kl_1_2500
ALL_FEATURES_ZbbHtt=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_500,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_700,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_1600,dnn_ZHbbtt_kl_1_1800,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_2500,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt


ALL_FEATURES_ZttHbb=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_500,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_700,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_1600,dnn_ZHbbtt_kl_1_1800,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_2500,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Hbb_pt,Hbb_eta,Hbb_phi,Hbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt


# prod_240709 : first run with signal and systs
law run PreprocessRDFWrapper --version prod_240709 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --systematic-names ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,priority=5' --workers 50

# 
# pilot ( --systematic-names ele_scale )
law run Categorization --version prod_240709 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-name ZprimeToZH_ZToBB_HToTauTau_M600 \
  --Categorization-feature-modules-file modulesrdf_cat\
   --branch 0 --workers 1

# --JoinDNNInference-workflow htcondor --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --JoinDNNInference-retries 1 --JoinDNNInference-poll-interval 3 --JoinDNNInference-tasks-per-job 15 --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs \
law run MergeCategorizationWrapper --version prod_240709 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 \
 --category-names base_selection --systematic-names ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11  \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 15 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --workers 50 --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 7 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G'

law run FeaturePlot --version prod_240709 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 --feature-tags base,cat --systematics ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 \
  --process-group-name Zprime_Zh_Zbbhtt --avoid-normalization --workers 20 


law run FeaturePlot --version prod_240610 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --region-name etau_os_iso  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 



export CMT_STORE_EOS_MERGECATEGORIZATION=/scratch/cuisset/cmt/test_systs_July
export CMT_STORE_EOS_CATEGORIZATION=/scratch/cuisset/cmt/test_systs_July
export CMT_STORE=/scratch/cuisset/cmt/test_systs_July

# --region-name etau_os_iso  --PreprocessRDF-branch 1  ele_scale,ele_resolution,
# pilot
law run PreprocessRDFWrapper --version prod_240610 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 \
  --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --systematic-names jec_1 --PreprocessRDF-branch 2 --workers 10

# ,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11
law run PreprocessRDFWrapper --version prod_240610 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 \
  --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --systematic-names ele_scale,ele_resolution,tes,jer,jec_1 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,priority=50' --workers 30

law run PreprocessRDFWrapper --version prod_240610b --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M2000 \
  --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --systematic-names ele_scale,ele_resolution,tes,jer,jec \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --PreprocessRDF-retries 1 --workers 30



# ,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 
law run MergeCategorizationWrapper --version prod_240610 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M2000 \
 --category-names ZbbHtt_orthogonal_cut_90_resolved_2b,ZbbHtt_orthogonal_cut_90_resolved_1b,ZbbHtt_orthogonal_cut_90_boosted --systematic-names ele_scale,ele_resolution,tes,jer,jec_1 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M,priority=50' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --workers 20 --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 4 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G,priority=50'

# law run PrePlot --version prod_240610 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
#   --dataset-name ZprimeToZH_ZToBB_HToTauTau_M600 \
#   --Categorization-feature-modules-file modulesrdf_cat  \
#   --skip-merging --feature-tags base  --branch 0 --workers 20
law run FeaturePlot --version prod_240610 --Categorization-version prod_240610 --category-name ZbbHtt_orthogonal_cut_90_resolved_2b --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M600 --feature-tags base --systematics ele_scale,ele_resolution,tes,jer,jec_1 \
  --PrePlot-skip-merging --process-group-name Zprime_Zh_Zbbhtt --avoid-normalization --workers 20 --print-status 2



# Categorization tests
law run CategorizationWrapper --version prod_240610 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M6000 \
  --Categorization-feature-modules-file modulesrdf_cat --systematic-names ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 \
   --Categorization-branch 0 --workers 1


# Plot after categorization & DNN
law run PreprocessRDFWrapper --version prod_240610 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M6000 \
  --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --systematic-names ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 --workers 15 

law run MergeCategorizationWrapper --version prod_240610 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M6000 \
 --category-names ZbbHtt_orthogonal_cut_90_resolved_2b,ZbbHtt_orthogonal_cut_90_resolved_1b,ZbbHtt_orthogonal_cut_90_boosted --systematic-names ele_scale,ele_resolution,tes,jer,jec_1  \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --workers 15

law run PrePlot --version prod_240610 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-name ZprimeToZH_ZToBB_HToTauTau_M6000 \
  --feature-tags base --systematics jec_1,jec_2 --workers 20
law run FeaturePlot --version prod_240610 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M6000 --feature-tags base --systematics jec_1,jec_2 \
  --process-group-name Zprime_Zh_Zbbhtt --avoid-normalization --workers 5 --print-status 2
law run FeaturePlotSyst --version prod_240610 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-names ZprimeToZH_ZToBB_HToTauTau_M6000 --feature-tags base --systematics jec_1,jec_2 \
  --process-group-name Zprime_Zh_Zbbhtt --avoid-normalization --workers 5

root://xrootd-cms.infn.it///store/mc/RunIISummer20UL18NanoAODv9/GluGluToXToZZTo2B2Tau_M-200_TuneCP5_13TeV-powheg-pythia8/NANOAODSIM/106X_upgrade2018_realistic_v16_L1v1-v2/2830000/676C93C0-FCFE-9640-9C80-0CE7CAF1E98D.root
root://eos.grif.fr///eos/grif/cms/llr/store/user/evernazz/HTT/Run2_2018/GluGluToXToZZTo2B2Tau_M-600/nanoHTT_0_0.root




# testing
law run PreprocessRDF --version prod_240722_test --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
  --dataset-name ZprimeToZH_ZToBB_HToTauTau_M6000 \
  --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-branch 26 --compute-filter-efficiency
#--systematic ele_scale --systematic-direction up

law run Categorization --version prod_240610test --PreprocessRDF-version prod_240610 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M6000 \
 --category-name ZbbHtt_orthogonal_cut_90_resolved_2b --Categorization-feature-modules-file modulesrdf_cat \
 --systematic tes --systematic-direction up --branch 1



################ OPTIMIZATION


law run BayesianBlocksOptimization --version prod_test --FeatureHistogram-version prod_240605 --PrePlot-version prod_240605 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_CR  --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240522 --MergeCategorization-version prod_240522  --process-group-name zz \
  --category-name ZZ_elliptical_cut_90_CR_resolved_1b --region-name etau_os_iso --FeatureHistogram-do-qcd --hide-data False



/grid_mnt/data__data.polcms/cms/vernazza/cmt/FeatureHistogram/ul_2018_ZZ_v12/cat_ZZ_elliptical_cut_90_CR_resolved_1b/prod_240605

mkdir -p /grid_mnt/data__data.polcms/cms/cuisset/cmt/FeatureHistogram/ul_2018_ZZ_v12/cat_ZZ_elliptical_cut_90_CR_resolved_1b/

law run PreprocessRDF --version prod_240610b --category-name base_selection --config-name ul_2018_ZbbHtt_v12   --dataset-name ZprimeToZH_ZToBB_HToTauTau_M6000   --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file   --systematic jec_2 --systematic-direction up


/data_CMS/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/store/PreprocessRDF/ul_2018_ZZ_v12/tt_sl/cat_base_selection/prod_240722/stdall_172To173.txt
