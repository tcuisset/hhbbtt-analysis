# Using Preprocess prod_240305, resonant central samples, Categorization with resonant DNN retrained on full run2
# for preprocess and precounter use law_commands_2018_ZH_6_res.sh

YEAR=2018
source setup.sh
DATASETS_ZbbHtt_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
# TODO add 500,700 (forgotten) & 1600 1800 (error at Categorization, need re-categorization)
RESONANT_MASSES="600 800 1000 1200 1400 2000 2500 3000 3500 4000 4500 5000 5500 6000"

DATASETS_ZbbHtt_nonres=zh_zbb_htt_signal,$DATASETS_ZbbHtt_base
# zh_zbb_htt goes at the end to not mess up the legend order
#RES_MASSES="500 1000 2000"
DATASETS_ZbbHtt_res_only=ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M800,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M1200,ZprimeToZH_ZToBB_HToTauTau_M1400,ZprimeToZH_ZToBB_HToTauTau_M1600,ZprimeToZH_ZToBB_HToTauTau_M1800,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M2500,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M3500,ZprimeToZH_ZToBB_HToTauTau_M4000,ZprimeToZH_ZToBB_HToTauTau_M4500,ZprimeToZH_ZToBB_HToTauTau_M5000,ZprimeToZH_ZToBB_HToTauTau_M5500,ZprimeToZH_ZToBB_HToTauTau_M6000
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
ALL_FEATURES=dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_600,dnn_ZHbbtt_kl_1_800,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_1200,dnn_ZHbbtt_kl_1_1400,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,dnn_ZHbbtt_kl_1_3500,dnn_ZHbbtt_kl_1_4000,dnn_ZHbbtt_kl_1_4500,dnn_ZHbbtt_kl_1_5000,dnn_ZHbbtt_kl_1_5500,dnn_ZHbbtt_kl_1_6000,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,\
Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt



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
law run Categorization --version prod_240430 --category-name ZbbHtt_elliptical_cut_90 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --dataset-name ZprimeToZH_ZToBB_HToTauTau_M800 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_ZHresonant_syst --workers 1 --branch 0


law run MergeCategorizationWrapper --version prod_240430 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --dataset-names zh_zbb_htt_signal,$DATASETS_ZbbHtt_res --category-names ZbbHtt_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_ZHresonant_syst --workers 20 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7,request_memory=3G'

law run MergeCategorizationWrapper --version prod_240430 --config-name ul_${YEAR}_ZttHbb_v12 \
 --dataset-names zh_ztt_hbb_signal,$DATASETS_ZttHbb_res --category-names ZttHbb_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_ZHresonant_syst --workers 20 --Categorization-retries 1 --Categorization-poll-interval 5 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7,priority=-2,request_memory=2.5G'







###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################


###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

########### Resonant plots
function featurePlotZbbHtt_SR_res {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240510_res --PrePlot-version prod_240510 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES \
 --dataset-names $DATASETS_ZbbHtt_res,$DATASETS_DATA \
 --workers 25 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430 --MergeCategorization-version prod_240430 \
 --process-group-name plot_res --save-root --save-png --category-name ZbbHtt_elliptical_cut_90 --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True  "${@:3}"
}
declare -a logCommands=("--multiply-signals-normalization 10." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZbbHtt_SR_res etau $DATASETS_DATA_ETAU $logParams &
featurePlotZbbHtt_SR_res mutau $DATASETS_DATA_MUTAU $logParams &
featurePlotZbbHtt_SR_res tautau $DATASETS_DATA_TAUTAU $logParams &
wait
done

# Plots parametrized DNN distribution showing only the corresponding resonant sample
# to be run after another featureplot to not mess up PrePlot
function featurePlotZbbHtt_SR_res_individualMasses {
    REGION_NAME=$1
    DATASETS_DATA=$2

    for mass in $RES_MASSES; do

    law run FeaturePlot --version prod_240430_res_DNN --PrePlot-version prod_240430 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$mass \
 --dataset-names ZprimeToZH_ZToTauTau_HToBB_M${mass},$DATASETS_ZbbHtt_base,zh_zbb_htt,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430 --MergeCategorization-version prod_240430 \
 --process-group-name plot_res --save-root --save-png --category-name ZbbHtt_elliptical_cut_90 --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True  "${@:3}" &
 done
}
declare -a logCommands=("--multiply-signals-normalization 10." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZbbHtt_SR_res_individualMasses etau $DATASETS_DATA_ETAU $logParams &
featurePlotZbbHtt_SR_res_individualMasses mutau $DATASETS_DATA_MUTAU $logParams &
featurePlotZbbHtt_SR_res_individualMasses tautau $DATASETS_DATA_TAUTAU $logParams &
wait
done


function featurePlotZttHbb_SR_res {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240430_res --PrePlot-version prod_240430 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $ALL_FEATURES \
 --dataset-names $DATASETS_ZttHbb_res,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430 --MergeCategorization-version prod_240430 \
 --process-group-name plot_res --save-root --save-png --category-name ZttHbb_elliptical_cut_90 --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True "${@:3}"
}
declare -a logCommands=("--multiply-signals-normalization 10." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZttHbb_SR_res etau $DATASETS_DATA_ETAU $logParams &
featurePlotZttHbb_SR_res mutau $DATASETS_DATA_MUTAU  $logParams &
featurePlotZttHbb_SR_res tautau $DATASETS_DATA_TAUTAU  $logParams &
wait
done

# Plots parametrized DNN distribution showing only the corresponding resonant sample
# to be run after another featureplot to not mess up PrePlot
function featurePlotZttHbb_SR_res_individualMasses {
    REGION_NAME=$1
    DATASETS_DATA=$2

    for mass in $RES_MASSES; do

    law run FeaturePlot --version prod_240430_res_DNN --PrePlot-version prod_240430 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$mass \
 --dataset-names ZprimeToZH_ZToTauTau_HToBB_M${mass},$DATASETS_ZttHbb_base,zh_ztt_hbb,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430 --MergeCategorization-version prod_240430 \
 --process-group-name plot_res --save-root --save-png --category-name ZttHbb_elliptical_cut_90 --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True  "${@:3}" &
 done
}
declare -a logCommands=("--multiply-signals-normalization 10." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZttHbb_SR_res_individualMasses etau $DATASETS_DATA_ETAU $logParams &
featurePlotZttHbb_SR_res_individualMasses mutau $DATASETS_DATA_MUTAU $logParams &
featurePlotZttHbb_SR_res_individualMasses tautau $DATASETS_DATA_TAUTAU $logParams &
wait
done



###############################################################################################################################################
############################################################  Datacards  #################################################################
###############################################################################################################################################
########### Non-resonant
function makeNonResonantDatacards_ZbbHtt(){
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run CreateDatacards --version prod_240430_nonres --FeaturePlot-version prod_240430_nonres --PrePlot-version prod_240430 --config-name ul_2018_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "$DATASETS_ZbbHtt_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90 \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZbbHtt etau $DATASETS_DATA_ETAU
makeNonResonantDatacards_ZbbHtt mutau $DATASETS_DATA_MUTAU
makeNonResonantDatacards_ZbbHtt tautau $DATASETS_DATA_TAUTAU

# ZttHbb
function makeNonResonantDatacards_ZttHbb(){
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run CreateDatacards --version prod_240430_nonres --FeaturePlot-version prod_240430_nonres --PrePlot-version prod_240430 --config-name ul_2018_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "$DATASETS_ZttHbb_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90 \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZttHbb etau $DATASETS_DATA_ETAU
makeNonResonantDatacards_ZttHbb mutau $DATASETS_DATA_MUTAU
makeNonResonantDatacards_ZttHbb tautau $DATASETS_DATA_TAUTAU


########################### Resonant datacards
# remember to run featurePlot with all the dnns beforehand
function makeResonantDatacards_ZbbHtt {
    RES_MASS=$1
    REGION_NAME=$2
    DATASETS_DATA=$3
    # make datacards for both the parametrized an non-parametrized DNN
    law run CreateDatacards --version prod_240430_M$RES_MASS --FeaturePlot-version prod_240430_resDNN --PrePlot-version prod_240430 --config-name ul_2018_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 4 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "Zprime_Zh_Zbbhtautau_M${RES_MASS}_v3,$DATASETS_ZbbHtt_base,zh_zbb_htt,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90 \
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

    law run CreateDatacards --version prod_240430_M$RES_MASS --FeaturePlot-version prod_240430_resDNN --PrePlot-version prod_240430 --config-name ul_2018_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1,ZHKinFit_highmass --workers 4 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240430 --Categorization-version prod_240430  \
 --dataset-names "Zprime_Zh_Ztautauhbb_M${RES_MASS}_v3,$DATASETS_ZttHbb_base,zh_ztt_hbb,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb_res --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90 \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd "${@:4}"
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZttHbb $res_mass etau $DATASETS_DATA_ETAU &
    makeResonantDatacards_ZttHbb $res_mass mutau $DATASETS_DATA_MUTAU &
    makeResonantDatacards_ZttHbb $res_mass tautau $DATASETS_DATA_TAUTAU &
done

