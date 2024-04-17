source setup.sh
export CMT_STORE=/scratch/cuisset/cmt/test_wjets_stitch
export CMT_STORE_EOS_CATEGORIZATION=$CMT_STORE
export CMT_STORE_EOS_PREPROCESSING=$CMT_STORE
export CMT_STORE_EOS_MERGECATEGORIZATION=$CMT_STORE

############## MergeCatStats for nanoV12 
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu 

# no region
########## No region no selection
# GenWeight
law run FeaturePlot --version prod_240408_genWeight --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names genWeight \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights False --avoid-normalization True \
  --stack --log-y --workers 20

law run FeaturePlot --version prod_240408_genWeight --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names genWeight \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights False --avoid-normalization True  \
  --stack --log-y --workers 20

######## No weights (neither primary nor secondary dataset)
# LHE_HT
law run FeaturePlot --version prod_240408 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights False \
  --stack --log-y --workers 20 --print-status 1

law run FeaturePlot --version prod_240408 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights False \
  --stack --log-y --workers 20

############### Gen weight
# HT-binned
law run FeaturePlot --version prod_240408 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20 --print-status 1

# inclusive
law run FeaturePlot --version prod_240408 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20

############### Gen weight nanoV9
law run FeaturePlot --version prod_240408_nanoV9 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8_aux \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20 --print-status 1

# inclusive
law run FeaturePlot --version prod_240408_nanoV9 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20

############### Gen weight no secondary dataset
# produced by forcing to False the condition on line 730 of cmt.base_tasks.plotting.py (in FeaturePlot.requires)
# HT-binned
law run FeaturePlot --version prod_240408_noSecondary --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20 --print-status 1

# inclusive
law run FeaturePlot --version prod_240408_noSecondary --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20

#################
################## FIxing aux dataset for wjets_ht1
law run MergeCategorizationStatsWrapper --version prod_240408 --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1_aux \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu 

# with weights
law run FeaturePlot --version prod_240408_fixHT1 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240408 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20 --print-status 1

law run FeaturePlot --version prod_240408_fixHT1 --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240408 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --apply-weights True \
  --stack --log-y --workers 20


########### Fix MLM 
law run MergeCategorizationStatsWrapper --version prod_240408_weightOne --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM_aux \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu 









################## FInal
law run MergeCategorizationStatsWrapper --version prod_240410_weightsOne --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM_aux,wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8_aux \
 --workers 20 --PreCounter-weights-file weights --systematic-names pu 

# genWeightFixed only, no PUweight
law run FeaturePlot --version prod_240410 --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240410_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png \
  --stack --log-y --workers 20 --print-status 1

law run FeaturePlot --version prod_240410 --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240410_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png \
  --stack --log-y --workers 20


#### 
law run FeaturePlot --version prod_240410_oldPrecounter --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png \
  --stack --log-y --workers 20 --print-status 1

law run FeaturePlot --version prod_240410_oldPrecounter --PrePlot-skip-processing --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png  \
  --stack --log-y --workers 20





#################### Fixing with Elena

####################
####################
####################

# Inclusive with genWeightFixed

law run MergeCategorizationStatsWrapper --version prod_240411_weightsOne --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM_aux \
 --workers 40 --PreCounter-weights-file weights --systematic-names pu 

law run PrePlot --version prod_240411_weightsOne --PrePlot-skip-processing  --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-name wjets_MLM \
 --workers 20 --print-status 1

# LO
law run FeaturePlot --version prod_240411_weightsOne --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240411_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png \
  --stack --log-y --workers 20

# NNLO
law run FeaturePlot --version prod_240411_weightsOne_NNLO --PrePlot-version prod_240411_weightsOne --PrePlot-skip-processing --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240411_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png \
  --stack --log-y --workers 20

####################
####################
####################

# Inclusive with old genWeight

# fix total weight before
law run MergeCategorizationStatsWrapper --version prod_240411_oldWeights --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_MLM_aux \
 --workers 40 --PreCounter-weights-file weights --systematic-names pu 

law run PrePlot --version prod_240411_oldWeights --PrePlot-skip-processing  --config-name ul_2018_ZZ_v12 --category-name base_oldGenWeight \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-name wjets_MLM \
 --workers 20 --print-status 1

# using prod_240305 for PreCounter that has PU weight as well
law run FeaturePlot --version prod_240411_oldWeights --PrePlot-skip-processing  --config-name ul_2018_ZZ_v12 --category-name base_oldGenWeight \
 --MergeCategorizationStats-version prod_240305 \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png \
  --stack --log-y --workers 20

####################
####################
####################

# Colmparison between Inclusive with genWeightFixed and HT1 with genWeightFixed

law run MergeCategorizationStatsWrapper --version prod_240411_weightsOne --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8_aux \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu 

law run PrePlot --version prod_240411_weightsOne --PrePlot-skip-processing  --PrePlot-preplot-modules-file modulesrdf_preplot_fixGenWeight --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-name wjets_ht8 \
 --workers 20 --print-status 1

# LO
law run FeaturePlot --version prod_240411_weightsOne --PrePlot-skip-processing  --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240411_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png \
  --stack --log-y --workers 20

# NNLO
law run FeaturePlot --version prod_240411_weightsOne_NNLO --PrePlot-version prod_240411_weightsOne --PrePlot-skip-processing  --config-name ul_2018_ZZ_v12 --category-name base_genWeight \
 --MergeCategorizationStats-version prod_240411_weightsOne \
 --feature-names LHE_HT,LHE_HT_low \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png \
  --stack --log-y --workers 20