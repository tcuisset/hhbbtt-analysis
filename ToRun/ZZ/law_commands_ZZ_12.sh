# BoostedTaus 5th prod (fix e-tau trigger)
# prod_250314 : fix etau trigger
# prod_250315 : tight DeepTauVsEle in etau channel + bjet eta cut fix for 2016
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018


########## NOTES
## preprocess
# tt_fh takes more than 2 hours 

# preplot
# res1b tt_sl tt_fh tt_dl  dy_ptz1/2/3 st_tw_top st_tw_antitop st_top st_antitop tth_tautau take more than 2 hours on condor

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
# systematics : jec_1 jer tes met_unclustered ele_scale ele_resolution
# 16 systematics : total 1+2*16 = 33 systs

# central only
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags nonDefault --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 150 --workers 40 --PreprocessRDF-tasks-per-job 4

# systs
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data,nonDefault --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 17 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=short,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 100 --workers 50 --PreprocessRDF-tasks-per-job 1

# data
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=long,WNTag=el9,request_memory=3.2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 40 --PreprocessRDF-tasks-per-job 4




hpsData
############################################################################# DNN SAMPLES
# main systs : tes,jec_9,jec_10,jec_11,jec_1,met_unclustered
# skipping ele systs 
# --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered
law run CategorizationWrapper --version prod_250307 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data,nonDefault --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_DNNtraining  \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-tasks-per-job 20 --workers 30 --print-status 0

law run CategorizationWrapper --version prod_250314 --PreprocessRDF-version prod_250314 --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data,nonDefault --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_DNNtraining  \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-tasks-per-job 15 --workers 30


###################" cross trigger debug"
law run MergePrePlotWrapper --version prod_250314_fromPreproc  --PreprocessRDF-version prod_250314 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal,nonDefault  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 40 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll
law run FeaturePlotWrapper --version prod_250314_fromPreproc_crossTrigger --FeatureHistogram-version prod_250314_fromPreproc_crossTrigger --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250314_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10

law run FeaturePlotWrapper --version prod_250314_fromPreproc_crossTrigger --FeatureHistogram-version prod_250314_fromPreproc_crossTrigger --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250307_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 




####################################### categorization
law run CategorizationDNNBatchWrapper --version prod_250315 --skip-dataset-tags data,nonDefault --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50

 wjets_ht3,st_antitop,st_tw_top,GluGluToXToZZTo2B2Tau_M2600,zz_sl_background,dy_1j,wminush_htt,st_tw_top,zz_sl_background,tt_sl,tt_dl


