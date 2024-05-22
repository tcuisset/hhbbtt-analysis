
###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

YEAR=2018

law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,\
GluGluToXToZZTo2B2Tau_M360_aux,GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,\
GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,\
GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,\
GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,\
GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,GluGluToXToZZTo2B2Tau_M3500_aux,\
GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240312 --category-names base --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240318 --category-names ZZ_elliptical_cut_90_sr --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
# RESONANT ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run CategorizationWrapper --version prod_240430 --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst_resZZ --workers 20 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

law run CategorizationWrapper --version prod_240430_low --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst_resZZ_low --workers 20 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7" \
 --Categorization-poll-interval 5
law run CategorizationWrapper --version prod_240430_high --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst_resZZ_high --workers 20 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7" \
 --Categorization-poll-interval 5

###############################################################################################################################################
# ALL DNN PLOTS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_210,dnn_ZZbbtt_kl_1_220,dnn_ZZbbtt_kl_1_230,dnn_ZZbbtt_kl_1_240,\
dnn_ZZbbtt_kl_1_250,dnn_ZZbbtt_kl_1_260,dnn_ZZbbtt_kl_1_270,dnn_ZZbbtt_kl_1_280,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_320,dnn_ZZbbtt_kl_1_350,\
dnn_ZZbbtt_kl_1_360,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_450,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_550,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_650,\
dnn_ZZbbtt_kl_1_700,dnn_ZZbbtt_kl_1_750,dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_850,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,\
GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,\
GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,GluGluToXToZZTo2B2Tau_M400,\
GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,\
GluGluToXToZZTo2B2Tau_M700,GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,\
GluGluToXToZZTo2B2Tau_M1000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_210,dnn_ZZbbtt_kl_1_220,dnn_ZZbbtt_kl_1_230,dnn_ZZbbtt_kl_1_240,\
dnn_ZZbbtt_kl_1_250,dnn_ZZbbtt_kl_1_260,dnn_ZZbbtt_kl_1_270,dnn_ZZbbtt_kl_1_280,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_320,dnn_ZZbbtt_kl_1_350,\
dnn_ZZbbtt_kl_1_360,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_450,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_550,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_650,\
dnn_ZZbbtt_kl_1_700,dnn_ZZbbtt_kl_1_750,dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_850,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,\
GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,\
GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,GluGluToXToZZTo2B2Tau_M400,\
GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,\
GluGluToXToZZTo2B2Tau_M700,GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,\
GluGluToXToZZTo2B2Tau_M1000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_210,dnn_ZZbbtt_kl_1_220,dnn_ZZbbtt_kl_1_230,dnn_ZZbbtt_kl_1_240,\
dnn_ZZbbtt_kl_1_250,dnn_ZZbbtt_kl_1_260,dnn_ZZbbtt_kl_1_270,dnn_ZZbbtt_kl_1_280,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_320,dnn_ZZbbtt_kl_1_350,\
dnn_ZZbbtt_kl_1_360,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_450,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_550,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_650,\
dnn_ZZbbtt_kl_1_700,dnn_ZZbbtt_kl_1_750,dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_850,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,\
GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,\
GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,GluGluToXToZZTo2B2Tau_M400,\
GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,\
GluGluToXToZZTo2B2Tau_M700,GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,\
GluGluToXToZZTo2B2Tau_M1000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True

law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,\
dnn_ZZbbtt_kl_1_1500,dnn_ZZbbtt_kl_1_1600,dnn_ZZbbtt_kl_1_1700,dnn_ZZbbtt_kl_1_1800,dnn_ZZbbtt_kl_1_1900,dnn_ZZbbtt_kl_1_2000,\
dnn_ZZbbtt_kl_1_2200,dnn_ZZbbtt_kl_1_2400,dnn_ZZbbtt_kl_1_2500,dnn_ZZbbtt_kl_1_2600,dnn_ZZbbtt_kl_1_2800,dnn_ZZbbtt_kl_1_3000,\
dnn_ZZbbtt_kl_1_3500,dnn_ZZbbtt_kl_1_4000,dnn_ZZbbtt_kl_1_4500,dnn_ZZbbtt_kl_1_5000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,\
GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,\
GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,\
GluGluToXToZZTo2B2Tau_M5000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,\
dnn_ZZbbtt_kl_1_1500,dnn_ZZbbtt_kl_1_1600,dnn_ZZbbtt_kl_1_1700,dnn_ZZbbtt_kl_1_1800,dnn_ZZbbtt_kl_1_1900,dnn_ZZbbtt_kl_1_2000,\
dnn_ZZbbtt_kl_1_2200,dnn_ZZbbtt_kl_1_2400,dnn_ZZbbtt_kl_1_2500,dnn_ZZbbtt_kl_1_2600,dnn_ZZbbtt_kl_1_2800,dnn_ZZbbtt_kl_1_3000,\
dnn_ZZbbtt_kl_1_3500,dnn_ZZbbtt_kl_1_4000,dnn_ZZbbtt_kl_1_4500,dnn_ZZbbtt_kl_1_5000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,\
GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,\
GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,\
GluGluToXToZZTo2B2Tau_M5000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240513_rm --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,\
dnn_ZZbbtt_kl_1_1500,dnn_ZZbbtt_kl_1_1600,dnn_ZZbbtt_kl_1_1700,dnn_ZZbbtt_kl_1_1800,dnn_ZZbbtt_kl_1_1900,dnn_ZZbbtt_kl_1_2000,\
dnn_ZZbbtt_kl_1_2200,dnn_ZZbbtt_kl_1_2400,dnn_ZZbbtt_kl_1_2500,dnn_ZZbbtt_kl_1_2600,dnn_ZZbbtt_kl_1_2800,dnn_ZZbbtt_kl_1_3000,\
dnn_ZZbbtt_kl_1_3500,dnn_ZZbbtt_kl_1_4000,dnn_ZZbbtt_kl_1_4500,dnn_ZZbbtt_kl_1_5000 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,\
GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,\
GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,\
GluGluToXToZZTo2B2Tau_M5000,zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True

###############################################################################################################################################
# PLOTS FOR ADVERTISMENT
###############################################################################################################################################

law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_low \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1

for res_mass in 200 400 600 800 1000 ; do
    law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
    law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
    law run FeaturePlot --version prod_240513_low --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1 ;
done


law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high \
 --dataset-names GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high \
 --dataset-names GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res_high \
 --dataset-names GluGluToXToZZTo2B2Tau_M1200,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1

for res_mass in 1200 1500 2000 3000 4000 5000 ; do
    law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
    law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
    law run FeaturePlot --version prod_240513_high --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1 ;
done

###############################################################################################################################################
# DATACARDS
###############################################################################################################################################

for res_mass in 200 210 220 230 240 250 260 280 300 320 350 360 400 450 500 550 600 650 700 750 800 850 900 1000 ; do
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd & 
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_low --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_low,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_low --MergeCategorization-version prod_240510_low \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
done

for res_mass in 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2200 2400 2500 2600 2800 3000 3500 4000 4500 5000 ; do
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd & 
    law run CreateDatacards --version prod_240513_M$res_mass --PrePlot-version prod_240513_high --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res_high,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names GluGluToXToZZTo2B2Tau_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240430_high --MergeCategorization-version prod_240510_high \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
done

###############################################################################################################################################
# COMBINE
###############################################################################################################################################

python3 RunAsymptoticLimits.py --cfg ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --feat dnn_ZZbbtt_kl_1 --featureDependsOnMass --prd prod_240513 --cat ZZ_elliptical_cut_90 --usr vernazza --grp datacard_zz_res \
    --mass 200,210,220,230,240,250,260,280,300,320,350,360,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2200,2400,2500,2600,2800,3000,3500,4000,4500,5000

###############################################################################################################################################
# CUT FLOW for AN
###############################################################################################################################################

law run PreprocessRDFWrapper --version prod_240517 --category-names base_selection --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency

law run PreprocessRDFWrapper --version prod_240518 --category-names base_selection --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0 --PreprocessRDF-compute-filter-efficiency

law run PreprocessRDFWrapper --version prod_240517 --category-names base_selection --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"