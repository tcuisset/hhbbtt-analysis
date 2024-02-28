# Cross-check to look at mbb vs mtt 2D plots for different backgrounds

law run FeaturePlot2D --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128  \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --stack --workers 20 --region-name etau_os_iso --print-status 5

law run FeaturePlot2D --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128  \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --stack --workers 20 --region-name mutau_os_iso

law run FeaturePlot2D --version prod_240128  --category-name base --config-name ul_2018_ZbbHtt_v10 \
 --PrePlot2D-workflow local --PrePlot2D-version prod_240128  \
 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240128 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --skip-dataset-tags secondary --skip-dataset-names 'data_*' \
 --process-group-name datacard_ZbbHtt_res --save-root --save-png --stack --workers 20 --region-name tautau_os_iso