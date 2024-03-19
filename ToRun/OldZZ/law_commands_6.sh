###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# PreprocessRDF with all variables of interest with all MC samples
law run PreprocessRDFWrapper --version prod_231005 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,vbf_htt,ggH_ZZ,ggf_sm,zz_sl_signal \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
# PreprocessRDF with all variables of interest with all data samples
law run PreprocessRDFWrapper --version prod_231005 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

# PreCounterWrapper
law run PreCounterWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights --dataset-tags secondary \
 --workers 50 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary --workers 30 --PreCounter-weights-file weights
law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

# Categorization etau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,vbf_htt,ggH_ZZ,ggf_sm,zz_sl_signal,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
# Categorization mutau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,vbf_htt,ggH_ZZ,ggf_sm,zz_sl_signal,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
# Categorization tautau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,vbf_htt,ggH_ZZ,ggf_sm,zz_sl_signal,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

#################################################################################################################################
#################################################################################################################################
#################################################################################################################################

# FeaturePlot kinematic variables
law run FeaturePlot --version prod_231106 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231106 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231106 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack

# FeaturePlot DNN
law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True (--stack) (--log-y)
law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True (--stack) (--log-y)

###############################################################################################################################################
#############################################################  ANALYSIS  ######################################################################
###############################################################################################################################################

law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True
law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True
law run FeaturePlot --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True

law run FeaturePlotSyst --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd
law run FeaturePlotSyst --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso --do-qcd
law run FeaturePlotSyst --version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso --do-qcd

law run CreateDatacards --version prod_231107 --FeaturePlot-version prod_231107 --PrePlot-version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data True
law run CreateDatacards --version prod_231107 --FeaturePlot-version prod_231107 --PrePlot-version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True
law run CreateDatacards --version prod_231107 --FeaturePlot-version prod_231107 --PrePlot-version prod_231107 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name datacard_zz --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True

cd /data_CMS/cms/vernazza/FrameworkNanoAOD/CombineTests/CMSSW_11_3_4/src/SignalStrengthPlotting
cmsenv

python3 run_combine.py --ver prod_231107 --ch etau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231107 --ch mutau --feat dnn_ZZbbtt_kl_1
python3 run_combine.py --ver prod_231107 --ch tautau --feat dnn_ZZbbtt_kl_1
python3 combination.py --ver prod_231107 --feat dnn_ZZbbtt_kl_1

'''
Version:
hhbbtt-analysis: 392e2c0 (HEAD -> main) schange in setup for job submission
nanoaod_base_analysis: 7360409 (HEAD -> py3) update systematics file for ZZbbtautau analysis
'''