# now debug for boosted category

law run PreprocessRDF --version prod_240208 --category-name base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-name zz_sl_signal \
 --PreprocessRDF-modules-file modulesrdf_ZZ_1 --branch 0

law run Categorization --version prod_240126 --category-name base --config-name ul_2018_ZZ_v10 \
 --dataset-name zz_sl_signal \
 --Categorization-base-category-name base_selection --Categorization-keep-and-drop-file keep_and_drop_file \
 --workers 50 --PreprocessRDF-version prod_240126 --branch 0 --Categorization-feature-modules-file modulesrdf_ZZ_2 

law run PreprocessRDF --version prod_240208 --category-name base_selection --config-name ul_2018_ZZ_v10 --dataset-name zz_sl_signal \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0

# PREPROCESS NEW BOOSTED CATEGORY FOR JETS (CHECKOUT AFTER TESTING)
law run PreprocessRDFWrapper --version prod_240208 --category-names base_selection --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# CATEGORIZATION ONLY ELLIPTICAL CUT
law run CategorizationWrapper --version prod_240208 --category-names ZZ_elliptical_cut_80_sr --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --PreprocessRDF-version prod_240208 \
 --Categorization-feature-modules-file modulesrdf_Ellipse --Categorization-base-category-name base_selection \
 --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# PLOT BOOSTED VARIABLE ONLY
law run FeaturePlot --version prod_240210 --PrePlot-version prod_240210 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names boosted \
 --dataset-names zz_sl_signal,ggXZZbbtt_M200,ggXZZbbtt_M300,ggXZZbbtt_M400,ggXZZbbtt_M500,ggXZZbbtt_M600,ggXZZbbtt_M700,ggXZZbbtt_M800,ggXZZbbtt_M900,ggXZZbbtt_M1000,ggXZZbbtt_M1100,ggXZZbbtt_M1200,ggXZZbbtt_M1300,ggXZZbbtt_M1400,ggXZZbbtt_M1500,ggXZZbbtt_M2000,ggXZZbbtt_M3000 \
 --workers 50 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240208  \
 --process-group-name ggXZZbbtt --save-root --save-png --category-name ZZ_elliptical_cut_80_sr --region-name os_iso \
 --save-yields --stack