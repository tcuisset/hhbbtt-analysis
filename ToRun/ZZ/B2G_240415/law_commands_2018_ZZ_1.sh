
###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES: 
###############################################################################################################################################

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=reserv,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES: 
###############################################################################################################################################

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2018_ZZ_v12 \
 --dataset-tags secondary \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2018_ZZ_v12 \
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

# DONE
law run CategorizationWrapper --version prod_240312 --category-names base,ZZ_elliptical_cut_90_sr --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240318 --category-names ZZ_elliptical_cut_90_sr --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240318 --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,res --category-names ZZ_elliptical_cut_90_CR_etau,ZZ_elliptical_cut_90_CR_mutau,ZZ_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# DONE
law run CategorizationWrapper --version prod_240326 --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,res --category-names base \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240327 --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary,res --category-names ZZ_elliptical_cut_90_etau,ZZ_elliptical_cut_90_mutau,ZZ_elliptical_cut_90_tautau \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 20 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# RESONANT ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240403 --config-name ul_2018_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst_resZZ --workers 20 --Categorization-tasks-per-job 5 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################

###############################################################################################################################################
# CHECK STITCHING
###############################################################################################################################################

law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,nJet,LHE_Vpt,met_pt --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --category-name base --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,nJet,LHE_Vpt,met_pt --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --category-name base --region-name os_iso --stack --log-y

###############################################################################################################################################
# PLOT ELLIPTICAL MASS CUT
###############################################################################################################################################
 
# DONE
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2018_ZZ_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zz_res_sig_vs_bkg --save-root --save-png --stack

# DONE
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZZ_elliptical_cut_90_sr --config-name ul_2018_ZZ_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zz_res_sig_vs_bkg --save-root --save-png --stack

###############################################################################################################################################
# PLOT DNN FEATURES
###############################################################################################################################################

law run FeaturePlot --version prod_240414 --PrePlot-version prod_240414 --category-name ZZ_elliptical_cut_90_sr --config-name ul_2018_ZZ_v12 \
 --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,\
dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl,boosted,is_vbf,jet_1_quality,jet_2_quality \
 --dataset-names zz_sl_signal,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top \
 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 --region-name os_iso \
 --workers 50 --PreprocessRDF-version prod_240305 --PrePlot-skip-merging \
 --process-group-name zz_sig_vs_bkg --save-root --save-png

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run FeaturePlot --version prod_240318 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_MLM,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run FeaturePlot --version prod_240318 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_MLM,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run FeaturePlot --version prod_240318 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_MLM,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# BASELINE ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run FeaturePlot --version prod_240326 --PrePlot-skip-merging --PrePlot-version prod_240326 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240326 \
 --process-group-name zz --save-root --save-png --category-name base --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240326 --PrePlot-skip-merging --PrePlot-version prod_240326 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240326 \
 --process-group-name zz --save-root --save-png --category-name base --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240326 --PrePlot-skip-merging --PrePlot-version prod_240326 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240326 \
 --process-group-name zz --save-root --save-png --category-name base --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# ###############################################################################################################################################
# # PLOT DNN INPUT
# ###############################################################################################################################################

# law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
#  --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
#  --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
#  --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
#  --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_etau \
#  --region-name etau_os_iso --do-qcd --hide-data False --stack
# law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
#  --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
#  --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
#  --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#  --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_mutau \
#  --region-name mutau_os_iso --do-qcd --hide-data False --stack
# law run FeaturePlot --version prod_231003 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
#  --feature-names zz_kinfit_chi2,zz_kinfit_m,sv_mass,sv_mass_large,dR_l1_l2_x_sv_pT,l1_mt,l_2_pT,dR_l1_l2,dphi_sv_met,z_bb_mass,b_2_hhbtag,diZ_mass_sv,dphi_zbb_sv,z_bb_pT,dR_l1_l2_boosted_ztt_met,l_1_pT,b_1_pT,phi,costheta_l2_zttmet,b_1_cvsb,b_1_cvsl \
#  --workers 20  --MergeCategorization-version prod_240207 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_231002  \
#  --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d \
#  --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name ZZ_elliptical_cut_80_tautau \
#  --region-name tautau_os_iso --do-qcd --hide-data False --stack

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run FeaturePlot --version prod_240327 --PrePlot-skip-merging --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240327 --PrePlot-skip-merging --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run FeaturePlot --version prod_240327 --PrePlot-skip-merging --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# DATACARDS
###############################################################################################################################################

law run CreateDatacards --version prod_240328 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240328 --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240328 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240328 --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240328 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240328 --PrePlot-version prod_240327 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass \
 --dataset-names zz_sl_signal,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_sl_background,zh_htt,zh_hbb_zll,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd

###############################################################################################################################################
# COMBINE
###############################################################################################################################################

python3 RunNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 --prd prod_240404 --grp datacard_zz

python3 PlotNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1 --prd prod_240404 --grp datacard_zz

###############################################################################################################################################
############################################################ B2G MEETING  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU - B2G CR and SR PLOTS
###############################################################################################################################################

law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False

law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240403 --PrePlot-skip-merging --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True

law run CreateDatacards --version prod_240404 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240404 --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240404 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240404 --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240404 \
 --PrePlot-skip-merging --FeaturePlot-version prod_240404 --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd

python3 RunNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 --prd prod_240404 --grp datacard_zz

python3 PlotNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1 --prd prod_240404 --grp datacard_zz


law run CreateDatacards --version prod_240415Test \
 --PrePlot-skip-merging --FeaturePlot-version prod_240404 --PrePlot-version prod_240403 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd

###############################################################################################################################################
############################################################ ANALYSIS NOTE ####################################################################
###############################################################################################################################################

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU - AN CR and SR PLOTS
###############################################################################################################################################

law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240318 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_CR_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False





# From this point I'll use MergeCategorization!

law run FeaturePlot --version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True

law run CreateDatacards --version prod_240417 \
 --FeaturePlot-version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240417 \
 --FeaturePlot-version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd
law run CreateDatacards --version prod_240417 \
 --FeaturePlot-version prod_240417 --PrePlot-version prod_240417 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd

python3 RunNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1,ZZKinFit_mass,ZZKinFit_mass_fit_1,ZZKinFit_mass_fit_2 --prd prod_240418 --grp datacard_zz

python3 PlotNonResLimits.py --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_etau,cat_ZZ_elliptical_cut_90_mutau,cat_ZZ_elliptical_cut_90_tautau \
    --feat dnn_ZZbbtt_kl_1 --prd prod_240418 --grp datacard_zz









































###############################################################################################################################################
# RESONANT ANALYSIS
###############################################################################################################################################

law run FeaturePlot --version prod_240404_test --PrePlot-skip-merging --PrePlot-version prod_240404_test --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500 \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --hide-data True
law run FeaturePlot --version prod_240404_mutau --PrePlot-skip-merging --PrePlot-version prod_240404_mutau --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500 \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --hide-data True
law run FeaturePlot --version prod_240404_tautau --PrePlot-skip-merging --PrePlot-version prod_240404_tautau --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500 \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --hide-data True

# law run FeaturePlot --version prod_240405_test --PrePlot-skip-merging --PrePlot-version prod_240405_test --config-name ul_2018_ZZ_v12 \
#  --feature-names ZZKinFit_mass_res \
#  --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
# zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
# wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
# zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
# zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
# ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
#  --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
#  --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
#  --save-yields --stack --do-qcd --hide-data True

law run FeaturePlot --version prod_240404_rm --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240404_rm --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
law run FeaturePlot --version prod_240404_rm --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True

law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1

law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240404 --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1


########################################################################################

for res_mass in 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500; do
    law run CreateDatacards --version prod_240405_M$res_mass --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
    law run CreateDatacards --version prod_240405_M$res_mass --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd & 
    law run CreateDatacards --version prod_240405_M$res_mass --PrePlot-skip-merging --PrePlot-version prod_240404 --config-name ul_2018_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
done

########################################################################################

python3 RunAsymptoticLimits.py --config ul_2018_ZZ_v12 --category ZZ_elliptical_cut_90 --process-group-name datacard_zz_res \
    --feat dnn_ZZbbtt_kl_1 --featureDependsOnMass --ver prod_240405 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500
python3 RunAsymptoticLimits.py --config ul_2018_ZZ_v12 --category ZZ_elliptical_cut_90 --process-group-name datacard_zz_res \
    --feat ZZKinFit_mass_res --ver prod_240405 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500

for CHANNEL in etau mutau tautau combination; do
python3 PlotAsymptoticLimits.py --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500 --config ul_2018_ZZ_v12  \
    --feat dnn_ZZbbtt_kl_1 --featureDependsOnMass --ver prod_240405 --ch $CHANNEL
done
for CHANNEL in etau mutau tautau combination; do
python3 PlotAsymptoticLimits.py --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500 --config ul_2018_ZZ_v12  \
    --feat ZZKinFit_mass_res --ver prod_240405 --ch $CHANNEL
done















###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU - AN CR and SR PLOTS
###############################################################################################################################################

YEAR=2018

# MergeCategorization + PrePlot with everything etau
law run FeaturePlot --version prod_240419_rm --PrePlot-version prod_240419 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
# PrePlot with everything mutau
law run FeaturePlot --version prod_240419_rm --PrePlot-version prod_240419 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True
# PrePlot with everything tautau
law run FeaturePlot --version prod_240419_rm --PrePlot-version prod_240419 --config-name ul_2018_ZZ_v12 \
 --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_200,dnn_ZZbbtt_kl_1_300,dnn_ZZbbtt_kl_1_400,dnn_ZZbbtt_kl_1_500,dnn_ZZbbtt_kl_1_600,dnn_ZZbbtt_kl_1_700,\
dnn_ZZbbtt_kl_1_800,dnn_ZZbbtt_kl_1_900,dnn_ZZbbtt_kl_1_1000,dnn_ZZbbtt_kl_1_1100,dnn_ZZbbtt_kl_1_1200,dnn_ZZbbtt_kl_1_1300,dnn_ZZbbtt_kl_1_1400,dnn_ZZbbtt_kl_1_1500 \
 --dataset-names ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,\
ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 30 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True


law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240417 --PrePlot-skip-merging --PrePlot-version prod_240417 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names ZZKinFit_mass_res \
 --dataset-names ggXZZbbtt_M400,ggXZZbbtt_M600,ggXZZbbtt_M800,ggXZZbbtt_M1000,ggXZZbbtt_M1200,ggXZZbbtt_M1500,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1

law run FeaturePlot --version prod_240418 --PrePlot-skip-merging --PrePlot-version prod_240418 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240418 --PrePlot-skip-merging --PrePlot-version prod_240418 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1
law run FeaturePlot --version prod_240418 --PrePlot-skip-merging --PrePlot-version prod_240418 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1_1000 \
 --dataset-names ggXZZbbtt_M1000,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
 --process-group-name dnn_zz_res_1000 --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --log-y True --histogram-minimum 0.1


########################################################################################

for res_mass in 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500; do
    law run CreateDatacards --version prod_240419_M$res_mass  --PrePlot-version prod_240419 --MergeCategorization-version prod_240419 --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name etau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
    law run CreateDatacards --version prod_240419_M$res_mass  --PrePlot-version prod_240419 --MergeCategorization-version prod_240419 --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name mutau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd & 
    law run CreateDatacards --version prod_240419_M$res_mass  --PrePlot-version prod_240419 --MergeCategorization-version prod_240419 --config-name ul_${YEAR}_ZZ_v12 \
    --feature-names ZZKinFit_mass_res,dnn_ZZbbtt_kl_1_$res_mass \
    --dataset-names ggXZZbbtt_M$res_mass,\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
    --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240403 \
    --process-group-name datacard_zz_res --save-root --save-png --category-name ZZ_elliptical_cut_90 --region-name tautau_os_iso \
    --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd &
done

########################################################################################

python3 RunAsymptoticLimits.py --config ul_2018_ZZ_v12 --category ZZ_elliptical_cut_90 --process-group-name datacard_zz_res \
    --feat dnn_ZZbbtt_kl_1 --featureDependsOnMass --ver prod_240419 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500
python3 RunAsymptoticLimits.py --config ul_2018_ZZ_v12 --category ZZ_elliptical_cut_90 --process-group-name datacard_zz_res \
    --feat ZZKinFit_mass_res --ver prod_240419 --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500

for CHANNEL in etau mutau tautau combination; do
python3 PlotAsymptoticLimits.py --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500 --config ul_2018_ZZ_v12  \
    --feat dnn_ZZbbtt_kl_1 --featureDependsOnMass --ver prod_240419 --ch $CHANNEL
done
for CHANNEL in etau mutau tautau combination; do
python3 PlotAsymptoticLimits.py --mass 200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500 --config ul_2018_ZZ_v12  \
    --feat ZZKinFit_mass_res --ver prod_240419 --ch $CHANNEL
done








































#################################### TEST SYSTEMATICS

law run CreateDatacards --version prod_240417_syst \
 --PrePlot-skip-merging --FeaturePlot-version prod_240417_syst --PrePlot-version prod_240417_syst --config-name ul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240327 \
 --process-group-name datacard_zz --save-root --save-png --category-name ZZ_elliptical_cut_90_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data True --propagate-syst-qcd