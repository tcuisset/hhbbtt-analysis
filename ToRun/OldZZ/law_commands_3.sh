###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# [FIXME] inside modulesrdf_ZZ
law run PreprocessRDF --version prod_230724_NewDNN_7 --category-name debug --config-name ul_2018_ZZ_v10 \
    --dataset-name zz_sl_signal \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_ZZ --branch 0
# changed 2021-11-22-0 to 2023-07-24-0 inside the ZZDNN.py module

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

# DNN INPUT
# change way to compute inputs to DNN
# the module doesn't work in the categorization, it's Categorization-feature-modules-file !
# Categorization for DNN inclusive category etau + mutau + tautau: mass cut and signal region
# prod_DNN_Ellipse80_SR_FullFeatSet can be substituted with prod_230828_DNN_Ellipse80_SR_FullFeatSet
law run CategorizationWrapper --version prod_DNN_Ellipse80_SR_FullFeatSet --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top, \
 --Categorization-base-category-name base_selection --Categorization-keep-and-drop-file keep_and_drop_file_DNN_FullFeatSet \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_FullFeatSet

# DNN OUTPUT
# Adding new modul for new DNN application dnn_new_zzbbtt_kl_1
# fixed bug !!!
# Categorization etau + mass cut with new DNN score
law run CategorizationWrapper --version prod_230803 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New
# Categorization mutau + mass cut with new DNN score
law run CategorizationWrapper --version prod_230803 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New
# Categorization tautau + mass cut with new DNN score
law run CategorizationWrapper --version prod_230803 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New

###############################################################################################################################################
###########################################################  FEATURE PLOT  ####################################################################
###############################################################################################################################################

# I will plot dnn_zzbbtt_kl_1, dnn_new_zzbbtt_kl_1, ZZKinFit_mass for the Mini-soutenance plots
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1,dnn_new_zzbbtt_kl_1,ZZ_svfit_mass --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd (--stack) (--log-y)
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1,dnn_new_zzbbtt_kl_1,ZZ_svfit_mass --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd (--stack) (--log-y)
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1,dnn_new_zzbbtt_kl_1,ZZ_svfit_mass --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd (--stack) (--log-y)

###############################################################################################################################################
############################################################  DATACARDS  ######################################################################
###############################################################################################################################################    

law run CreateDatacards --version prod_230803_NewDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_new_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803

law run CreateDatacards --version prod_230803_NewDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_new_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803

law run CreateDatacards --version prod_230803_NewDNNScore --config-name ul_2018_ZZ_v10 --feature-names dnn_new_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803

law run CreateDatacards --version prod_230803_NewDNNScore_Test --config-name ul_2018_ZZ_v10 --feature-names dnn_new_zzbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd True --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --FeaturePlot-version prod_230803_NewDNNScore --PrePlot-version prod_230803_NewDNNScore

###############################################################################################################################################
###########################################################  FEATURE PLOT  ####################################################################
###############################################################################################################################################

# After unblindind
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10  --feature-names ZZ_svfit_mass \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10  --feature-names ZZ_svfit_mass \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10  --feature-names ZZ_svfit_mass \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack

# Plot all DNN input variables signal vs background
law run CategorizationWrapper --version prod_230828_DNN_Ellipse80_SR_FullFeatSet --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top, \
 --Categorization-base-category-name base_selection --Categorization-keep-and-drop-file keep_and_drop_file_DNN_FullFeatSet \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_FullFeatSet
law run FeaturePlot --version prod_230830_DNN_Ellipse80_SR_FullFeatSet --category-name ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl,boosted,is_vbf,jet_1_quality,jet_2_quality \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230828_DNN_Ellipse80_SR_FullFeatSet --region-name os_iso \
 --workers 50 --PreprocessRDF-version prod_230718 --PrePlot-skip-merging \
 --process-group-name zz_sig_vs_bkg --save-root --save-png
 (--process-group-name zz_total --save-root --save-png) (--stack) (--log-y) (--hide-data False)

# Plot interesting variable for data-MC agreement
law run FeaturePlot --version prod_230830_DataMC --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZ_svfit_mass,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_pt,ZZ_mass,ZZ_eta,ZZ_phi,ZZ_pt,Ztt_met_mass,Ztt_met_eta,Ztt_met_phi,Ztt_met_pt,Ztt_mass,Ztt_eta,Ztt_phi,Ztt_pt,Zbb_mass,Zbb_eta,Zbb_phi,Zbb_phi,Zbb_pt,ZZKinFit_mass,ZZKinFit_chi2,Ztt_svfit_mass,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,lep2_pt,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230830_DataMC --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZ_svfit_mass,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_pt,ZZ_mass,ZZ_eta,ZZ_phi,ZZ_pt,Ztt_met_mass,Ztt_met_eta,Ztt_met_phi,Ztt_met_pt,Ztt_mass,Ztt_eta,Ztt_phi,Ztt_pt,Zbb_mass,Zbb_eta,Zbb_phi,Zbb_phi,Zbb_pt,ZZKinFit_mass,ZZKinFit_chi2,Ztt_svfit_mass,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,lep2_pt,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230830_DataMC --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZ_svfit_mass,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_pt,ZZ_mass,ZZ_eta,ZZ_phi,ZZ_pt,Ztt_met_mass,Ztt_met_eta,Ztt_met_phi,Ztt_met_pt,Ztt_mass,Ztt_eta,Ztt_phi,Ztt_pt,Zbb_mass,Zbb_eta,Zbb_phi,Zbb_phi,Zbb_pt,ZZKinFit_mass,ZZKinFit_chi2,Ztt_svfit_mass,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,lep2_pt,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack



##################################################### SMP-VV #####################################################

# HHBBTT version
law run FeaturePlot --version prod_230929_HHBBTT --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230929_HHBBTT --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_230929_HHBBTT --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack

# SMP-VV version (Wjets selection + chi2 > 0)
# Categorization etau + mass cut with new DNN score
law run CategorizationWrapper --version prod_231002 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New
# Categorization mutau + mass cut with new DNN score
law run CategorizationWrapper --version prod_231002 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New
# Categorization tautau + mass cut with new DNN score
law run CategorizationWrapper --version prod_231002 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New

# test large range pt
law run FeaturePlot --version prod_231002 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names b_1_pT_1,b_1_pT_2,b_1_pT_3 \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack

law run FeaturePlot --version prod_231002_noWjetscut --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names b_1_pT_1,b_1_pT_2,b_1_pT_3 \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack


law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack
