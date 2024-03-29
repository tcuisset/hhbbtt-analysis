# Processing of version 3 of Zprime samples (pilot before full reprocess of everything)

law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names Zprime_Zh_Zbbhtautau_M500 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'



######## Categorization
law run CategorizationWrapper --version prod_240215 --category-names ZbbHtt_elliptical_cut_90_etau --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names Zprime_Zh_Zbbhtautau_M500 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run CategorizationWrapper --version prod_240215 --category-names ZbbHtt_elliptical_cut_90_mutau --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names Zprime_Zh_Zbbhtautau_M500 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 70 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run CategorizationWrapper --version prod_240215 --category-names ZbbHtt_elliptical_cut_90_tautau --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names Zprime_Zh_Zbbhtautau_M500 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 70 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

######## MergeCatStats
law run MergeCategorizationStatsWrapper --version prod_240215 --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names Zprime_Zh_Zbbhtautau_M500 \
 --workers 20 --PreCounter-weights-file weights --systematic-names pu

#### FeaturePlot
DATASETS_ZbbHtt=zh_zbb_htt_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,zh_hbb_zqq,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zh_zbb_htt_background,zh_hbb,zz_sl,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_ZttHbb=zh_ztt_hbb_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_htt,zh_hbb_zqq,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zh_ztt_hbb_background,zh_hbb,zz_sl,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d
declare -a logCommands=("" "--log-y")

# testing
law run FeaturePlot --version prod_240226  --category-name ZbbHtt_elliptical_cut_90_etau --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --MergeCategorizationStats-version prod_240215 --MergeCategorization-version prod_240215 --Categorization-version prod_240215 \
 --feature-names ZHKinFit_mass,dnn_ZHbbtt_kl_1 --dataset-names "Zprime_Zh_Zbbhtautau_M500" \
 --process-group-name plot_res --save-root --save-png --stack --workers 20 --region-name etau_os_iso --print-status 5

law run FeaturePlot --version prod_240226  --category-name ZbbHtt_elliptical_cut_90_etau --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215 \
 --PreCounter-weights-file weights \
 --feature-names ZHKinFit_mass,dnn_ZHbbtt_kl_1 --dataset-names "Zprime_Zh_Zbbhtautau_M500,$DATASETS_ZbbHtt,$DATASETS_DATA_ETAU" \
 --process-group-name plot_res --save-root --save-png --stack --workers 20 --do-qcd --region-name etau_os_iso 