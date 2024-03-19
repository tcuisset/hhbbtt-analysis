### Running with ZH trained DNN, plotting with systematics ! (uses same categorization as ZH_2.sh, prod_240215)

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

# clearing out PrePlot : rm /grid_mnt/data__data.polcms/cms/cuisset/cmt/PrePlot/ul_2018_ZbbHtt_v10/*/cat_ZbbHtt_elliptical_cut_90_*/prod_240215/data_*.root

# ZbbHtt
# In separate regions, with QCD, with and without logscale
function featurePlotZbbHtt {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
      law run FeaturePlot --version prod_240226  --category-name ZbbHtt_elliptical_cut_90_$REGION_NAME --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215 \
 --feature-names ZHKinFit_mass,dnn_ZHbbtt_kl_1 --dataset-names "Zprime_Zh_Zbbhtautau_M600,$DATASETS_ZbbHtt,$DATASETS_DATA" \
 --process-group-name plot_res --save-root --save-png --stack --workers 40 --do-qcd --region-name $REGION_NAME\_os_iso $LOG_PARAMS "${@:4}"
}
for logParams in "${logCommands[@]}"; do
    featurePlotZbbHtt etau $DATASETS_DATA_ETAU $logParams
    featurePlotZbbHtt mutau $DATASETS_DATA_MUTAU $logParams
    featurePlotZbbHtt tautau $DATASETS_DATA_TAUTAU $logParams
done


# pilot ZbbHtt etau only
# law run FeaturePlot --version prod_240226  --category-name ZbbHtt_elliptical_cut_90_etau --config-name ul_2018_ZbbHtt_v10 \
#  --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
#  --PrePlot-version prod_240215  --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240215 \
#  --feature-names dnn_ZHbbtt_kl_1 --dataset-names "Zprime_Zh_Zbbhtautau_M600,data_etau_a" \
#  --process-group-name plot_res --save-root --save-png --stack --workers 20 --do-qcd --region-name etau_os_iso


# ZttHbb
# In separate regions, with QCD, with and without logscale
function featurePlotZttHbb {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
    law run FeaturePlot --version prod_240226  --category-name ZttHbb_elliptical_cut_90_$REGION_NAME --config-name ul_2018_ZttHbb_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215 \
 --feature-names ZHKinFit_mass,dnn_ZHbbtt_kl_1 --dataset-names "$DATASETS_ZttHbb,$DATASETS_DATA" \
 --process-group-name plot --save-root --save-png --stack --workers 40 --do-qcd --region-name $REGION_NAME\_os_iso $LOG_PARAMS "${@:4}"
}
for logParams in "${logCommands[@]}"; do
    featurePlotZttHbb etau $DATASETS_DATA_ETAU $logParams
    featurePlotZttHbb mutau $DATASETS_DATA_MUTAU $logParams
    featurePlotZttHbb tautau $DATASETS_DATA_TAUTAU $logParams
done


###############################################################################################################################################
############################################################  Datacards  #################################################################
###############################################################################################################################################

law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZbbHtt_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZbbHtt,$DATASETS_DATA_ETAU" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --propagate-syst-qcd

law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZbbHtt_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZbbHtt,$DATASETS_DATA_MUTAU" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True --propagate-syst-qcd

law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZbbHtt_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZbbHtt,$DATASETS_DATA_TAUTAU" \
 --process-group-name datacard_ZbbHtt --save-root --save-png --hide-data True  --category-name ZbbHtt_elliptical_cut_90_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True --propagate-syst-qcd

# ZttHbb
law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZttHbb_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZttHbb,$DATASETS_DATA_ETAU" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_etau \
 --region-name etau_os_iso --do-qcd --hide-data True --propagate-syst-qcd

law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZttHbb_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZttHbb,$DATASETS_DATA_MUTAU" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_mutau \
 --region-name mutau_os_iso --do-qcd --hide-data True --propagate-syst-qcd

law run CreateDatacards --version prod_240226 --FeaturePlot-version prod_240226_fixSystQcd --PrePlot-version prod_240226 --config-name ul_2018_ZttHbb_v10 \
 --feature-names dnn_ZHbbtt_kl_1 --workers 20 --MergeCategorizationStats-version prod_240128 --MergeCategorization-version prod_240215 --Categorization-version prod_240215  \
 --dataset-names "$DATASETS_ZttHbb,$DATASETS_DATA_TAUTAU" \
 --process-group-name datacard_ZttHbb --save-root --save-png --hide-data True  --category-name ZttHbb_elliptical_cut_90_tautau \
 --region-name tautau_os_iso --do-qcd --hide-data True --propagate-syst-qcd





###############################################################################################################################################
############################################################  Combine  #################################################################
###############################################################################################################################################
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/CMSSW_11_3_4
cmsenv
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/RunCombineZZbbtautau

# change in datacards : line=pu, col=qcd replace 1 by - in all 3 datacards

#### ZbbHtt
python3 run_combine.py --config-name ul_2018_ZbbHtt_v10 --category-base ZbbHtt_elliptical_cut_90 --ver prod_240226 --ch etau --feat dnn_ZHbbtt_kl_1
# Significance: 0.0622366
# Done in 0.00 min (cpu), 0.02 min (real)
#  ### INFO: Results for etau
#  ### p-value     =  0.47518720512279466
#  ### significane =  0.0622366077099276

python3 run_combine.py --config-name ul_2018_ZbbHtt_v10 --category-base ZbbHtt_elliptical_cut_90 --ver prod_240226 --ch mutau --feat dnn_ZHbbtt_kl_1
# Significance: 0.0635976
# Done in 0.00 min (cpu), 0.00 min (real)
#  ### INFO: Results for mutau
#  ### p-value     =  0.47464530654027354
#  ### significane =  0.0635976373207038

python3 run_combine.py --config-name ul_2018_ZbbHtt_v10 --category-base ZbbHtt_elliptical_cut_90 --ver prod_240226 --ch tautau --feat dnn_ZHbbtt_kl_1



python3 combination.py --base-dir /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/RunCombineZZbbtautau --config-name ul_2018_ZbbHtt_v10 --category-base ZbbHtt_elliptical_cut_90  --ver prod_240215 --feat dnn_ZHbbtt_kl_1




################## ZttHbb
python3 run_combine.py --config-name ul_2018_ZttHbb_v10 --category-base ZttHbb_elliptical_cut_90 --ver prod_240215 --ch etau --feat dnn_ZHbbtt_kl_1
#  -- Significance -- 
# Significance: 0.0393759
# Done in 0.00 min (cpu), 0.00 min (real)
#  ### INFO: Results for etau
#  ### p-value     =  0.484295345424791
#  ### significane =  0.039375903974793576

python3 run_combine.py --config-name ul_2018_ZttHbb_v10 --category-base ZttHbb_elliptical_cut_90 --ver prod_240215 --ch mutau --feat dnn_ZHbbtt_kl_1
#  -- Significance -- 
# Significance: 0.044833
# Done in 0.00 min (cpu), 0.00 min (real)
#  ### INFO: Results for mutau
#  ### p-value     =  0.4821202285137733
#  ### significane =  0.04483295521840821

python3 run_combine.py --config-name ul_2018_ZttHbb_v10 --category-base ZttHbb_elliptical_cut_90 --ver prod_240215 --ch tautau --feat dnn_ZHbbtt_kl_1
#  -- Significance -- 
# Significance: 0.185732
# Done in 0.00 min (cpu), 0.00 min (real)
#  ### INFO: Results for tautau
#  ### p-value     =  0.42632738102381035
#  ### significane =  0.185732217411165

python3 combination.py --base-dir /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/RunCombineZZbbtautau --config-name ul_2018_ZttHbb_v10 --category-base ZttHbb_elliptical_cut_90  --ver prod_240215 --feat dnn_ZHbbtt_kl_1
#  ### INFO: Results for combination
#  ### significance etau =  0.039375903974793576
#  ### significance mutau =  0.04483295521840821
#  ### significance tautau =  0.185732217411165
#  ### significance combination =  0.1909936263658631
# (1.01, 0.36, 0.42, 0.36, 0.42, 0.0, 0.0)
# (1.01, 0.36, 0.42, 0.36, 0.42, 0.0, 0.0)
# (1.01, 0.36, 0.42, 0.36, 0.42, 0.0, 0.0)

