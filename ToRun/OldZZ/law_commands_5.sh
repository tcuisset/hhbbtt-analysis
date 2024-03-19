###############################################################################################################################################

# In the new version the PreProcess I will compute all the variables up to DNN inputs
# I will add the rest (systematics) in the categorization, since it's smoother and faster

###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# Old
PreprocessRDFWrapper: prod_230718
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file 
 --PreprocessRDF-modules-file modulesrdf_ZZ
# New
PreprocessRDFWrapper: prod_231005
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ
 --PreprocessRDF-modules-file modulesrdf_ZZ

[TEST]
law run PreprocessRDF --version prod_231003 --category-name debug --config-name ul_2018_ZZ_v10 --dataset-name zz_sl_signal \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --branch 0

# PreprocessRDF with all variables of interest with all MC samples
law run PreprocessRDFWrapper --version prod_231005 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# PreprocessRDF with all variables of interest with all data samples
law run PreprocessRDFWrapper --version prod_231005 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

# Old
MergeCategorizationStatsWrapper: prod_230718 
 --PreCounter-weights-file weights
# New
MergeCategorizationStatsWrapper: prod_231005 
 --PreCounter-weights-file weights (auxiliary?)

# PreCounterWrapper
law run PreCounterWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal \
 --workers 50 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run PreCounterWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights --dataset-tags secondary \
 --workers 50 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# MergeCategorizationStatsWrapper
# law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
#  --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal \
#  --workers 30 --PreCounter-weights-file weights
law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary --workers 30 --PreCounter-weights-file weights


###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

Do NOT remove the category for the DNN training: cat_ZZ_elliptical_cut_80_sr/prod_230828_DNN_Ellipse80_SR_FullFeatSet

# Old
CategorizationWrapper: prod_230803
 --PreprocessRDF-keep-and-drop-file None
 --PreprocessRDF-modules-file modulesrdf_DNN_New
# New
CategorizationWrapper: prod_231005
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ
 --PreprocessRDF-modules-file modulesrdf_ZZ_syst

# Categorization etau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
# Categorization mutau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
# Categorization tautau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_sl_signal,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
###########################################################  FEATURE PLOT  ####################################################################
###############################################################################################################################################

# FeaturePlot kinematic variables
law run FeaturePlot --version prod_231005 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231005 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231005 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack

# FeaturePlot DNN
law run FeaturePlot --version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True (--stack) (--log-y)

# Feature plot syst (to be fixed adding statistical uncertainties)
law run FeaturePlotSyst --version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets \
 --Categorization-version prod_231005 --process-group-name zz \
 --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --stack --hide-data False

###############################################################################################################################################
#############################################################  ANALYSIS  ######################################################################
###############################################################################################################################################

# Datacard for DNN score
law run CreateDatacards --version prod_231019 --config-name ul_2018_ZZ_v10 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231019 --PrePlot-version prod_231019
law run CreateDatacards --version prod_231019 --config-name ul_2018_ZZ_v10 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231019 --PrePlot-version prod_231019
law run CreateDatacards --version prod_231019 --config-name ul_2018_ZZ_v10 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231019 --PrePlot-version prod_231019

# Datacard for ZZ mass
law run CreateDatacards --version prod_231005 --config-name ul_2018_ZZ_v10 --feature-names ZZKinFit_mass \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231005 --PrePlot-version prod_231005
law run CreateDatacards --version prod_231005 --config-name ul_2018_ZZ_v10 --feature-names ZZKinFit_mass \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231005 --PrePlot-version prod_231005
law run CreateDatacards --version prod_231005 --config-name ul_2018_ZZ_v10 --feature-names ZZKinFit_mass \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd True \
 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --FeaturePlot-version prod_231005 --PrePlot-version prod_231005

###############################################################################################################################################
#############################################################  COMBINE  #######################################################################
###############################################################################################################################################

cd /data_CMS/cms/vernazza/FrameworkNanoAOD/CombineTests/CMSSW_11_3_4/src/SignalStrengthPlotting
cmsenv

python3 run_combine.py --ver prod_231019 --ch etau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231019 --ch mutau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231019 --ch tautau --feat dnn_ZZbbtt_kl_1
python3 combination.py --ver prod_231019 --feat dnn_ZZbbtt_kl_1

python3 run_combine.py --ver prod_231005 --ch etau --feat ZZKinFit_mass
python3 run_combine.py --ver prod_231005 --ch mutau --feat ZZKinFit_mass
python3 run_combine.py --ver prod_231005 --ch tautau --feat ZZKinFit_mass
python3 combination.py --ver prod_231005 --feat ZZKinFit_mass

###############################################################################################################################################
###############################################################################################################################################
###############################################################################################################################################

# For the FeaturPlot I will create two config files:
# - ul_2018_ZZ_v10 (using the normal precounter)
# - ul_2018_ZZ_v10_aux (using the aux precounter)

# ###################### TEST JOB SUBMISSION ######################

law run PreprocessRDF --version local --category-name base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-name zz_sl_signal --PreprocessRDF-modules-file modulesrdf_test --workers 20 --branch 0
# 10 min

law run PreprocessRDF --version condor --category-name base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-name zz_sl_signal --PreprocessRDF-modules-file modulesrdf_test --workers 20 \
 --workflow htcondor --htcondor-scheduler llrt3condor.in2p3.fr --transfer-logs \
 --custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# 10 min

law run PreCounter --version prod_231005 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights --dataset-name zz_sl_signal_aux \
 --workers 50 --PreCounter-workflow local

law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary --workers 50 --PreCounter-weights-file weights --systematic-names pu

law run FeaturePlot --version prod_test --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --stack

law run FeaturePlot --version prod_test_1 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --stack --normalize-signals False

law run FeaturePlot --version prod_test_3 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --stack --normalize-signals False --qcd-sym-shape True

law run FeaturePlot --version prod_test_4 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --stack --normalize-signals False --qcd-sym-shape True --save-yields True \
 --propagate-syst-qcd True

###############

law run FeaturePlotSyst --version prod_test_4 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz \
 --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --stack --qcd-sym-shape True --do-qcd \
 --propagate-syst-qcd True --do-qcd

###############

law run CreateDatacards --version prod_test_5 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10  --feature-names dnn_ZZbbtt_kl_1 --workers 80 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005   --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d  --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau  --region-name etau_os_iso --do-qcd --hide-data True --stack --normalize-signals False --qcd-sym-shape True --save-yields True --propagate-syst-qcd True

###############################################################################################################################################
###############################################################################################################################################

###############################################################################################################################################
###############################################################################################################################################

###############################################################################################################################################
###############################################################################################################################################

###############################################################################################################################################
########################################################  WITH QCD PROPAGATION  ###############################################################
###############################################################################################################################################

# FeaturePlot DNN
law run FeaturePlot --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True (--stack) (--log-y)

# Feature plot syst (to be fixed adding statistical uncertainties)
law run FeaturePlotSyst --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd
law run FeaturePlotSyst --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd
law run FeaturePlotSyst --version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd

# Datacard for DNN score
law run CreateDatacards --version prod_231102 --FeaturePlot-version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True
law run CreateDatacards --version prod_231102 --FeaturePlot-version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True
law run CreateDatacards --version prod_231102 --FeaturePlot-version prod_231102 --PrePlot-version prod_231019 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True

cd /data_CMS/cms/vernazza/FrameworkNanoAOD/CombineTests/CMSSW_11_3_4/src/SignalStrengthPlotting
cmsenv

python3 run_combine.py --ver prod_231102 --ch etau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231102 --ch mutau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231102 --ch tautau --feat dnn_ZZbbtt_kl_1
python3 combination.py --ver prod_231102 --feat dnn_ZZbbtt_kl_1

 ### INFO: Results for etau
 ### p-value     =  0.00010780403339304962
 ### significane =  3.6999898922590986

 ### INFO: Results for mutau
 ### p-value     =  3.4883274061737904e-07
 ### significane =  4.962012378098121

 ### INFO: Results for tautau
 ### p-value     =  4.257737005355693e-06
 ### significane =  4.451796772649497
