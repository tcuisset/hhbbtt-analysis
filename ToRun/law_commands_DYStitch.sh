###################################################################################################################
# FINAL VALIDATION 2018
###################################################################################################################

# DY not stitched
# First remove the "DYstitchEasyWeight" from weights inside ul_2018_v12.py
law run FeaturePlot --version prod_240320 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_incl --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_ptz --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_nj --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

# DY stitched
# Put back the "DYstitchEasyWeight" inside ul_2018_v12.py (the PrePlot has to be rerun!)
law run FeaturePlot --version prod_240321 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

# Wjets stitched
law run FeaturePlot --version prod_240322 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_split --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

# Fix cut at ULv9 level
law run FeaturePlot --version prod_240323 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_split --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

# Fix inclusive sample from FXFX to MLL still not ok
law run FeaturePlot --version prod_240324 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_split --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

law run FeaturePlot --version prod_240321_MLM --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240321_FXFX --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names wjets_FXFX \
 --process-group-name wjets_fxfx --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

###################################################################################################################
# FAST STUDIES
###################################################################################################################

law run PreprocessRDFWrapper --version prod_240320 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_FXFX,wjets_MLM,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
wjets_MLM_1j,wjets_MLM_2,wjets_MLM_3j,wjets_MLM_4j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --PreprocessRDF-modules-file modulesrdf_Wjets \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_Wjets --workers 30 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run MergeCategorizationStatsWrapper --version prod_240320 --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_FXFX_aux,wjets_MLM_aux,wjets_FXFX_0j_aux,wjets_FXFX_1j_aux,wjets_FXFX_2j_aux,\
wjets_MLM_1j_aux,wjets_MLM_2_aux,wjets_MLM_3j_aux,wjets_MLM_4j_aux,\
wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8 \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run CategorizationWrapper --version prod_240320 --category-names base --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_FXFX,wjets_MLM,wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j,\
wjets_MLM_1j,wjets_MLM_2,wjets_MLM_3j,wjets_MLM_4j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --PreprocessRDF-version prod_240320 \
 --Categorization-base-category-name base_selection --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run FeaturePlot --version prod_240320_0 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,LHE_NpNLO,LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240320  \
 --dataset-names wjets_FXFX \
 --process-group-name wjets_fxfx --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320_0 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,LHE_NpNLO,LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240320  \
 --dataset-names wjets_MLM \
 --process-group-name wjets_mlm --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320_0 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,LHE_NpNLO,LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240320  \
 --dataset-names wjets_FXFX_0j,wjets_FXFX_1j,wjets_FXFX_2j \
 --process-group-name wjets_fxfx_Nj --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320_0 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,LHE_NpNLO,LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240320  \
 --dataset-names wjets_MLM_1j,wjets_MLM_2,wjets_MLM_3j,wjets_MLM_4j \
 --process-group-name wjets_mlm_Nj --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y
law run FeaturePlot --version prod_240320_0 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_HT,LHE_NpNLO,LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240320  \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 \
 --process-group-name wjets_mlm_HT --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y

###################################################################################################################
# OLD STUDIES
###################################################################################################################

# Plot DY split
law run FeaturePlot --version prod_240314_PtZ --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_Nj --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_Incl --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_DYStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

law run FeaturePlot --version prod_240314_PtZ_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_Nj_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_Incl_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_DYNoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240314_DYNoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name zz --save-root --save-png --category-name base \
 --region-name os_iso --stack

###################################################################################################################
# Update DY inclusive cross section from 6077.22 to 6404.0
###################################################################################################################

# Plot DY split
law run FeaturePlot --version prod_240319_PtZ --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Nj --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Incl --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_DYStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

#########################################################################################################
# Removing DYStitching weights from the plotting

law run FeaturePlot --version prod_240319_PtZ_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Nj_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Incl_NoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_DYNoStitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

#########################################################################################################
# Removing DYStitching weights from the plotting and from total_weights

law run FeaturePlot --version prod_240319_PtZ_NoStitchWeight --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Nj_NoStitchWeight --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Incl_NoStitchWeight --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_DYNoStitchWeight --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

#########################################################################################################

# WRONG! USE AUX
# WRONG! TOTAL EVENT WEIGHT IS USED AT PRECOUNTER LEVEL
law run MergeCategorizationStatsWrapper --version prod_240319 --config-name ul_2018_ZZ_v12 \
 --dataset-names dy_aux,dy_ptz1_aux,dy_ptz2_aux,dy_ptz3_aux,dy_ptz4_aux,dy_ptz5_aux,dy_ptz6_aux,dy_0j_aux,dy_1j_aux,dy_2j_aux \
 --workers 50 --PreCounter-weights-file weights_test --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# Removing DYStitching weights from the plotting and normalization

law run FeaturePlot --version prod_240319_PtZ_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240319 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Nj_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240319 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_Incl_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240319 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240319_DYNoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240319 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

#########################################################################################################

# new definition of the XS!
law run MergeCategorizationStatsWrapper --version prod_240320 --config-name ul_2018_ZZ_v12 \
 --dataset-names dy_aux,dy_ptz1_aux,dy_ptz2_aux,dy_ptz3_aux,dy_ptz4_aux,dy_ptz5_aux,dy_ptz6_aux,dy_0j_aux,dy_1j_aux,dy_2j_aux \
 --workers 50 --PreCounter-weights-file weights_test --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run MergeCategorizationStatsWrapper --version prod_240320 --config-name ul_2018_ZZ_v12 \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run FeaturePlot --version prod_240320_PtZ_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_Nj_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_Incl_NoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_DYNoStitchAll --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

law run FeaturePlot --version prod_240320_PtZ_Stitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_Nj_Stitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_Incl_Stitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack
law run FeaturePlot --version prod_240320_Stitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

# this config works!
# it means we don't have to use the Stitching weight at PreCounter level
law run FeaturePlot --version prod_240321_Stitch --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240320 --Categorization-version prod_240312  \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack

###################################################################################################################
###################################################################################################################
###################################################################################################################
# Other tests
# 
law run PreprocessRDFWrapper --version prod_240301 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_background  --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'
law run CategorizationWrapper --version prod_240301 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_background \
 --PreprocessRDF-version prod_240301 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# 
law run PreprocessRDFWrapper --version prod_240302 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --PreprocessRDF-modules-file modulesrdf_DY \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'
law run CategorizationWrapper --version prod_240302 --category-names base --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --PreprocessRDF-version prod_240302 \
 --Categorization-base-category-name base_selection \
 --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# Note: The weights are applied during the preplot!!
# - Test 1: dy prod_240305_1 (DYStistiching in base)
# - Test 2: dy prod_240305_2 (no DYStistiching in base)
# - Test 3: dy prod_240305_3 (no DYStistiching in base and no in total)
# - Test 3: dy*3 prod_240305_4 (DYStistiching in base)
# v12
law run FeaturePlot --version prod_240305_4 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names bjet1_pt \
 --workers 20  --MergeCategorizationStats-version prod_240301 --Categorization-version prod_240302 \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name base \
 --region-name os_iso --stack
# v10
law run FeaturePlot --version prod_240305_1 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names bjet1_pt \
 --workers 20  --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --dataset-names dy \
 --process-group-name zz_total_data --save-root --save-png --hide-data True  --category-name base \
 --region-name os_iso --stack


# Test for new DY and Wjets stitching
law run PreprocessRDFWrapper --version prod_240301 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j --PreprocessRDF-modules-file modulesrdf \
  --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50
law run PreprocessRDFWrapper --version prod_240301 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 --PreprocessRDF-modules-file modulesrdf 

law run CategorizationWrapper --version prod_240301 --category-names ZZ_elliptical_cut_80_etau --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --PreprocessRDF-version prod_240301 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run MergeCategorizationStatsWrapper --version prod_240301 --config-name ul_2018_ZZ_v12 \
 --dataset-names wjets_ht1_aux,wjets_ht2_aux,wjets_ht3_aux,wjets_ht4_aux,wjets_ht5_aux,wjets_ht6_aux,wjets_ht7_aux,wjets_ht8_aux,dy_aux,dy_ptz1_aux,dy_ptz2_aux,dy_ptz3_aux,dy_ptz4_aux,dy_ptz5_aux,dy_ptz6_aux,dy_0j_aux,dy_1j_aux,dy_2j_aux \
 --workers 10 --PreCounter-weights-file weights \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# test before submitting full 2018: testing max events option
law run PreprocessRDFWrapper --version prod_240305_test --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_background --max-events 10000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# test eos
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_signal \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'