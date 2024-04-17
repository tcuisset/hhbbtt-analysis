#### Rerun MergeCategorizationStats with fixed weights
law run MergeCategorizationStatsWrapper --version prod_240411 --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM_aux,wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8_aux \
 --workers 100 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --PreCounter-tasks-per-job 5


 law run FeaturePlot --version prod_240411 --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_fixedGenWeight \
 --MergeCategorizationStats-version prod_240411 \
 --feature-names LHE_HT,LHE_HT_low,LHE_HT_high,genWeightFixed \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png \
  --stack --log-y --save-yields --workers 20

law run FeaturePlot --version prod_240411 --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_fixedGenWeight \
 --MergeCategorizationStats-version prod_240411 \
 --feature-names LHE_HT,LHE_HT_low,LHE_HT_high,genWeightFixed \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png \
  --stack --log-y --save-yields --workers 20