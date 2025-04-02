
law run MergePrePlotWrapper --version prod_250315_btag_tests  --PreprocessRDF-version prod_250315 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M5000,zz_sl_signal  --PrePlot-store-systematics False \
  --region-names HPS_nobtag \
  --PrePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count  --PrePlot-preplot-modules-file preplot \
 --workers 20

law run MergePrePlotWrapper --PrePlot-weights-to-skip bTagweightReshape --version prod_250315_btag_tests  --PreprocessRDF-version prod_250315 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M5000,zz_sl_signal  --PrePlot-store-systematics False \
  --region-names HPS_nobtag \
  --PrePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count  --PrePlot-preplot-modules-file preplot \
 --workers 20 


law run FeaturePlot --version prod_250315_btag_tests --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-name base_selection --region-name HPS_nobtag --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot--feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count --dataset-names GluGluToXToZZTo2B2Tau_M200  --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 20




############## cateorization
# --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M5000,zz_sl_signal
# this is very I/O intensive, do not run too many jobs at the same time !
law run CategorizationWrapper --version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_btag_sf --Categorization-keep-and-drop-file keep_and_drop_file_btag_sf \
  --category-names baseline_resolved_nobtag --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5 --Categorization-retries 0 --Categorization-tasks-per-job 10 --Categorization-parallel-jobs 20 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=1G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 30 \
 --dataset-names tt_sl,tt_dl,tt_fh,dy_2j,tth_tautau --skip-dataset-tags nonDefault,signal,data

law run CategorizationWrapper --version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_btag_sf --Categorization-keep-and-drop-file keep_and_drop_file_btag_sf \
  --category-names baseline_resolved_nobtag --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5 --Categorization-retries 0 --Categorization-tasks-per-job 30 --Categorization-parallel-jobs 20 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=1G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 30 \
 --skip-dataset-names tt_sl,tt_dl,tt_fh,dy_2j,tth_tautau --skip-dataset-tags nonDefault,signal,data

law run CategorizationWrapper --version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_btag_sf --Categorization-keep-and-drop-file keep_and_drop_file_btag_sf \
  --category-names baseline_resolved_nobtag  --workers 5 \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 --skip-dataset-tags nonDefault,signal,data --skip-dataset-names tt_sl,tt_dl,tt_fh,dy_2j,tth_tautau

law run MergeCategorizationWrapper --version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_btag_sf --Categorization-keep-and-drop-file keep_and_drop_file_btag_sf \
  --category-names baseline_resolved_nobtag  --workers 1 \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11 --skip-dataset-tags nonDefault,signal,data

# computing btag extrap factor (--PrePlot-skip-merging does not work)
# the order of weights-to-skip matters ! 
# baseline_region
law run PrePlotWrapper --version prod_250315_btag_extrap_factor_noSysts  --MergeCategorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
  --category-name baseline_resolved_nobtag  --region-names baseline_region,etau,mutau,tautau   \
  --skip-dataset-tags nonDefault,resExtra,data  --PrePlot-store-systematics False \
  --PrePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count \
 --workers 30 --PrePlot-weights-to-skip bTagweightReshape,hem_weight
law run PrePlotWrapper --version prod_250315_btag_extrap_factor_noSysts  --MergeCategorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
  --category-name baseline_resolved_nobtag  --region-names baseline_region,etau,mutau,tautau   \
  --skip-dataset-tags nonDefault,signal,data  --PrePlot-store-systematics False \
  --PrePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count \
 --PrePlot-weights-to-skip hem_weight --workers 20

law run FeaturePlotWrapper  --PrePlot-version prod_250315_btag_extrap_factor_noSysts  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names baseline_resolved_nobtag --region-names baseline_region,etau,mutau,tautau --FeaturePlot-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count  --FeaturePlot-skip-dataset-tags nonDefault,signal,data --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack 
 --version prod_250315_btag_extrap_factor_noSysts_withbTagWeight --PrePlot-weights-to-skip hem_weight
 --version prod_250315_btag_extrap_factor_noSysts_nobTagWeight --PrePlot-weights-to-skip bTagweightReshape,hem_weight


# with systematics
law run PrePlotWrapper --version prod_250315_btag_extrap_factor_systs  --MergeCategorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
  --category-name baseline_resolved_nobtag  --region-names baseline_region,etau,mutau,tautau   \
  --skip-dataset-tags nonDefault,signal,data  --PrePlot-store-systematics True \
  --PrePlot-feature-names pairType,nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count \
 --PrePlot-weights-to-skip hem_weight --workers 20
law run PrePlotWrapper --version prod_250315_btag_extrap_factor_systs  --MergeCategorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
  --category-name baseline_resolved_nobtag  --region-names baseline_region,etau,mutau,tautau   \
  --skip-dataset-tags nonDefault,signal,data  --PrePlot-store-systematics True \
  --PrePlot-feature-names pairType,nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count \
 --PrePlot-weights-to-skip bTagweightReshape,hem_weight --workers 20

law run FeaturePlotWrapper  --PrePlot-version prod_250315_btag_extrap_factor_systs  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names baseline_resolved_nobtag --region-names baseline_region,etau,mutau,tautau --FeaturePlot-store-systematics True --FeaturePlot-plot-systematics True --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count  --FeaturePlot-skip-dataset-tags nonDefault,signal,data --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack 
 --version prod_250315_btag_extrap_factor_systs_withbTagWeight --PrePlot-weights-to-skip hem_weight
 --version prod_250315_btag_extrap_factor_systs_nobTagWeight --PrePlot-weights-to-skip bTagweightReshape,hem_weight



#######################################################################################################################################
###################################################### 2D extrap factors ######################################################
#######################################################################################################################################
# pg zz_full zz_sig_vs_bkg
law run FeaturePlot2D  --PrePlot2D-version prod_250315_btag_extrap_factor_2D  --MergeCategorization-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-name baseline_resolved_nobtag --region-name baseline_region --store-systematics False --plot-systematics False --do-qcd False \
 --skip-dataset-tags nonDefault,signal,data --process-group-name zz_sig_vs_bkg --save-png  \
 --feature-names nJet:LHE_HT_variableBinning  --stack --log-z --workers 30 \
  --version prod_250315_btag_extrap_factor_2D_nobTagWeight --PrePlot2D-weights-to-skip bTagweightReshape,hem_weight
 --version prod_250315_btag_extrap_factor_2D_withbTagWeight --PrePlot2D-weights-to-skip hem_weight

# signal
law run FeaturePlot2D  --PrePlot2D-version prod_250315_btag_extrap_factor_signal_2D  --MergeCategorization-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-name baseline_resolved_nobtag --region-name baseline_region --store-systematics False --plot-systematics False --do-qcd False \
 --skip-dataset-tags nonDefault,data --dataset-tags resSignal --process-group-name zz_res --save-png  \
 --feature-names nJet:LHE_HT_variableBinning  --stack --log-z --workers 30 \
  --version prod_250315_btag_extrap_factor_2D_signal_nobTagWeight --PrePlot2D-weights-to-skip bTagweightReshape,hem_weight
 --version prod_250315_btag_extrap_factor_2D_signal_withbTagWeight --PrePlot2D-weights-to-skip hem_weight



######################### checking application of SFs
law run PrePlotWrapper --version prod_250315_btag_3103_v3  --MergeCategorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 \
  --category-name baseline_resolved_nobtag  --region-names baseline_region,etau,mutau,tautau   \
  --skip-dataset-tags nonDefault,resExtra,data  --PrePlot-store-systematics False --PrePlot-preplot-modules-file preplot_btag \
  --PrePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count \
 --PrePlot-weights-to-skip hem_weight --workers 20

 
# 
law run FeaturePlotWrapper  --PrePlot-version prod_250315_btag_extrap_factor_noSysts  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names baseline_resolved_nobtag --region-names baseline_region,etau,mutau,tautau --FeaturePlot-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-names nJet,LHE_HT,LHE_HT_low,LHE_HT_high,jet_btag_count_total,jet_btagcand_count  --FeaturePlot-skip-dataset-tags nonDefault,signal,data --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack \
 --version prod_250315_btag_3103_withbTagWeight_v3 --PrePlot-version prod_250315_btag_3103_v3 --PrePlot-weights-to-skip hem_weight
 --version prod_250315_btag_extrap_factor_noSysts_nobTagWeight --PrePlot-weights-to-skip bTagweightReshape,hem_weight

