# From now on we have two datasets for the same ZZbbtt process:
# - zz_sl_signal (isSignal = True): used for SM interpretations (Cross Section measurement)
# - zz_bbtt (isSignal = False): used for BSM interpretations (Resonance search)

###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

law run PreprocessRDFWrapper --version prod_231005 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --PreCounter-weights-file weights
law run MergeCategorizationStatsWrapper --version prod_231005 --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu
#  --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
#  --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

# 2D Plot elliptical cut
law run CategorizationWrapper --version prod_231005 --category-names base --config-name ul_2018_ZZ_v10 \
    --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000,zz_sl_signal,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top \
    --Categorization-base-category-name base_selection \
    --workers 50 --PreprocessRDF-version prod_231005 \
    --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
    --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DNN STUDY
# Categorization for DNN inclusive category etau + mutau + tautau: mass cut and signal region
law run CategorizationWrapper --version prod_230828_DNN_Ellipse80_SR_FullFeatSet --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000,zz_sl_signal,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top \
 --Categorization-base-category-name base_selection --Categorization-keep-and-drop-file keep_and_drop_file_DNN_FullFeatSet \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_DNN_FullFeatSet \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# Categorization etau/mutau/tautau + mass cut with all systematics
law run CategorizationWrapper --version prod_231005 --category-names ZZ_elliptical_cut_80_etau,ZZ_elliptical_cut_80_mutau,ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_231005 --Categorization-feature-modules-file modulesrdf_ZZ_syst \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

#################################################################################################################################
#################################################################################################################################
#################################################################################################################################

# Plot for the datacards (zz_bbtt among backgrounds) "datacard_zz_res"
law run FeaturePlot --version prod_231214 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,ZZKinFit_highmass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --do-qcd --stack \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_231214 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,ZZKinFit_highmass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --do-qcd --stack \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_231214 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,ZZKinFit_highmass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --do-qcd --stack \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# Plot for the signal only 
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack (--log-y)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack (--log-y)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack (--log-y)
# Plot for the signal only high mass
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1400,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack (--log-y)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1400,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack (--log-y)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1400,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack (--log-y)

# Plot for the paper low mass only (zz_bbtt among backgrounds) "zz_res"
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_mass,dnn_ZZbbtt_kl_1 \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)
# Plot for the paper high mass (zz_bbtt among backgrounds) "zz_res"
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,ggXZZbbtt_M1100,ggXZZbbtt_M1300,ggXZZbbtt_M1500,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,ggXZZbbtt_M1100,ggXZZbbtt_M1300,ggXZZbbtt_M1500,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)
law run FeaturePlot --version prod_231215 --PrePlot-version prod_231214 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names ZZKinFit_highmass \
 --dataset-names ggXZZbbtt_M500,ggXZZbbtt_M700,ggXZZbbtt_M900,ggXZZbbtt_M1100,ggXZZbbtt_M1300,ggXZZbbtt_M1500,zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
 --workers 50 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --do-qcd --stack (--log-y) (--normalize-signals)

law run FeaturePlot --version prod_231216 --PrePlot-version prod_231216 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names boosted \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack
law run FeaturePlot --version prod_231216 --PrePlot-version prod_231216 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names boosted \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack
law run FeaturePlot --version prod_231216 --PrePlot-version prod_231216 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names boosted \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 100 --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack


#################################################################################################################################
#################################################################################################################################
#################################################################################################################################

# Create Datacards

cd /data_CMS/cms/vernazza/FrameworkNanoAOD/CombineTests/CMSSW_11_3_4/src/RunCombineZZbbtautau
python3 LaunchDatacarads.py --ver prod_231214 --ch etau,mutau,tautau \
 --feat ZZKinFit_mass,ZZKinFit_highmass,dnn_ZZbbtt_kl_1 \
 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,2000,3000

#################################################################################################################################
#################################################################################################################################
#################################################################################################################################

# FeaturePlot kinematic variables

cd /data_CMS/cms/vernazza/FrameworkNanoAOD/CombineTests/CMSSW_11_3_4/src/RunCombineZZbbtautau
cmsenv

python3 RunAsymptoticLimits.py --ver prod_231214 --feat ZZKinFit_mass --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,2000,3000
python3 RunAsymptoticLimits.py --ver prod_231214 --feat ZZKinFit_highmass --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,2000,3000
python3 RunAsymptoticLimits.py --ver prod_231214 --feat dnn_ZZbbtt_kl_1 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,2000,3000

python3 PlotAsymptoticLimits.py --ver prod_231214 --feat dnn_ZZbbtt_kl_1 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,2000,3000 --ch combination


##################################################################################################################################
##################################################################################################################################
##################################################################################################################################

law run FeaturePlot2D --version prod_231218 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names zz_bbtt,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zz_sl_background,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M200 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M200 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M300 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M300 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M400 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M400 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M500 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M500 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M600 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M600 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M700 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M700 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M800 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M800 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M900 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M900 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1000 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1000 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1100 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1100 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1200 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1200 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1300 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1300 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1400 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1400 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M1500 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M1500 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M2000 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M2000 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_231218/ggXZZbbtt_M3000 --PrePlot2D-version prod_231218 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
    --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_231005 --Categorization-version prod_231005 \
    --dataset-names ggXZZbbtt_M3000 \
    --process-group-name zz_sig_vs_bkg --save-root --save-png --stack

###########################################################################################################################################################
###########################################################################################################################################################
###########################################################################################################################################################

# to check the merging for the cut flow approach
law run MergeCutFlow --version prod_231220 --category-name base_selection --config-name ul_2018_ZZ_v10 --dataset-name ggXZZbbtt_M200 \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --PreprocessRDF-compute-filter-efficiency True

law run MergeCutFlowWrapper --version prod_231220 --category-names base_selection --config-name ul_2018_ZZ_v10 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_ZZ --PreprocessRDF-modules-file modulesrdf_ZZ --PreprocessRDF-compute-filter-efficiency True \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'