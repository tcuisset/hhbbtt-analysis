# Datset list : 
# only for ZZ : zz_sl_signal,zz_sl_background,
# common with ZZ : zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,zh_hbb_zqq,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm
# common among ZH : zz_sl
# zh_zbb_htt only : zh_zbb_htt_signal,zh_zbb_htt_background,zh_hbb_zll,Zprime_Zh_Zbbhtautau_M600
# zh_ztt_hbb only : zh_ztt_hbb_signal,zh_ztt_hbb_background,zh_htt

# running out of short queue on categorization with systematics (16/02/24)
# lots of jobs running out
# wz_llqq,tth_tautau,zh_zbb_htt_signal,zh_hbb_zll,zz_sl
# small fraction running out
# dy,tt_sl,tt_dl,data_mutau_a,data_mutau_d,Zprime_Zh_Zbbhtautau_M600_v1

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
ln -s /grid_mnt/data__data.polcms/cms/cuisset/cmt/PreprocessRDF/ul_2018_ZbbHtt_v10/zz_sl /grid_mnt/data__data.polcms/cms/cuisset/cmt/PreprocessRDF/ul_2018_ZttHbb_v10/zz_sl

law run PreprocessRDFWrapper --version prod_240128 --category-names base_selection --config-name ul_2018_ZttHbb_v10 \
 --dataset-names zh_ztt_hbb_signal,zh_ztt_hbb_background,zh_htt \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'


###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################
# list of datasets running categroization for >2hours
# tth_bb, st_tw_top, ttw_qq, ttwh, st_tw_antitop, wz_llqq, zh_htt, wplush_htt, wz_lnuqq, ewk_wminus, ww_lnuqq, ttww, wz_lllnu, tth_tautau, st_antitop, ttw_lnu, wminush_htt, ewk_wminus, wz_llqq, tth_bb

# for dataset in tth_bb st_tw_top ttw_qq ttwh st_tw_antitop wz_llqq zh_htt wplush_htt wz_lnuqq ewk_wminus ewk_wplus ww_lnuqq ttww wz_lllnu tth_tautau st_antitop st_top ttw_lnu wminush_htt ewk_wminus wz_llqq tth_bb; do rm -r $dataset; done

# to run zh_hbb_zll Zprime_Zh_Zbbhtautau_M600
###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

# ul_2018_ZbbHtt_v10
#pilot
law run Categorization --version prod_240128 --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --dataset-name Zprime_Zh_Zbbhtautau_M600 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 1

# --dataset-names zh_zbb_htt_signal,zh_zbb_htt_background,zh_hbb_zll,Zprime_Zh_Zbbhtautau_M600,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm,zz_sl \
# removed zh_hbb_zqq (not availbale ?)
law run CategorizationWrapper --version prod_240128 --category-names base --config-name ul_2018_ZbbHtt_v10 \
 --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 100 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# --skip-dataset-tags secondary \

# ul_2018_ZttHbb_v10
# removed zh_hbb_zqq (not availbale ?)
# --dataset-names zh_ztt_hbb_signal,zh_ztt_hbb_background,zh_htt,zz_bbtt,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,tth_nonb,ggH_ZZ,ggf_sm,zz_sl \
law run CategorizationWrapper --version prod_240128 --category-names base --config-name ul_2018_ZttHbb_v10 \
 --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 100 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
# --skip-dataset-tags secondary \


###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

#pilot
law run Categorization --version prod_240128 --category-name ZbbHtt_elliptical_cut_90 --config-name ul_2018_ZbbHtt_v10 \
 --dataset-name zh_zbb_htt_background \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 1 --branch 0


law run CategorizationWrapper --version prod_240128 --category-names ZbbHtt_elliptical_cut_90_sr --config-name ul_2018_ZbbHtt_v10 \
 --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run CategorizationWrapper --version prod_240128 --category-names ZttHbb_elliptical_cut_90_sr --config-name ul_2018_ZttHbb_v10 \
 --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################
# ZH specific 
law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZbbHtt_v10 \
 --dataset-names zh_zbb_htt_signal,zh_zbb_htt_background,zh_hbb_zll,zz_sl,Zprime_Zh_Zbbhtautau_M600,zh_zbb_htt_signal_aux,zh_zbb_htt_background_aux,zh_hbb_zll_aux,zz_sl_aux \
 --workers 10 --PreCounter-weights-file weights --systematic-names pu

law run MergeCategorizationStatsWrapper --version prod_240128 --config-name ul_2018_ZttHbb_v10 \
 --dataset-names zh_ztt_hbb_signal,zh_ztt_hbb_background,zh_htt,zh_ztt_hbb_signal_aux,zh_ztt_hbb_background_aux,zh_htt_aux \
 --workers 5 --PreCounter-weights-file weights --systematic-names pu

# symlinks to ZZ for common datasets (run the loop twice, once in ul_2018_ZbbHtt_v10 and once in ul_2018_ZttHbb_v10)
cd /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZbbHtt_v10
cd /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZttHbb_v10
for process_dir in /grid_mnt/data__data.polcms/cms/vernazza/cmt/MergeCategorizationStats/ul_2018_ZZ_v10/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
        if [[ ! $(basename $process_dir) == zh_hbb_zll* ]]; then # zh_hbb_zll in zh is actually split in sevaral parts, so using it is a mistake
        if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # signal for ZZ analysis
            ln -s $process_dir $(basename $process_dir) # also don't forget the _aux datasets
        fi
        fi
    fi
done 
# link zz_sl as it is the same for both ZH analyses
ln -s /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZbbHtt_v10/zz_sl /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZttHbb_v10/zz_sl
ln -s /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZbbHtt_v10/zz_sl_aux /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorizationStats/ul_2018_ZttHbb_v10/zz_sl_aux

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

###### 1D plots (also add --log-y for logscale and region names os_iso etau_os_iso mutau_os_iso )
# ZbbHtt
law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZbbHtt --save-root --save-png --stack --workers 20 --region-name os_iso --print-status 1

law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --dataset-names "$DATASETS_ZbbHtt" \
 --process-group-name plot --save-root --save-png --stack --workers 20 --region-name os_iso --print-status 1

# In separate regions, with QCD, with and without logscale
function featurePlotZbbHtt {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
        law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass --dataset-names "$DATASETS_ZbbHtt,$DATASETS_DATA" \
 --process-group-name plot --save-root --save-png --stack --workers 40 --do-qcd --region-name $REGION_NAME $LOG_PARAMS
}
for logParams in "${logCommands[@]}"; do
    featurePlotZbbHtt etau_os_iso $DATASETS_DATA_ETAU $logParams
    featurePlotZbbHtt mutau_os_iso $DATASETS_DATA_MUTAU $logParams
    featurePlotZbbHtt tautau_os_iso $DATASETS_DATA_TAUTAU $logParams
done


# ZbbHtt resonant
law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 --region-name os_iso \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --stack --workers 20 --print-status 1

law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot-version prod_240128  --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --dataset-names "Zprime_Zh_Zbbhtautau_M600,$DATASETS_ZbbHtt" \
 --process-group-name plot_res --save-root --save-png --stack --workers 20 --region-name os_iso --print-status 1

#with QCD
function featurePlotZbbHtt_res {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
    law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
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

##### ZttHbb
law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZttHbb_v10 --region-name os_iso \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --feature-names ZHKinFit_mass,ZHKinFit_highmass --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZttHbb --save-root --save-png --stack --workers 20 --print-status 1

law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZttHbb_v10  \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --feature-names ZHKinFit_mass --dataset-names "$DATASETS_ZttHbb" \
 --process-group-name plot --save-root --save-png --stack --workers 20 --region-name os_iso --print-status 1

# with QCD
function featurePlotZttHbb {
    REGION_NAME=$1
    DATASETS_DATA=$2
    LOG_PARAMS=$3
        law run FeaturePlot --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names ZHKinFit_mass --dataset-names "$DATASETS_ZttHbb,$DATASETS_DATA" \
 --process-group-name plot --save-root --save-png --stack --workers 40 --do-qcd --region-name $REGION_NAME $LOG_PARAMS
}
for logParams in "${logCommands[@]}"; do
    featurePlotZttHbb etau_os_iso $DATASETS_DATA_ETAU $logParams
    featurePlotZttHbb mutau_os_iso $DATASETS_DATA_MUTAU $logParams
    featurePlotZttHbb tautau_os_iso $DATASETS_DATA_TAUTAU $logParams
done


###### Zmass vs Hmass
# ZbbHtt
law run FeaturePlot2D --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack --workers 20 --print-status 1

# ZttHbb
law run FeaturePlot2D --version prod_240128  --category-name base --config-name ul_2018_ZttHbb_v10 \
 --PreprocessRDF-version prod_240128 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse  \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128 --PrePlot2D-skip-merging \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names Ztt_svfit_mass_ellipse:Hbb_mass_ellipse --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack --workers 20 --print-status 2

