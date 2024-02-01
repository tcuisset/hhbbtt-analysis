###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

#pilot
law run PreprocessRDF --version prod_240128 --category-name base_selection --config-name ul_2018_ZbbHtt_v10 \
 --dataset-name zh_zbb_htt_signal \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0 --print-status 1

# before launching, remove changes in boosted category
# ul_2018_ZbbHtt_v10 specific datasets
# already run for ZZ : zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,zh_hbb_zqq,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names zh_zbb_htt_signal,zh_zbb_htt_background,zh_hbb_zll,zz_sl,Zprime_Zh_Zbbhtautau_M600 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# ul_2018_ZttHbb_v10 specific datasets
# already run for ZZ : zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,zh_hbb_zqq,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm
# already run for ul_2018_ZbbHtt_v10 : zz_sl
law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZttHbb_v10 \
 --dataset-names zh_ztt_hbb_signal,zh_ztt_hbb_background,zh_htt \
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

law run CategorizationWrapper --version prod_240128 --category-names base --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names zh_zbb_htt_signal,zh_zbb_htt_background \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# --skip-dataset-tags secondary \
