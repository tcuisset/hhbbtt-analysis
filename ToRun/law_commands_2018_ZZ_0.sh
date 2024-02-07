
###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES: DONE
###############################################################################################################################################

# DONE
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES: DONE
###############################################################################################################################################

# DONE
law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary \
 --workers 50 --PreCounter-weights-file weights \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --PreCounter-weights-file weights \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZZ_v10 \
 --dataset-tags secondary \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

# RUNNING IN LOCAL
law run CategorizationWrapper --version prod_240207 --category-names base --config-name ul_2018_ZZ_v10 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

# RUNNING IN LOCAL
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# RUNNING
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v10 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# RUNNING TMUX 5
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2018_ZZ_v10 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# RUNNING
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

# test
law run FeaturePlot2D --version prod_240206_test --PrePlot2D-version prod_240206_test --category-name base --config-name ul_2018_ZZ_v10 \
 --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --dataset-names zz_sl_signal \
 --process-group-name zz_sig_vs_bkg --save-root --save-png --stack

law run FeaturePlot2D --version prod_231222 --PrePlot2D-version prod_231222 --category-name base --config-name ul_2018_ZH_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names zh_ztt_hbb_sl_signal,zh_zbb_htt_sl_signal,zh_hbb_zll_background,zh_htt_background,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top \
    --process-group-name zh_split_signal --save-root --save-png --stack

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
 --region-name etau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data False --stack
law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
 --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data False --stack

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run FeaturePlot --version prod_240207 --PrePlot-version prod_240207 --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm \
 --workers 20 --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'