export CMT_STORE=/scratch/cuisset/cmt/test_binning

YEAR=2018
res_mass=3000
cat=ZZ_elliptical_cut_90_boosted_noPNet
law run FeaturePlot --version prod_240804 --FeatureHistogram-version prod_240804 --PrePlot-version prod_240803 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_500_${res_mass} \
 --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240522 --MergeCategorization-version prod_240522 \
 --process-group-name datacard_zz_res --save-png --category-name ${cat} --region-name etau_os_iso --stack --merge-bins --hide-data False --log-y --histogram-minimum 0.1 --equal-bin-width

res_mass=300
cat=ZZ_elliptical_cut_90_resolved_1b

law run FeaturePlot --version prod_240804 --FeatureHistogram-version prod_240804 --PrePlot-version prod_240803 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_500_${res_mass} \
 --dataset-names GluGluToXToZZTo2B2Tau_M${res_mass},\
zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240522 --MergeCategorization-version prod_240522 \
 --process-group-name datacard_zz_res --save-png --category-name ${cat} --region-name etau_os_iso --stack --merge-bins --hide-data False --log-y --histogram-minimum 0.1 --do-qcd --equal-bin-width


# elena testing
YEAR=2018
cat=ZZ_elliptical_cut_90_resolved_1b
law run FeaturePlot --version prod_240808 --FeatureHistogram-version prod_240808 --PrePlot-version prod_240802 --config-name ul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_kl_500 \
 --dataset-names zz_sl_signal,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e \
 --workers 20 --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240522 --MergeCategorization-version prod_240522 \
 --process-group-name zz --category-name ${cat} --region-name etau_os_iso --do-qcd --merge-bins --equal-bin-width --save-png --stack --hide-data True --log-y --histogram-minimum 0.1