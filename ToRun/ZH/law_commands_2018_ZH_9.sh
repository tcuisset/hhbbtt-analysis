# Using Preprocess prod_240305, resonant central samples, split in categories res1b, res2b, boosted_nopnet
# prod_240517 (old elliptical cut)
# for preprocess and precounter use law_commands_2018_ZH_6_res.sh

YEAR=2018
source setup.sh
DATASETS_ZbbHtt_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
# TODO add 500,700 (forgotten for DNN training)
RESONANT_MASSES="600 800 1000 1200 1400 1600 1800 2000 2500 3000 3500 4000 4500 5000 5500 6000"

DATASETS_ZbbHtt_nonres=zh_zbb_htt_signal,$DATASETS_ZbbHtt_base
# zh_zbb_htt goes at the end to not mess up the legend order
#RES_MASSES="500 1000 2000"
DATASETS_ZbbHtt_res_only=ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M800,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M1200,ZprimeToZH_ZToBB_HToTauTau_M1400,ZprimeToZH_ZToBB_HToTauTau_M1600,ZprimeToZH_ZToBB_HToTauTau_M1800,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M2500,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M3500,ZprimeToZH_ZToBB_HToTauTau_M4000
#,ZprimeToZH_ZToBB_HToTauTau_M4500,ZprimeToZH_ZToBB_HToTauTau_M5000,ZprimeToZH_ZToBB_HToTauTau_M5500,ZprimeToZH_ZToBB_HToTauTau_M6000
DATASETS_ZbbHtt_res=$DATASETS_ZbbHtt_res_only,$DATASETS_ZbbHtt_base,zh_zbb_htt

DATASETS_ZttHbb_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_ZttHbb_nonres=zh_ztt_hbb_signal,$DATASETS_ZttHbb_base

DATASETS_ZttHbb_res_only=ZprimeToZH_ZToTauTau_HToBB_M600,ZprimeToZH_ZToTauTau_HToBB_M800,ZprimeToZH_ZToTauTau_HToBB_M1000,ZprimeToZH_ZToTauTau_HToBB_M1200,ZprimeToZH_ZToTauTau_HToBB_M1400,ZprimeToZH_ZToTauTau_HToBB_M1600,ZprimeToZH_ZToTauTau_HToBB_M1800,ZprimeToZH_ZToTauTau_HToBB_M2000,ZprimeToZH_ZToTauTau_HToBB_M2500,ZprimeToZH_ZToTauTau_HToBB_M3000,ZprimeToZH_ZToTauTau_HToBB_M3500,ZprimeToZH_ZToTauTau_HToBB_M4000,ZprimeToZH_ZToTauTau_HToBB_M4500,ZprimeToZH_ZToTauTau_HToBB_M5000,ZprimeToZH_ZToTauTau_HToBB_M5500,ZprimeToZH_ZToTauTau_HToBB_M6000
DATASETS_ZttHbb_res=$DATASETS_ZttHbb_res_only,$DATASETS_ZttHbb_base,zh_ztt_hbb
#Zprime_Zh_Ztautauhbb_M3000_v3,Zprime_Zh_Ztautauhbb_M4000_v3

# put all possible data_*_*, in case it does not exist for a year it just gets ignored
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e 
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e

# TODO remember to add missing DNN mass points 500,700, dnn_ZHbbtt_kl_1_1600,dnn_ZHbbtt_kl_1_1800,dnn_ZHbbtt_kl_1_2500
ALL_FEATURES_ZbbHtt=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,\
Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt


ALL_FEATURES_ZttHbb=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Hbb_pt,Hbb_eta,Hbb_phi,Hbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

# ###############################################################################################################################################
# # ELLIPTICAL MASS CUT
# ###############################################################################################################################################

# law run CategorizationWrapper --version prod_240312 --category-names base --config-name ul_${YEAR}_ZbbHtt_v12 \
#  --skip-dataset-tags secondary \
#  --PreprocessRDF-version prod_240305 \
#  --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
#  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
#  --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'


###############################################################################################################################################
# RESONANT ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# pilot
law run MergeCategorization --version prod_240517 --category-name ZbbHtt_elliptical_cut_90_resolved_2b --config-name ul_${YEAR}_ZbbHtt_v12 \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M800 \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --from-DNN-inference True \
 --JoinDNNInference-feature-modules-file modulesrdf_syst --workers 20


law run CategorizationWrapper --version prod_240517 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --dataset-names $DATASETS_ZbbHtt_res,$DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU --category-names ZbbHtt_elliptical_cut_90_resolved_2b,ZbbHtt_elliptical_cut_90_resolved_1b,ZbbHtt_elliptical_cut_90_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst \
 --workers 50 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=2G'

# prod_240517 : old elliptical cut,  prod_240522 : new cut + orthogonality
# 
law run MergeCategorizationWrapper --version prod_240517 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --dataset-names $DATASETS_ZbbHtt_res,$DATASETS_ZbbHtt_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU \
 --category-names ZbbHtt_elliptical_cut_90_resolved_2b,ZbbHtt_elliptical_cut_90_resolved_1b,ZbbHtt_elliptical_cut_90_boosted_noPNet,ZbbHtt_orthogonal_cut_90_resolved_2b,ZbbHtt_orthogonal_cut_90_resolved_1b,ZbbHtt_orthogonal_cut_90_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True \
 --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --workers 10 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M'

# was never run with orthogonal cuts
law run MergeCategorizationWrapper --version prod_240517 --config-name ul_${YEAR}_ZttHbb_v12 \
 --dataset-names $DATASETS_ZttHbb_res,$DATASETS_ZttHbb_nonres,$DATASETS_DATA_ETAU,$DATASETS_DATA_MUTAU,$DATASETS_DATA_TAUTAU \
 --category-names ZttHbb_elliptical_cut_90_resolved_2b,ZttHbb_elliptical_cut_90_resolved_1b,ZttHbb_elliptical_cut_90_boosted_noPNet \
 --PreprocessRDF-version prod_240305 \
 --JoinDNNInference-base-category-name base_selection --MergeCategorization-from-DNN-inference True \
 --JoinDNNInference-feature-modules-file modulesrdf_syst \
 --workers 10 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M'






###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################


###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

############ Non-resonant plots
function featurePlotZbbHtt_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240517_nonres --PrePlot-version prod_240517 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES_ZbbHtt \
 --dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA \
 --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240517 \
 --process-group-name plot --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True "${@:4}"
}
declare -a logCommands=("--multiply-signals-normalization 1000." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZbbHtt_SR_nonres $category etau $DATASETS_DATA_ETAU $logParams & 
featurePlotZbbHtt_SR_nonres $category mutau $DATASETS_DATA_MUTAU $logParams & 
featurePlotZbbHtt_SR_nonres $category tautau $DATASETS_DATA_TAUTAU $logParams & 
done
wait
done


function featurePlotZttHbb_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240517_nonres --PrePlot-version prod_240517 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $ALL_FEATURES_ZttHbb \
 --dataset-names $DATASETS_ZttHbb_nonres,$DATASETS_DATA \
 --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240517 \
 --process-group-name plot --save-root --save-png --category-name ZttHbb_elliptical_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True $LOG_PARAMS "${@:4}"
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



###############################################################################################################################################
############################################################  Datacards  #################################################################
###############################################################################################################################################
########### Non-resonant
function makeNonResonantDatacards_ZbbHtt(){
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run CreateDatacards --version prod_240517_nonres --FeaturePlot-version prod_240517_nonres --PrePlot-version prod_240517 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names "$DATASETS_ZbbHtt_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --FeaturePlot-hide-data True  "${@:4}"
}
# QCD only for resolved_1b
makeNonResonantDatacards_ZbbHtt resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
for category in  resolved_2b boosted_noPNet; do
makeNonResonantDatacards_ZbbHtt $category etau $DATASETS_DATA_ETAU &
makeNonResonantDatacards_ZbbHtt $category mutau $DATASETS_DATA_MUTAU &
makeNonResonantDatacards_ZbbHtt $category tautau $DATASETS_DATA_TAUTAU &
done

# ZttHbb
function makeNonResonantDatacards_ZttHbb(){
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run CreateDatacards --version prod_240517_nonres --PrePlot-version prod_240517 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 5 --MergeCategorizationStats-version prod_240305  \
 --dataset-names "$DATASETS_ZttHbb_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --FeaturePlot-hide-data True "${@:4}"
}
makeNonResonantDatacards_ZttHbb resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZttHbb resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
for category in resolved_2b boosted_noPNet; do
makeNonResonantDatacards_ZttHbb $category etau $DATASETS_DATA_ETAU &
makeNonResonantDatacards_ZttHbb $category mutau $DATASETS_DATA_MUTAU &
makeNonResonantDatacards_ZttHbb $category tautau $DATASETS_DATA_TAUTAU &
done

########################### Resonant datacards
# remember to run featurePlot with all the dnns beforehand
function makeResonantDatacards_ZbbHtt {
    RES_MASS=$1
    REGION_NAME=$2
    DATASETS_DATA=$3
    # make datacards for both the parametrized an non-parametrized DNN
    law run CreateDatacards --version prod_240510_M$RES_MASS --FeaturePlot-version prod_240510_M$RES_MASS --PrePlot-version prod_240510 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 2 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "ZprimeToZH_ZToBB_HToTauTau_M${RES_MASS},$DATASETS_ZbbHtt_base,zh_zbb_htt,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png  --category-name ZbbHtt_elliptical_cut_90 \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd "${@:4}"
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZbbHtt $res_mass etau $DATASETS_DATA_ETAU &
    makeResonantDatacards_ZbbHtt $res_mass mutau $DATASETS_DATA_MUTAU &
    makeResonantDatacards_ZbbHtt $res_mass tautau $DATASETS_DATA_TAUTAU &
done

function makeResonantDatacards_ZttHbb {
    RES_MASS=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run CreateDatacards --version prod_240510_M$RES_MASS --FeaturePlot-version prod_240510_M$RES_MASS --PrePlot-version prod_240510 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 2 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "ZprimeToZH_ZToTauTau_HToBB_M${RES_MASS},$DATASETS_ZttHbb_base,zh_ztt_hbb,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb_res --save-root --save-png --category-name ZttHbb_elliptical_cut_90 \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd "${@:4}"
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZttHbb $res_mass etau $DATASETS_DATA_ETAU &
    makeResonantDatacards_ZttHbb $res_mass mutau $DATASETS_DATA_MUTAU &
    makeResonantDatacards_ZttHbb $res_mass tautau $DATASETS_DATA_TAUTAU &
done







############# Testing
law run PrePlot --version prod_240513_test1 --config-name ul_2016_ZbbHtt_v12 \
 --feature-name dnn_ZHbbtt_kl_1_1000 \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M1000 \
 --workers 1 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430 --MergeCategorization-version prod_240430 \
 --category-name ZbbHtt_elliptical_cut_90 --region-name etau_os_iso 


law run PreprocessRDF --version prod_240513_testWeights --category-name test_weights --config-name ul_2016_ZbbHtt_v12 \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M1000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0


law run PrePlot --version prod_240510_res --PrePlot-version prod_240510 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M1000 \
 --MergeCategorization-version prod_240430 \
 --category-name ZbbHtt_elliptical_cut_90 --region-name etau_os_iso