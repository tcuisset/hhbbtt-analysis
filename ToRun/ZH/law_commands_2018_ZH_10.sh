# Using Preprocess prod_240305, resonant central samples, split in categories res1b, res2b, boosted_nopnet
# prod_240522 : new elliptical cut, otherwise same as prod_240517
# for preprocess and precounter use law_commands_2018_ZH_6_res.sh

YEAR=2018
source setup.sh
# New ZH combination datasets
DATASETS_ZH_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top

DATASETS_ZH_nonres=zh_zbb_htt_signal,zh_ztt_hbb_signal,$DATASETS_ZH_base

# removed 4500 5000 5500 6000
RESONANT_MASSES="600 800 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000"
# TODO figure out what masses we want to use
DATASETS_ZbbHtt_res_only=ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M800,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M1200,ZprimeToZH_ZToBB_HToTauTau_M1400,ZprimeToZH_ZToBB_HToTauTau_M1600,ZprimeToZH_ZToBB_HToTauTau_M1800,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M2500,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M3500,ZprimeToZH_ZToBB_HToTauTau_M4000
DATASETS_ZttHbb_res_only=ZprimeToZH_ZToTauTau_HToBB_M600,ZprimeToZH_ZToTauTau_HToBB_M800,ZprimeToZH_ZToTauTau_HToBB_M1000,ZprimeToZH_ZToTauTau_HToBB_M1200,ZprimeToZH_ZToTauTau_HToBB_M1400,ZprimeToZH_ZToTauTau_HToBB_M1600,ZprimeToZH_ZToTauTau_HToBB_M1800,ZprimeToZH_ZToTauTau_HToBB_M2000,ZprimeToZH_ZToTauTau_HToBB_M2500,ZprimeToZH_ZToTauTau_HToBB_M3000,ZprimeToZH_ZToTauTau_HToBB_M3500,ZprimeToZH_ZToTauTau_HToBB_M4000,ZprimeToZH_ZToTauTau_HToBB_M4500,ZprimeToZH_ZToTauTau_HToBB_M5000,ZprimeToZH_ZToTauTau_HToBB_M5500,ZprimeToZH_ZToTauTau_HToBB_M6000

DATASETS_ZH_res=$DATASETS_ZbbHtt_res_only,$DATASETS_ZttHbb_res_only,$DATASETS_ZH_base,zh_zbb_htt,zh_ztt_hbb


# DATASETS_ZbbHtt_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
# tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
# zh_zbb_htt_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
# ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
# # TODO add 500,700 (forgotten for DNN training)


# DATASETS_ZbbHtt_nonres=zh_zbb_htt_signal,$DATASETS_ZbbHtt_base
# # zh_zbb_htt goes at the end to not mess up the legend order
# #RES_MASSES="500 1000 2000"

# #,ZprimeToZH_ZToBB_HToTauTau_M4500,ZprimeToZH_ZToBB_HToTauTau_M5000,ZprimeToZH_ZToBB_HToTauTau_M5500,ZprimeToZH_ZToBB_HToTauTau_M6000
# DATASETS_ZbbHtt_res=$DATASETS_ZbbHtt_res_only,$DATASETS_ZbbHtt_base,zh_zbb_htt

# DATASETS_ZttHbb_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
# tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
# zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
# ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
# DATASETS_ZttHbb_nonres=zh_ztt_hbb_signal,$DATASETS_ZttHbb_base

# DATASETS_ZttHbb_res_only=ZprimeToZH_ZToTauTau_HToBB_M600,ZprimeToZH_ZToTauTau_HToBB_M800,ZprimeToZH_ZToTauTau_HToBB_M1000,ZprimeToZH_ZToTauTau_HToBB_M1200,ZprimeToZH_ZToTauTau_HToBB_M1400,ZprimeToZH_ZToTauTau_HToBB_M1600,ZprimeToZH_ZToTauTau_HToBB_M1800,ZprimeToZH_ZToTauTau_HToBB_M2000,ZprimeToZH_ZToTauTau_HToBB_M2500,ZprimeToZH_ZToTauTau_HToBB_M3000,ZprimeToZH_ZToTauTau_HToBB_M3500,ZprimeToZH_ZToTauTau_HToBB_M4000,ZprimeToZH_ZToTauTau_HToBB_M4500,ZprimeToZH_ZToTauTau_HToBB_M5000,ZprimeToZH_ZToTauTau_HToBB_M5500,ZprimeToZH_ZToTauTau_HToBB_M6000
# DATASETS_ZttHbb_res=$DATASETS_ZttHbb_res_only,$DATASETS_ZttHbb_base,zh_ztt_hbb
# #Zprime_Zh_Ztautauhbb_M3000_v3,Zprime_Zh_Ztautauhbb_M4000_v3

# put all possible data_*_*, in case it does not exist for a year it just gets ignored
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e 
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e

# TODO remember to add missing DNN mass points 500,700, dnn_ZHbbtt_kl_1_1600,dnn_ZHbbtt_kl_1_1800,dnn_ZHbbtt_kl_1_2500
ALL_FEATURES_ZbbHtt=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt


ALL_FEATURES_ZttHbb=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Hbb_pt,Hbb_eta,Hbb_phi,Hbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################


###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################


law run MergeCategorizationWrapper --version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --category-names ZbbHtt_orthogonal_cut_90_CR,ZbbHtt_orthogonal_cut_90_CR_resolved_1b,ZbbHtt_orthogonal_cut_90_CR_resolved_1b,ZbbHtt_orthogonal_cut_90_CR_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --JoinDNNInference-workflow htcondor --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=300M' --JoinDNNInference-retries 1 --JoinDNNInference-poll-interval 3 --JoinDNNInference-tasks-per-job 10 --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs \
 --workers 50 --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G'

law run MergeCategorizationWrapper --version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --category-names ZttHbb_orthogonal_cut_90_CR,ZttHbb_orthogonal_cut_90_CR_resolved_1b,ZttHbb_orthogonal_cut_90_CR_resolved_1b,ZttHbb_orthogonal_cut_90_CR_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --JoinDNNInference-workflow htcondor --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=300M' --JoinDNNInference-retries 1 --JoinDNNInference-poll-interval 3 --JoinDNNInference-tasks-per-job 10 --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs \
 --workers 100 --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G'


###############################################################################################################################################
# RESONANT ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# # pilot
# law run MergeCategorization --version prod_240517 --category-name ZbbHtt_elliptical_cut_90_resolved_2b --config-name ul_${YEAR}_ZbbHtt_v12 \
#  --dataset-name ZprimeToZH_ZToBB_HToTauTau_M800 \
#  --PreprocessRDF-version prod_240305 \
#  --JoinDNNInference-base-category-name base_selection --from-DNN-inference True \
#  --JoinDNNInference-feature-modules-file modulesrdf_syst --workers 20


# law run CategorizationWrapper --version prod_240517 --config-name ul_${YEAR}_ZbbHtt_v12 \
#  --dataset-names $DATASETS_ZbbHtt_res,$DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU --category-names ZbbHtt_elliptical_cut_90_resolved_2b,ZbbHtt_elliptical_cut_90_resolved_1b,ZbbHtt_elliptical_cut_90_boosted_noPNet \
#  --PreprocessRDF-version prod_240305 \
#  --Categorization-base-category-name base_selection \
#  --Categorization-feature-modules-file modulesrdf_syst \
#  --workers 50 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 1 \
#  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
#  --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=2G'

# ZbbHtt_elliptical_cut_90_resolved_2b,ZbbHtt_elliptical_cut_90_resolved_1b,ZbbHtt_elliptical_cut_90_boosted_noPNet

law run MergeCategorizationWrapper --version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --skip-dataset-tags secondary,buggy \
 --category-names ZbbHtt_orthogonal_cut_90_resolved_2b,ZbbHtt_orthogonal_cut_90_resolved_1b,ZbbHtt_orthogonal_cut_90_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --JoinDNNInference-workflow htcondor --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=300M' --JoinDNNInference-retries 1 --JoinDNNInference-poll-interval 3 --JoinDNNInference-tasks-per-job 10 --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs \
 --workers 50 --Categorization-retries 1 --Categorization-poll-interval 3 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G'

## ZttHbb
# ZttHbb_elliptical_cut_90_resolved_2b,ZttHbb_elliptical_cut_90_resolved_1b,ZttHbb_elliptical_cut_90_boosted_noPNet

law run MergeCategorizationWrapper --version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --skip-dataset-tags secondary,buggy \
 --category-names ZttHbb_orthogonal_cut_90_resolved_2b,ZttHbb_orthogonal_cut_90_resolved_1b,ZttHbb_orthogonal_cut_90_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M' --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10 --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs \
 --JoinDNNInference-workflow htcondor --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=300M' --JoinDNNInference-retries 1 --JoinDNNInference-poll-interval 3 --JoinDNNInference-tasks-per-job 10 --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs \
 --workers 50 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=1G'



###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################

###############################################################################################################################################
# CONTROL REGION
###############################################################################################################################################
function featurePlotZbbHtt_CR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_CR,$ALL_FEATURES_ZbbHtt \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --workers 5 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name plot --save-png --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --stack --do-qcd --hide-data True "${@:4}"
}
declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 1000." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZbbHtt_SR_nonres $category etau $DATASETS_DATA_ETAU $logParams & 
featurePlotZbbHtt_SR_nonres $category mutau $DATASETS_DATA_MUTAU $logParams & 
featurePlotZbbHtt_SR_nonres $category tautau $DATASETS_DATA_TAUTAU $logParams & 
done
wait
done

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

############ Non-resonant plots
function featurePlotZbbHtt_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES_ZbbHtt \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --workers 5 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name plot --save-png --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --stack --do-qcd --hide-data True "${@:4}"
}
declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 1000." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZbbHtt_SR_nonres $category etau $DATASETS_DATA_ETAU $logParams & 
featurePlotZbbHtt_SR_nonres $category mutau $DATASETS_DATA_MUTAU $logParams & 
featurePlotZbbHtt_SR_nonres $category tautau $DATASETS_DATA_TAUTAU $logParams & 
done
wait
done

python3 ToRun/MoveToEos.py --region SR --type NonRes --ver ul_2018_ZbbHtt_v12 \
    --cat cat_ZbbHtt_orthogonal_cut_90_resolved_1b,cat_ZbbHtt_orthogonal_cut_90_resolved_2b,cat_ZbbHtt_orthogonal_cut_90_boosted_noPNet \
    --prd prod_240528_nonres --grp plot --user_eos tcuisset

# for logParams in "${logCommands[@]}"; do
# law run FeaturePlotWrapper --FeaturePlot-version prod_240522_nonres --PrePlot-version prod_240522 --FeaturePlot-config-name ul_${YEAR}_ZbbHtt_v12 \
#  --FeaturePlot-feature-names $ALL_FEATURES_ZbbHtt \
#  --FeaturePlot-dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU \
#  --workers 15 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
#  --FeaturePlot-process-group-name plot --FeaturePlot-save-png --FeaturePlot-stack --FeaturePlot-do-qcd --FeaturePlot-hide-data True \
#  --category-names ZbbHtt_elliptical_cut_90_resolved_2b,ZbbHtt_elliptical_cut_90_resolved_1b,ZbbHtt_elliptical_cut_90_boosted_noPNet \
#  --region-names etau_os_iso,mutau_os_iso,tautau_os_iso $logParams
# done


law run FeaturePlotWrapper --FeaturePlot-version prod_240522_nonres --PrePlot-version prod_240522 --FeaturePlot-config-name ul_${YEAR}_ZbbHtt_v12 \
 --FeaturePlot-feature-names $ALL_FEATURES_ZbbHtt \
 --FeaturePlot-dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU \
 --workers 25 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --FeaturePlot-process-group-name plot --FeaturePlot-save-png --FeaturePlot-stack --FeaturePlot-do-qcd --FeaturePlot-hide-data True \
 --category-names ZbbHtt_orthogonal_cut_90_resolved_2b,ZbbHtt_orthogonal_cut_90_resolved_1b,ZbbHtt_orthogonal_cut_90_boosted_noPNet \
 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-multiply-signals-normalization 1000.

# testing
law run FeaturePlot --FeaturePlot-version prod_240522_nonres --PrePlot-version prod_240522 --FeaturePlot-config-name ul_${YEAR}_ZbbHtt_v12 \
 --FeaturePlot-feature-names $ALL_FEATURES_ZbbHtt \
 --FeaturePlot-dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU \
 --workers 25 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --FeaturePlot-process-group-name plot --FeaturePlot-save-png --FeaturePlot-stack --FeaturePlot-hide-data True \
 --category-name ZbbHtt_orthogonal_cut_90_boosted_noPNet \
 --region-name etau_os_iso --FeaturePlot-multiply-signals-normalization 1000.

function featurePlotZttHbb_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres  --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $ALL_FEATURES_ZttHbb \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name plot --save-png --category-name ZttHbb_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --stack --do-qcd --hide-data True $LOG_PARAMS "${@:4}"
}
declare -a logCommands=("--multiply-signals-normalization 1000." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZttHbb_SR_nonres $category etau $DATASETS_DATA_ETAU $logParams &
featurePlotZttHbb_SR_nonres $category mutau $DATASETS_DATA_MUTAU $logParams  & 
featurePlotZttHbb_SR_nonres $category tautau $DATASETS_DATA_TAUTAU $logParams  & 
done
wait
done

python3 ToRun/MoveToEos.py --region SR --type NonRes --ver ul_2018_ZttHbb_v12 \
    --cat cat_ZttHbb_orthogonal_cut_90_resolved_1b,cat_ZttHbb_orthogonal_cut_90_resolved_2b,cat_ZttHbb_orthogonal_cut_90_boosted_noPNet \
    --prd prod_240528_nonres --grp plot --user_eos tcuisset



############# Resonant plots
# Dummy plots to trigger PrePlot for every dataset
function featurePlotZbbHtt_res_dummy {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeatureHistogram --version prod_240528_res_dummy --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES_ZbbHtt \
 --dataset-names $DATASETS_ZH_res,$DATASETS_DATA \
 --workers 3 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name datacard_res --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --do-qcd --hide-data True  "${@:4}"
}
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZbbHtt_res_dummy $category etau $DATASETS_DATA_ETAU  &
featurePlotZbbHtt_res_dummy $category mutau $DATASETS_DATA_MUTAU  &
featurePlotZbbHtt_res_dummy $category tautau $DATASETS_DATA_TAUTAU &
done

function featurePlotZttHbb_res_dummy {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeatureHistogram --version prod_240528_res_dummy --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $ALL_FEATURES_ZttHbb \
 --dataset-names $DATASETS_ZH_res,$DATASETS_DATA \
 --workers 2 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name datacard_res --category-name ZttHbb_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --do-qcd --hide-data True  "${@:4}"
}
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZttHbb_res_dummy $category etau $DATASETS_DATA_ETAU  &
featurePlotZttHbb_res_dummy $category mutau $DATASETS_DATA_MUTAU  &
featurePlotZttHbb_res_dummy $category tautau $DATASETS_DATA_TAUTAU &
done

###############################################################################################################################################
############################################################  Datacards  #################################################################
###############################################################################################################################################
########### Non-resonant
# NB : --PrePlot-feature-names $ALL_FEATURES_ZbbHtt  does not work
function makeNonResonantDatacards_ZbbHtt(){
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeatureHistogram --version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES_ZbbHtt --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso "${@:4}" \
&& \
    law run CreateDatacards --version prod_240528_nonres --FeaturePlot-version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --FeaturePlot-hide-data True  "${@:4}"
}
# QCD only for resolved_1b
makeNonResonantDatacards_ZbbHtt resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
for category in  resolved_2b boosted_noPNet; do
makeNonResonantDatacards_ZbbHtt $category etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt $category mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt $category tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
done

# fixing QCD
# makeNonResonantDatacards_ZbbHtt boosted_noPNet tautau $DATASETS_DATA_TAUTAU --remove-output 0,a,True

# ZttHbb
function makeNonResonantDatacards_ZttHbb(){
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3
    law run FeatureHistogram --version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $ALL_FEATURES_ZttHbb --workers 7 --MergeCategorizationStats-version prod_240305 \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZttHbb_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso "${@:4}" \
&& \
    law run CreateDatacards --version prod_240528_nonres --FeaturePlot-version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --PrePlot-feature-names $ALL_FEATURES_ZttHbb --workers 5 --MergeCategorizationStats-version prod_240305  \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZttHbb_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --FeaturePlot-hide-data True "${@:4}"
}
makeNonResonantDatacards_ZttHbb resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
for category in resolved_2b boosted_noPNet; do
makeNonResonantDatacards_ZttHbb $category etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb $category mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb $category tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
done

# fixing QCD
makeNonResonantDatacards_ZttHbb boosted_noPNet etau $DATASETS_DATA_ETAU --remove-output 0,a,True

########################### Resonant datacards
# remember to run featurePlot with all the dnns beforehand
function makeResonantDatacards_ZbbHtt {
    RES_MASS=$1
    CATEGORY=$2
    REGION_NAME=$3
    DATASETS_DATA=$4

    # make datacards for both the parametrized an non-parametrized DNN
    law run CreateDatacards --version prod_240528_M$RES_MASS --FeatureHistogram-version prod_240528_M$RES_MASS --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names "ZprimeToZH_ZToBB_HToTauTau_M${RES_MASS},ZprimeToZH_ZToTauTau_HToBB_M${RES_MASS},$DATASETS_ZH_base,zh_zbb_htt,zh_ztt_hbb,$DATASETS_DATA" \
 --process-group-name datacard_res  --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso  --hide-data True "${@:5}"
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZbbHtt $res_mass resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd 
    makeResonantDatacards_ZbbHtt $res_mass resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd 
    makeResonantDatacards_ZbbHtt $res_mass resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 

    makeResonantDatacards_ZbbHtt $res_mass resolved_2b etau $DATASETS_DATA_ETAU 
    makeResonantDatacards_ZbbHtt $res_mass resolved_2b mutau $DATASETS_DATA_MUTAU 
    makeResonantDatacards_ZbbHtt $res_mass resolved_2b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 

    makeResonantDatacards_ZbbHtt $res_mass boosted_noPNet etau $DATASETS_DATA_ETAU 
    makeResonantDatacards_ZbbHtt $res_mass boosted_noPNet mutau $DATASETS_DATA_MUTAU 
    makeResonantDatacards_ZbbHtt $res_mass boosted_noPNet tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 
done

function makeResonantDatacards_ZttHbb {
    RES_MASS=$1
    CATEGORY=$2
    REGION_NAME=$3
    DATASETS_DATA=$4

    law run CreateDatacards --version prod_240528_M$RES_MASS --FeatureHistogram-version prod_240528_M$RES_MASS --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 5 --MergeCategorizationStats-version prod_240305  \
 --dataset-names "ZprimeToZH_ZToTauTau_HToBB_M${RES_MASS},ZprimeToZH_ZToBB_HToTauTau_M${RES_MASS},$DATASETS_ZH_base,zh_zbb_htt,zh_ztt_hbb,$DATASETS_DATA" \
 --process-group-name datacard_res --category-name ZttHbb_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --hide-data True --remove-output 0,a,True  "${@:5}" &
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZttHbb $res_mass resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd 
    makeResonantDatacards_ZttHbb $res_mass resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd 
    makeResonantDatacards_ZttHbb $res_mass resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 

    makeResonantDatacards_ZttHbb $res_mass resolved_2b etau $DATASETS_DATA_ETAU 
    makeResonantDatacards_ZttHbb $res_mass resolved_2b mutau $DATASETS_DATA_MUTAU 
    makeResonantDatacards_ZttHbb $res_mass resolved_2b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 

    makeResonantDatacards_ZttHbb $res_mass boosted_noPNet etau $DATASETS_DATA_ETAU 
    makeResonantDatacards_ZttHbb $res_mass boosted_noPNet mutau $DATASETS_DATA_MUTAU 
    makeResonantDatacards_ZttHbb $res_mass boosted_noPNet tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd 
done



