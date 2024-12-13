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
# --systematic-names ele_scale,ele_resolution,tes,jer,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11
# --systematic-names ele_scale,ele_resolution,tes,jer,jec
# --dataset-tags limited --skip-dataset-tags secondary \
# --dataset-names data_etau_a,zz_dl \
law run PreprocessRDFWrapper --version prod_240725 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-tags limited --skip-dataset-tags secondary \
 --systematic-names ele_scale,ele_resolution,tes,jer,jec \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --PreprocessRDF-auto-queue --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3Queue=short,WNTag=el7,request_memory=2.3G,priority=-5' --workers 30


# nominal for everything
# --systematic-names ele_scale,ele_resolution,tes,jer,jec \
law run PreprocessRDFWrapper --version prod_240725 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,limited \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --PreprocessRDF-auto-queue --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3Queue=long,WNTag=el7,request_memory=2.3G,priority=-15' --workers 30

# pilot
law run PreprocessRDFWrapper --version prod_240725 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names dy \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3Queue=short,WNTag=el7,priority=-5' --PreprocessRDF-auto-queue --workers 50

# pilot pilot
law run PreprocessRDF --version prod_240725 --category-name base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-name zz_dl \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0 --systematic jec_1 --systematic-direction up



################## CATEGORIZATION
# pilot
law run MergeCategorizationWrapper --version prod_240725 --config-name ul_2018_ZZ_v12 \
 --dataset-names tt_sl \
 --category-names ZZ_elliptical_cut_90_resolved_2b --systematic-names ele_scale,ele_resolution,tes,jer,jec \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --workers 1

# main all datasets
# --systematic-names ele_scale,ele_resolution,tes,jer,jec 
# --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M,priority=6' --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs  --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10  \
law run MergeCategorizationWrapper --version prod_240725 --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary \
 --category-names ZZ_elliptical_cut_90_resolved_2b,ZZ_elliptical_cut_90_resolved_1b,ZZ_elliptical_cut_90_boosted \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G,priority=5' --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 4 \
 --workers 30

# limited systematics
# WARNING too many tasks-per-job leads to memory issues
law run MergeCategorizationWrapper --version prod_240725 --config-name ul_2018_ZZ_v12 \
 --dataset-tags limited --skip-dataset-tags secondary --systematic-names ele_scale,ele_resolution,tes,jer,jec  \
 --category-names ZZ_elliptical_cut_90_resolved_2b,ZZ_elliptical_cut_90_resolved_1b,ZZ_elliptical_cut_90_boosted \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=2G,priority=5' --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-retries 1 --Categorization-poll-interval 2 --Categorization-tasks-per-job 5 \
 --workers 40


################## PLOTTING
# no systs
# --systematics ele_scale,ele_resolution,tes,jer,jec ,ZZ_elliptical_cut_90_resolved_1b,ZZ_elliptical_cut_90_boosted
law run FeaturePlot --version prod_240725_noSysts --PrePlot-version prod_240725 --MergeCategorizationStats-version prod_240305  --config-name ul_2018_ZZ_v12 \
 --category-name ZZ_elliptical_cut_90_resolved_2b  --dataset-tags limited --skip-dataset-tags secondary --feature-tags base,cat  \
  --process-group-name zz --stack --hide-data True --workers 20

law run FeaturePlot --version prod_240725_noSysts --PrePlot-version prod_240725 --MergeCategorizationStats-version prod_240305  --config-name ul_2018_ZZ_v12 \
 --category-name ZZ_elliptical_cut_90_resolved_2b  --dataset-tags limited --skip-dataset-tags secondary --feature-tags base,cat --skip-feature-tags blind  \
  --process-group-name zz --stack --hide-data False --workers 3

# debug
law run FeaturePlot --version prod_240725_test --MergeCategorization-version prod_240725 --MergeCategorizationStats-version prod_240305 --category-name ZZ_elliptical_cut_90_resolved_2b --config-name ul_2018_ZZ_v12 \
  --dataset-tags limited --skip-dataset-tags secondary --feature-names Zbb_mass  \
  --process-group-name zz --stack --hide-data True --avoid-normalization 


# --skip-feature-tags blind
function featurePlotZZ_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2

    law run FeaturePlot --version prod_240725_allDatasets_noSysts --FeatureHistogram-version prod_240725_allDatasets_noSysts --PrePlot-version prod_240725_noSysts --config-name ul_2018_ZZ_v12 \
 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240725 \
 --feature-tags base,cat  \
 --skip-dataset-tags secondary \
 --process-group-name zz --save-png --category-name ZZ_elliptical_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --stack --do-qcd True --hide-data True --workers 5 "${@:3}"
}
declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted; do
featurePlotZZ_SR_nonres $category etau $logParams &
featurePlotZZ_SR_nonres $category mutau $logParams &
featurePlotZZ_SR_nonres $category tautau $logParams &
done
wait
done




####################################################" FASTMTTT"
# --systematic jec_1 --systematic-direction up
time law run PreprocessRDF --version prod_240727_svfit --category-name base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M300 \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0 

time law run PreprocessRDF --version prod_240727_fastMTT --category-name base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M300 \
 --PreprocessRDF-modules-file modulesrdf_fastmtt --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 1


law run PreprocessRDFWrapper --version prod_240727_fastMTT --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M3000,zz_sl_signal \
 --PreprocessRDF-modules-file modulesrdf_fastmtt --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --PreprocessRDF-auto-queue --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3Queue=short,WNTag=el7,request_memory=2.3G,priority=10' --workers 30





python3 -m cProfile -o preplot.prof $(which law) run PrePlot --version prod_240725_test --MergeCategorization-version prod_240725  --config-name ul_2018_ZZ_v12 \
 --category-name ZZ_elliptical_cut_90_resolved_1b  --dataset-name tt_sl --feature-tags base,cat  \
  --branch 0