####### Using version 2 of Zprime_Zh_Zbbhtautau_M600 dataset


law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names zz_sl,Zprime_Zh_Zbbhtautau_M600 \
 --workers 10 --PreCounter-weights-file weights --systematic-names pu

###############################################################################################################################################
############################################################  FeaturePlot  #################################################################
###############################################################################################################################################
# Datasets for plotting order
DATASETS_ZbbHtt=zh_zbb_htt_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_hbb_zll,zh_hbb_zqq,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zh_zbb_htt_background,zh_hbb,zz_sl,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_ZttHbb=zh_ztt_hbb_signal,dy,tt_dl,tt_sl,tt_fh,wjets,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,tth_bb,tth_nonbb,tth_tautau,zh_htt,zh_hbb_zqq,wplush_htt,wminush_htt,ggH_ZZ,ggf_sm,zz_dl,zh_ztt_hbb_background,zh_hbb,zz_sl,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_llqq,wz_lnununu,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top
DATASETS_DATA_ETAU=data_etau_a,data_etau_b,data_etau_c,data_etau_d
DATASETS_DATA_MUTAU=data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d
DATASETS_DATA_TAUTAU=data_tau_a,data_tau_b,data_tau_c,data_tau_d
declare -a logCommands=("" "--log-y")

law run FeaturePlot --version prod_240128_resv2  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot-version prod_240128  --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --dataset-names "Zprime_Zh_Zbbhtautau_M600,$DATASETS_ZbbHtt" \
 --process-group-name plot_res --save-root --save-png --stack --workers 20 --region-name os_iso --print-status 1


#with QCD
function featurePlotZbbHtt_res {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
  law run FeaturePlot --version prod_240128_resv2  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot-version prod_240128  --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass --dataset-names "Zprime_Zh_Zbbhtautau_M600,$DATASETS_ZbbHtt,$DATASETS_DATA" \
 --process-group-name plot_res --save-root --save-png --stack --workers 40 --do-qcd --region-name $REGION_NAME $LOG_PARAMS
}
for logParams in "${logCommands[@]}"; do
    featurePlotZbbHtt_res etau_os_iso $DATASETS_DATA_ETAU $logParams
    featurePlotZbbHtt_res mutau_os_iso $DATASETS_DATA_MUTAU $logParams
    featurePlotZbbHtt_res tautau_os_iso $DATASETS_DATA_TAUTAU $logParams
done
