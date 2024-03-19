########### FOR THE DNN TRAINING ###########

###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# PreprocessRDF with only DNN variables: the modulesrdf_DNN is the same as modulesrdf_ZZ (whitout the DNN output) but includes EllipticalCut filtering
# law run PreprocessRDFWrapper --version prod_DNN_Ellipse80 --category-name base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_DNN --PreprocessRDF-modules-file modulesrdf_DNN --workers 20 --PreprocessRDF-workflow htcondor \
#     --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
#     --PreprocessRDF-transfer-logs

# PreprocessRDF with all default variables of interest
law run PreprocessRDFWrapper --version prod_230718 --category-names base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_ZZ --workers 20 --PreprocessRDF-workflow htcondor \
    --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
    --PreprocessRDF-transfer-logs

law run PreprocessRDFWrapper --version prod_230718 --category-names base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_ZZ --workers 20 --PreprocessRDF-workflow htcondor \
    --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7' \
    --PreprocessRDF-transfer-logs

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

# PreCounterWrapper
law run PreCounterWrapper --version prod_230718 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights \
 --workers 20 --dataset-tags secondary --PreCounter-workflow local

# MergeCategorizationStatsWrapper
law run MergeCategorizationStatsWrapper --version prod_230718 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary --workers 30 --PreCounter-weights-file weights

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

# Categorization for DNN inclusive category etau + mutau + tautau: mass cut and signal region
law run CategorizationWrapper --version prod_DNN_Ellipse80_SR --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top, \
 --Categorization-base-category-name base_selection --Categorization-keep-and-drop-file keep_and_drop_file_DNN \
 --workers 50 --PreprocessRDF-version prod_230718

# Categorization etau + mass cut with old DNN score
law run CategorizationWrapper --version prod_230718 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718
# Categorization mutau + mass cut with old DNN score
law run CategorizationWrapper --version prod_230718 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718
# Categorization tautau + mass cut with old DNN score
law run CategorizationWrapper --version prod_230718 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718

###############################################################################################################################################
###########################################################  FEATURE PLOT  ####################################################################
###############################################################################################################################################

# Plot of the dnn input features to check the application of weights
law run FeaturePlot --version prod_DNN_Ellipse80_SR --category-name ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --feature-names CvsB_b1,CvsL_b1,ZZKinFit_chi2,ZZKinFit_mass,Ztt_mass,dR_l1_l2_x_sv_pT,dau1_mt,dau2_pt,dR_l1_l2,dphi_sv_met,Zbb_mass,HHbtag_b2,ZZ_svfit_mass,dphi_Zbb_sv,Zbb_pt,dR_l1_l2_boosted_Ztt_met,dau1_pt,dnn_bjet1_pt,Phi,costheta_l2_Zttmet \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 --region-name os_iso \
 --workers 50 --PreprocessRDF-version prod_230718 --PrePlot-skip-merging \
 --process-group-name zz_total --save-root --save-png --hide-data True --stack
#  --PrePlot-workflow llrt3condor.in2p3.fr --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \ \

# Plot of the dnn input features to check the application of weights with unified background samples
law run FeaturePlot --version prod_DNN_Ellipse80_SR --category-name ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --feature-names CvsB_b1,CvsL_b1,ZZKinFit_chi2,ZZKinFit_mass,Ztt_mass,dR_l1_l2_x_sv_pT,dau1_mt,dau2_pt,dR_l1_l2,dphi_sv_met,Zbb_mass,HHbtag_b2,ZZ_svfit_mass,dphi_Zbb_sv,Zbb_pt,dR_l1_l2_boosted_Ztt_met,dau1_pt,dnn_bjet1_pt,Phi,costheta_l2_Zttmet \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 --region-name os_iso \
 --workers 50 --PreprocessRDF-version prod_230718 --PrePlot-skip-merging \
 --process-group-name zz_sig_vs_bkg --save-root --save-png --hide-data True

# Plot of the old DNN score in the SR (etau, mutau, tautau)
law run FeaturePlot --version prod_230718_OldDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1 --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top \
 --process-group-name zz_total --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso (--stack) (--log-y)
#  --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso (--stack) (--log-y)
#  --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso (--stack) (--log-y)

# Plot of the old DNN score including QCD background: etau
law run FeaturePlot --version prod_230718_OldDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1 --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --stack --do-qcd (--log-y)
# Plot of the old DNN score including QCD background: mutau
law run FeaturePlot --version prod_230718_OldDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1 --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --stack --do-qcd (--log-y)
# Plot of the old DNN score including QCD background: tautau
law run FeaturePlot --version prod_230718_OldDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1 --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --stack --do-qcd (--log-y)

###############################################################################################################################################
############################################################  DATACARDS  ######################################################################
###############################################################################################################################################    

law run CreateDatacards --version prod_230718_OldDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718

law run CreateDatacards --version prod_230718_OldDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718

law run CreateDatacards --version prod_230718_OldDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230718