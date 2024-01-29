
###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES
###############################################################################################################################################

# before launching, remove changes in boosted category
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,zh_hbb_zqq,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240128 --category-names base --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=reserv,WNTag=el7'
# --skip-dataset-tags secondary \

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240128 --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=reserv,WNTag=el7'

###############################################################################################################################################
# ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run CategorizationWrapper --version prod_240128 --category-names ZZ_elliptical_cut_80_etau,ZZ_elliptical_cut_80_mutau,ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=reserv,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

