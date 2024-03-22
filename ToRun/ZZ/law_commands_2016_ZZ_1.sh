###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES
###############################################################################################################################################

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2016_ZZ_v12 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm, \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2016_ZZ_v12 \
 --dataset-names data_tau_a,data_tau_b,data_tau_c,data_mutau_a,data_mutau_b,data_mutau_c,data_etau_a,data_etau_b,data_etau_c \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES
###############################################################################################################################################

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2016_ZZ_v12 \
 --dataset-tags secondary \
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
law run CategorizationWrapper --version prod_240312 --category-names base,ZZ_elliptical_cut_90_sr --config-name ul_2016_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240318 --category-names ZZ_elliptical_cut_90_sr --config-name ul_2016_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240318 --config-name ul_2016_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90_CR_etau,ZZ_elliptical_cut_90_CR_mutau,ZZ_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7' \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 20 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2016_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_mutau --config-name ul_2016_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run CategorizationWrapper --version prod_240207 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2016_ZZ_v12 \
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
# CHECK STITCHING
###############################################################################################################################################

law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --config-name ul_2016_ZZ_v12 \
 --feature-names LHE_HT,nJet,LHE_Vpt,met_pt --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --category-name base --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --config-name ul_2016_ZZ_v12 \
 --feature-names LHE_HT,nJet,LHE_Vpt,met_pt --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --category-name base --region-name os_iso --stack --log-y

###############################################################################################################################################
# PLOT ELLIPTICAL MASS CUT
###############################################################################################################################################

# 
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2016_ZZ_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zz_res_sig_vs_bkg --save-root --save-png --stack

# 
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZZ_elliptical_cut_90_sr --config-name ul_2016_ZZ_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zz_res_sig_vs_bkg --save-root --save-png --stack

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run FeaturePlot --version prod_240318_0 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
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
law run FeaturePlot --version prod_240318 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
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
law run FeaturePlot --version prod_240318 --PrePlot-skip-merging --PrePlot-version prod_240318 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
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
# PLOT DNN INPUT
###############################################################################################################################################

###############################################################################################################################################
# PLOT KINEMATIC FEATURES ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# 
law run FeaturePlot --version prod_240209 --PrePlot-skip-merging --PrePlot-version prod_240209 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run FeaturePlot --version prod_240209 --PrePlot-skip-merging --PrePlot-version prod_240209 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run FeaturePlot --version prod_240209 --PrePlot-skip-merging --PrePlot-version prod_240209 --config-name ul_2016_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets_FXFX,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,\
st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,\
data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'