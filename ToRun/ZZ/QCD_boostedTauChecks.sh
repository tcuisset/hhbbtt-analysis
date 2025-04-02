# from law_commands_ZZ_12

################# QCD checks boostedTau_CR
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags qcd --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=100,T3queue=long,WNTag=el9,request_memory=3.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 50


law run MergeCategorizationWrapper --version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --dataset-tags qcd \
  --category-names boostedTau_CR  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 4 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70

law run MergeCategorizationWrapper --version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --skip-dataset-tags nonDefault,hpsData \
  --category-names boostedTau_CR  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 4 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70

law run MergePrePlotWrapper --version prod_250315   --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name boostedTau_CR \
  --skip-dataset-tags resSignal,hpsData  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 80

# QCD with ABCD method
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
# QCD from MC
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz_qcd_mc_split \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10

# QCD tautau_doubleInversion_os_iso
law run PrePlotWrapper --version prod_250315   --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name boostedTau_CR \
  --skip-dataset-tags resSignal,hpsData  --PrePlot-store-systematics False \
  --region-names tautau_doubleInversion_os_iso,tautau_doubleInversion_ss_iso,tautau_doubleInversion_os_inviso,tautau_doubleInversion_ss_inviso,tautau_doubleWideInversion_os_iso,tautau_doubleWideInversion_ss_iso,tautau_doubleWideInversion_os_inviso,tautau_doubleWideInversion_ss_inviso \
  --PrePlot-feature-tags base,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 80
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names tautau_doubleInversion_os_iso,tautau_doubleWideInversion_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10


## QCD CR
# etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso

law run FeaturePlotWrapper --version prod_250315_QCD_CR --FeatureHistogram-version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso,tautau_doubleInversion_ss_iso,tautau_doubleInversion_os_inviso,tautau_doubleInversion_ss_inviso,tautau_doubleWideInversion_ss_iso,tautau_doubleWideInversion_os_inviso,tautau_doubleWideInversion_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz_qcd_mc_split \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10



### testing shape_region : --FeatureHistogram-shape-region
law run FeaturePlotWrapper --version prod_250315_QCD_shape_region_ss --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso,tautau_doubleInversion_os_iso,tautau_doubleWideInversion_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-shape-region ss_iso





##################### for AN

# QCD with ABCD method
# prod_250315_QCD_shape_region_ss
law run FeaturePlotWrapper --version prod_250315_QCD_shape_region_ss_AN --FeatureHistogram-version prod_250315_QCD_shape_region_ss --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
  --FeaturePlot-feature-names dR_tautau_low --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-rebin-factor 2

# QCD from MC
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz_qcd_mc_split \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10

# QCD tautau_doubleInversion_os_iso
law run PrePlotWrapper --version prod_250315   --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name boostedTau_CR \
  --skip-dataset-tags resSignal,hpsData  --PrePlot-store-systematics False \
  --region-names tautau_doubleInversion_os_iso,tautau_doubleInversion_ss_iso,tautau_doubleInversion_os_inviso,tautau_doubleInversion_ss_inviso,tautau_doubleWideInversion_os_iso,tautau_doubleWideInversion_ss_iso,tautau_doubleWideInversion_os_inviso,tautau_doubleWideInversion_ss_inviso \
  --PrePlot-feature-tags base,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 80
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names tautau_doubleInversion_os_iso,tautau_doubleWideInversion_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10


## QCD CR
# etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso
# ,tautau_doubleInversion_ss_iso,tautau_doubleInversion_os_inviso,tautau_doubleInversion_ss_inviso,tautau_doubleWideInversion_ss_iso,tautau_doubleWideInversion_os_inviso,tautau_doubleWideInversion_ss_inviso
# mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,
law run FeaturePlotWrapper --version prod_250315_QCD_CR_AN --FeatureHistogram-version prod_250315 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-names dR_tautau_low --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz_qcd_mc \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False --FeaturePlot-rebin-factor 2 \
   --workers 10



# ### testing shape_region : --FeatureHistogram-shape-region
# law run FeaturePlotWrapper --version prod_250315_QCD_shape_region_ss --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso,tautau_doubleInversion_os_iso,tautau_doubleWideInversion_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
#  --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
#  --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
#    --workers 10 --FeaturePlot-shape-region ss_iso
