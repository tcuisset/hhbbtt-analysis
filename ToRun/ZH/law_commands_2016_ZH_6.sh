###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# RUNNING TMUX 2
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2016_ZbbHtt_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2016_ZttHbb_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2016_ZbbHtt_v12 \
 --dataset-tags secondary,res \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2016_ZttHbb_v12 \
 --dataset-tags secondary,res \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240312 --category-names base,ZbbHtt_elliptical_cut_90_sr --config-name ul_2016_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 30

# RUNNING TMUX 2
law run CategorizationWrapper --version prod_240312 --category-names base,ZttHbb_elliptical_cut_90_sr --config-name ul_2016_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 30

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240312_DNNinput --category-names ZbbHtt_elliptical_cut_90_sr --config-name ul_2016_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 20

# 
law run CategorizationWrapper --version prod_240312_DNNinput --category-names ZttHbb_elliptical_cut_90_sr --config-name ul_2016_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 20

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240318 --config-name ul_2016_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res --category-names ZbbHtt_elliptical_cut_90_CR_etau,ZbbHtt_elliptical_cut_90_CR_mutau,ZbbHtt_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 5

# 
law run CategorizationWrapper --version prod_240318 --config-name ul_2016_ZttHbb_v12 \
 --skip-dataset-tags secondary,res --category-names ZttHbb_elliptical_cut_90_CR_etau,ZttHbb_elliptical_cut_90_CR_mutau,ZttHbb_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --Categorization-tasks-per-job 5

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run CategorizationWrapper --version prod_240327 --config-name ul_2016_ZbbHtt_v12 \
 --skip-dataset-tags secondary --category-names ZbbHtt_elliptical_cut_90_etau,ZbbHtt_elliptical_cut_90_mutau,ZbbHtt_elliptical_cut_90_tautau \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 100 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,priority=-5' --Categorization-tasks-per-job 3


law run CategorizationWrapper --version prod_240327 --config-name ul_2016_ZttHbb_v12 \
 --skip-dataset-tags secondary --category-names ZttHbb_elliptical_cut_90_etau,ZttHbb_elliptical_cut_90_mutau,ZttHbb_elliptical_cut_90_tautau \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 100 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,priority=-5' --Categorization-tasks-per-job 3


###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################

###############################################################################################################################################
# PLOT ELLIPTICAL MASS CUT
###############################################################################################################################################
 
# 
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2016_ZbbHtt_v12 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 10  --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack

law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2016_ZttHbb_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Hbb_mass_ellipse --workers 20  --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack



law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZbbHtt_elliptical_cut_90_sr --config-name ul_2016_ZbbHtt_v12 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 10 --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZttHbb_elliptical_cut_90_sr --config-name ul_2016_ZttHbb_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Hbb_mass_ellipse --workers 10 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack


###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################
source setup.sh
# datasets common to nonres and res. Not to be used by itself, use _res or _nonres versions
DATASETS_ZbbHtt_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_zbb_htt_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top

DATASETS_ZbbHtt_nonres=zh_zbb_htt_signal,$DATASETS_ZbbHtt_base
# zh_zbb_htt goes at the end to not mess up the legend order
DATASETS_ZbbHtt_res=Zprime_Zh_Zbbhtautau_M500_v3,Zprime_Zh_Zbbhtautau_M1000_v3,Zprime_Zh_Zbbhtautau_M2000_v3,$DATASETS_ZbbHtt_base,zh_zbb_htt
# remove 3,4TeV point as no statistics
#Zprime_Zh_Zbbhtautau_M3000_v3,Zprime_Zh_Zbbhtautau_M4000_v3

DATASETS_ZttHbb_base=dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
tt_dl,tt_sl,tt_fh,zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_ztt_hbb_background,zh_hbb,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_ZttHbb_nonres=zh_ztt_hbb_signal,$DATASETS_ZttHbb_base
DATASETS_ZttHbb_res=Zprime_Zh_ZtautauHbb_M500_v3,Zprime_Zh_ZtautauHbb_M1000_v3,Zprime_Zh_ZtautauHbb_M2000_v3,$DATASETS_ZttHbb_base,zh_ztt_hbb
#Zprime_Zh_ZtautauHbb_M3000_v3,Zprime_Zh_ZtautauHbb_M4000_v3

DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c
declare -a logCommands=("" "--log-y")

# features to plots
# dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
# Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt

function featurePlotZbbHtt_CR {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3

    law run FeaturePlot --version prod_240404 --PrePlot-version prod_240404 --config-name ul_2016_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,\
Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 --MergeCategorization-version prod_240318 \
 --process-group-name plot --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_CR_$REGION_NAME --region-name $REGION_NAME\_os_iso \
 --save-yields --stack --do-qcd --hide-data False $LOG_PARAMS "${@:4}"
}

featurePlotZbbHtt_CR etau $DATASETS_DATA_ETAU &
featurePlotZbbHtt_CR mutau $DATASETS_DATA_MUTAU &
featurePlotZbbHtt_CR tautau $DATASETS_DATA_TAUTAU &

function featurePlotZttHbb_CR {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3

    law run FeaturePlot --version prod_240404 --PrePlot-version prod_240404 --config-name ul_2016_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Hbb_pt,Hbb_eta,Hbb_phi,Hbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names $DATASETS_ZttHbb_nonres,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 --MergeCategorization-version prod_240318 \
 --process-group-name plot --save-root --save-png --category-name ZttHbb_elliptical_cut_90_CR_$REGION_NAME --region-name $REGION_NAME\_os_iso \
 --save-yields --stack --do-qcd --hide-data False $LOG_PARAMS "${@:4}"
}

featurePlotZttHbb_CR etau $DATASETS_DATA_ETAU &
featurePlotZttHbb_CR mutau $DATASETS_DATA_MUTAU &
featurePlotZttHbb_CR tautau $DATASETS_DATA_TAUTAU &



###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################
############ Non-resonant plots
function featurePlotZbbHtt_SR {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240403_nonres --PrePlot-version prod_240403 --config-name ul_2016_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Htt_svfit_pt,Htt_svfit_eta,Htt_svfit_phi,Htt_svfit_mass,\
Htt_met_pt,Htt_met_eta,Htt_met_phi,Htt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names $DATASETS_ZbbHtt_nonres,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 --MergeCategorization-version prod_240327 \
 --process-group-name plot --save-root --save-png --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso \
 --save-yields --stack --do-qcd --hide-data True --multiply-signals-normalization 1000. "${@:3}"
}

featurePlotZbbHtt_SR etau $DATASETS_DATA_ETAU 
featurePlotZbbHtt_SR mutau $DATASETS_DATA_MUTAU 
featurePlotZbbHtt_SR tautau $DATASETS_DATA_TAUTAU 

function featurePlotZttHbb_SR {
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run FeaturePlot --version prod_240403_nonres --PrePlot-version prod_240403 --config-name ul_2016_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_chi2,ZHKinFit_mass,ZHKinFit_highmass,ZH_svfit_pt,ZH_svfit_eta,ZH_svfit_phi,ZH_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Hbb_pt,Hbb_eta,Hbb_phi,Hbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names $DATASETS_ZttHbb_nonres,$DATASETS_DATA \
 --workers 10 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 --MergeCategorization-version prod_240327 \
 --process-group-name plot --save-root --save-png --category-name ZttHbb_elliptical_cut_90_$REGION_NAME --region-name ${REGION_NAME}_os_iso  \
 --save-yields --stack --do-qcd --hide-data True --multiply-signals-normalization 1000. "${@:3}"
}

featurePlotZttHbb_SR etau $DATASETS_DATA_ETAU 
featurePlotZttHbb_SR mutau $DATASETS_DATA_MUTAU  
featurePlotZttHbb_SR tautau $DATASETS_DATA_TAUTAU



###############################################################################################################################################
############################################################  Datacards  #################################################################
###############################################################################################################################################
########### Non-resonant
# We use Categorization prod_240327 as prod_240329 does not exist since we don't have resonant samples for 2016-2017 yet
function makeNonResonantDatacards_ZbbHtt(){
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run CreateDatacards --version prod_240403_nonres --FeaturePlot-version prod_240403_nonres --PrePlot-version prod_240403 --config-name ul_2016_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240327 --Categorization-version prod_240327  \
 --dataset-names "$DATASETS_ZbbHtt_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZbbHtt etau $DATASETS_DATA_ETAU
makeNonResonantDatacards_ZbbHtt mutau $DATASETS_DATA_MUTAU
makeNonResonantDatacards_ZbbHtt tautau $DATASETS_DATA_TAUTAU

# ZttHbb
function makeNonResonantDatacards_ZttHbb(){
    REGION_NAME=$1
    DATASETS_DATA=$2

    law run CreateDatacards --version prod_240403_nonres --FeaturePlot-version prod_240403_nonres --PrePlot-version prod_240403 --config-name ul_2016_ZttHbb_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 20 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240327 --Categorization-version prod_240327  \
 --dataset-names "$DATASETS_ZttHbb_nonres,$DATASETS_DATA" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_$REGION_NAME \
 --region-name ${REGION_NAME}_os_iso --do-qcd --hide-data True --propagate-syst-qcd
}

makeNonResonantDatacards_ZttHbb etau $DATASETS_DATA_ETAU
makeNonResonantDatacards_ZttHbb mutau $DATASETS_DATA_MUTAU
makeNonResonantDatacards_ZttHbb tautau $DATASETS_DATA_TAUTAU

