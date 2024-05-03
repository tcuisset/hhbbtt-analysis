# Redoing plotting with categorization prod_240329 but with L1prefiringweight
YEAR=2018

source setup.sh

DATASETS_ZbbHtt_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top

DATASETS_ZbbHtt_nonres=zh_zbb_htt_signal,$DATASETS_ZbbHtt_base
# zh_zbb_htt goes at the end to not mess up the legend order
RES_MASSES="500 1000 2000"
DATASETS_ZbbHtt_res=Zprime_Zh_Zbbhtautau_M500_v3,Zprime_Zh_Zbbhtautau_M1000_v3,Zprime_Zh_Zbbhtautau_M2000_v3,$DATASETS_ZbbHtt_base,zh_zbb_htt
# remove 3,4TeV point as no statistics
#Zprime_Zh_Zbbhtautau_M3000_v3,Zprime_Zh_Zbbhtautau_M4000_v3

DATASETS_ZttHbb_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_ZttHbb_nonres=zh_ztt_hbb_signal,$DATASETS_ZttHbb_base
DATASETS_ZttHbb_res=Zprime_Zh_Ztautauhbb_M500_v3,Zprime_Zh_Ztautauhbb_M1000_v3,Zprime_Zh_Ztautauhbb_M2000_v3,$DATASETS_ZttHbb_base,zh_ztt_hbb
#Zprime_Zh_Ztautauhbb_M3000_v3,Zprime_Zh_Ztautauhbb_M4000_v3

# put all possible data_*_*, in case it does not exist for a year it just gets ignored
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e 
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e


FEATURES_SR=dnn_ZHbbtt_kl_1,ZHKinFit_mass
FEATURES_CR=dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,\
Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################


function featurePlotZbbHtt_CR {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240417 --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $FEATURES_CR \
 --dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 --MergeCategorization-version prod_240318 \
 --process-group-name plot --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_CR_$REGION_NAME --region-name $REGION_NAME\_os_iso \
 --save-yields --stack --do-qcd --hide-data False "${@:3}"
}

featurePlotZbbHtt_CR etau $DATASETS_DATA_ETAU 
featurePlotZbbHtt_CR mutau $DATASETS_DATA_MUTAU
featurePlotZbbHtt_CR tautau $DATASETS_DATA_TAUTAU 

function featurePlotZttHbb_CR {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240417 --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $FEATURES_CR \
 --dataset-names $DATASETS_ZttHbb_nonres,$DATASETS_DATA \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 --MergeCategorization-version prod_240318 \
 --process-group-name plot --save-root --save-png --category-name ZttHbb_elliptical_cut_90_CR_$REGION_NAME --region-name $REGION_NAME\_os_iso \
 --save-yields --stack --do-qcd --hide-data False "${@:3}"
}

featurePlotZttHbb_CR etau $DATASETS_DATA_ETAU 
featurePlotZttHbb_CR mutau $DATASETS_DATA_MUTAU 
featurePlotZttHbb_CR tautau $DATASETS_DATA_TAUTAU 

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################
############ Non-resonant plots

##### use prod_240329 for 2018 and prod_240327 for all other years

function featurePlotZbbHtt_SR_nonres {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240417_nonres --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $FEATURES_SR \
 --dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA \
 --workers 15 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 --MergeCategorization-version prod_240327 \
 --process-group-name plot --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True "${@:3}"
}
declare -a logCommands=("--multiply-signals-normalization 1000." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZbbHtt_SR_nonres etau $DATASETS_DATA_ETAU $logParams & 
featurePlotZbbHtt_SR_nonres mutau $DATASETS_DATA_MUTAU $logParams & 
featurePlotZbbHtt_SR_nonres tautau $DATASETS_DATA_TAUTAU $logParams & 
wait
done


function featurePlotZttHbb_SR_nonres {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3

    law run FeaturePlot --version prod_240417_nonres --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names $FEATURES_SR \
 --dataset-names $DATASETS_ZttHbb_nonres,$DATASETS_DATA \
 --workers 15 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 --MergeCategorization-version prod_240327 \
 --process-group-name plot --save-root --save-png --category-name ZttHbb_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True $LOG_PARAMS "${@:4}"
}
declare -a logCommands=("--multiply-signals-normalization 1000." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZttHbb_SR_nonres etau $DATASETS_DATA_ETAU $logParams &
featurePlotZttHbb_SR_nonres mutau $DATASETS_DATA_MUTAU $logParams  & 
featurePlotZttHbb_SR_nonres tautau $DATASETS_DATA_TAUTAU $logParams  & 
wait
done



########### Resonant plots
function featurePlotZbbHtt_SR_res {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240417_res --PrePlot-version prod_240417_res --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_500,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,ZHKinFit_mass,ZHKinFit_highmass \
 --dataset-names $DATASETS_ZbbHtt_res,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240329 --MergeCategorization-version prod_240329 \
 --process-group-name plot_res --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True  "${@:3}"
}
declare -a logCommands=("--multiply-signals-normalization 10." "--log-y True --histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
featurePlotZbbHtt_SR_res etau $DATASETS_DATA_ETAU $logParams &
featurePlotZbbHtt_SR_res mutau $DATASETS_DATA_MUTAU $logParams &
featurePlotZbbHtt_SR_res tautau $DATASETS_DATA_TAUTAU $logParams &
wait
done

function featurePlotZttHbb_SR_res {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240417_res --PrePlot-version prod_240417_res --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,dnn_ZHbbtt_kl_1_500,dnn_ZHbbtt_kl_1_1000,dnn_ZHbbtt_kl_1_2000,dnn_ZHbbtt_kl_1_3000,ZHKinFit_mass \
 --dataset-names $DATASETS_ZttHbb_res,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240329 --MergeCategorization-version prod_240329 \
 --process-group-name plot_res --save-root --save-png --category-name ZttHbb_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso \
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
function featurePlotZbbHtt_SR_res_individualMasses {
    REGION_NAME=$1
    DATASETS_DATA=$2

    for mass in $RES_MASSES; do

    law run FeaturePlot --version prod_240417_res_DNN --PrePlot-version prod_240417_res --config-name ul_2018_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$mass \
 --dataset-names Zprime_Zh_Zbbhtautau_M${mass}_v3,$DATASETS_ZbbHtt_base,zh_ztt_hbb,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240329 --MergeCategorization-version prod_240329 \
 --process-group-name plot_res --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME --region-name $REGION_NAME\_os_iso \
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

# Plots parametrized DNN distribution showing only the corresponding resonant sample
# to be run after another featureplot to not mess up PrePlot
function featurePlotZttHbb_SR_res_individualMasses {
    REGION_NAME=$1
    DATASETS_DATA=$2

    for mass in $RES_MASSES; do

    law run FeaturePlot --version prod_240417_res_DNN --PrePlot-version prod_240417_res --config-name ul_2018_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$mass \
 --dataset-names Zprime_Zh_Ztautauhbb_M${mass}_v3,$DATASETS_ZttHbb_base,zh_ztt_hbb,$DATASETS_DATA \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240329 --MergeCategorization-version prod_240329 \
 --process-group-name plot_res --save-root --save-png --category-name ZttHbb_elliptical_cut_90_$REGION_NAME --region-name $REGION_NAME\_os_iso \
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

    law run CreateDatacards --version prod_240418_nonres --FeaturePlot-version prod_240418_nonres --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240327 --Categorization-version prod_240327  \
 --dataset-names "$DATASETS_ZbbHtt_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZbbHtt etau $DATASETS_DATA_ETAU &
makeNonResonantDatacards_ZbbHtt mutau $DATASETS_DATA_MUTAU &
makeNonResonantDatacards_ZbbHtt tautau $DATASETS_DATA_TAUTAU &

# ZttHbb
function makeNonResonantDatacards_ZttHbb(){
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run CreateDatacards --version prod_240418_nonres --FeaturePlot-version prod_240418_nonres --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240327 --Categorization-version prod_240327  \
 --dataset-names "$DATASETS_ZttHbb_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_$REGION_NAME \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZttHbb etau $DATASETS_DATA_ETAU &
makeNonResonantDatacards_ZttHbb mutau $DATASETS_DATA_MUTAU &
makeNonResonantDatacards_ZttHbb tautau $DATASETS_DATA_TAUTAU &



########################### Resonant datacards
# remember to run featurePlot with all the dnns beforehand

function makeResonantDatacards_ZbbHtt {
    RES_MASS=$1
    REGION_NAME=$2
    DATASETS_DATA=$3
    # make datacards for both the parametrized an non-parametrized DNN
    law run CreateDatacards --version prod_240418_M$RES_MASS --FeaturePlot-version prod_240418_M$RES_MASS --PrePlot-version prod_240417_res --config-name ul_2018_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240329 --Categorization-version prod_240329  \
 --dataset-names "Zprime_Zh_Zbbhtautau_M${RES_MASS}_v3,$DATASETS_ZbbHtt_base,zh_zbb_htt,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME \
 --region-name $REGION_NAME\_os_iso --do-qcd --hide-data True --propagate-syst-qcd "${@:4}"
}

for res_mass in 500 1000 2000 3000; do
    makeResonantDatacards_ZbbHtt $res_mass etau $DATASETS_DATA_ETAU &
    makeResonantDatacards_ZbbHtt $res_mass mutau $DATASETS_DATA_MUTAU &
    makeResonantDatacards_ZbbHtt $res_mass tautau $DATASETS_DATA_TAUTAU &
done

function makeResonantDatacards_ZttHbb {
    RES_MASS=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run CreateDatacards --version prod_240418_M$RES_MASS --FeaturePlot-version prod_240418_M$RES_MASS --PrePlot-version prod_240417_res --config-name ul_2018_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1_$RES_MASS,dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240329 --Categorization-version prod_240329  \
 --dataset-names "Zprime_Zh_Ztautauhbb_M${RES_MASS}_v3,$DATASETS_ZttHbb_base,zh_zbb_htt,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb_res --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_$REGION_NAME \
 --region-name $REGION_NAME\_os_iso --do-qcd --hide-data True --propagate-syst-qcd "${@:4}"
}

for res_mass in 500 1000 2000 3000; do
    makeResonantDatacards_ZttHbb $res_mass etau $DATASETS_DATA_ETAU &
    makeResonantDatacards_ZttHbb $res_mass mutau $DATASETS_DATA_MUTAU &
    makeResonantDatacards_ZttHbb $res_mass tautau $DATASETS_DATA_TAUTAU &
done
