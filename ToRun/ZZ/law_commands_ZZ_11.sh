# BoostedTaus 4th prod (systematics, hem veto, etc)
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
law run PreprocessRDFWrapper --version prod_250307 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags nonDefault --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=3.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 200 --workers 70


law run PreprocessRDFWrapper --version prod_250307 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data,nonDefault --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 11 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 100 --workers 70 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250307 --category-name base_selection --config-name bul_${YEAR}_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 11 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 70



# pilot
law run MergeCategorizationWrapper --version prod_250307   --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --PreprocessRDF-category-name base_selection  \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data --dataset-names dy_2j \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5

# data
law run PreprocessRDFWrapper --version prod_250307 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light  \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 25


hpsData
############################################################################# DNN SAMPLES
# main systs : tes,jec_9,jec_10,jec_11,jec_1,met_unclustered
# skipping ele systs 
law run CategorizationWrapper --version prod_250307 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data,nonDefault --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_DNNtraining --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-tasks-per-job 10 --workers 20 --print-status 0


############################################################################# CATEGORIZATION
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250307 --skip-dataset-tags data,nonDefault --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250307 --skip-dataset-tags data,nonDefault --config-name bul_2018_ZbbHtt_v12 \
 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 70 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=4G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20

law run MergeCategorizationWrapper --version prod_250307 --Categorization-version prod_250307  --config-name bul_${YEAR}_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags data,nonDefault \
  --workers 10

# running all at once
law run MergeCategorizationWrapper --version prod_250307 --Categorization-version prod_250307  --config-name bul_${YEAR}_ZZ_v12  \
 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags data,nonDefault \
  --workers 10

# data
law run MergeCategorizationWrapper --version prod_250307 --Categorization-version prod_250307  --config-name bul_${YEAR}_ZZ_v12  --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run  \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --MergeCategorization-from-DNN-inference True  \
 --dataset-tags data \
  --workers 5



# Control region ,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution
# use different version otherwise condor tags are same....
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250307_CR --PreprocessRDF-version prod_250307 --PreprocessRDF-no-run --skip-dataset-tags data,nonDefault --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_ultralight \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_CR --CategorizationDNNBatchRunner-systematic-names central \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=4G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 30

law run MergeCategorizationWrapper --version prod_250307_CR --Categorization-version prod_250307_CR --config-name bul_${YEAR}_ZZ_v12  \
 --PreprocessRDF-version prod_250307 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_ultralight \
 --category-names ZZ_EC90_CR  \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags data,nonDefault \
  --workers 10

#######################################################################""" PrePlot"
law run PrePlotWrapper --version prod_250307  --MergeCategorization-version prod_250307  --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data,nonDefault \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr  --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200




law run MergePrePlotWrapper --version prod_250307  --MergeCategorization-version prod_250307 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data,nonDefault \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr  --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --workers 20




law run MergePrePlotWrapper --version prod_250307  --MergeCategorization-version prod_250307 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --workers 5



############################################### FeatureHistogram
# plots non res
law run FeatureHistogramWrapper --version prod_250307 --PrePlot-version prod_250307  --MergeCategorizationStats-version prod_250307 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags resOnly,resSignal --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 10



law run FeaturePlotWrapper --version prod_250307 --FeatureHistogram-version prod_250307 --PrePlot-version prod_250307  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
# law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
#  --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind  --FeaturePlot-process-group-name zz_res_limitedMass \
#  --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
#    --workers 5

########## datacards
# non resonant
# pilot (memory usgae=5.5G)
law run FeatureHistogramWrapper --version prod_250307_nonResDatacards_v1 --MergePrePlot-version prod_250307 --PrePlot-version prod_250307 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal --FeatureHistogram-feature-tags dnn --FeatureHistogram-skip-feature-tags dnn_extra --FeatureHistogram-process-group-name datacard_zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 5

law run FeatureHistogramWrapper --version prod_250307_nonResDatacards_v1 --MergePrePlot-version prod_250307 --PrePlot-version prod_250307 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 10

for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250307_nonResDatacards_v1 --MergePrePlot-version prod_250307 --PrePlot-version prod_250307 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags resOnly,resSignal --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz   --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done



law run CreateDatacardsWrapper --version prod_250307_nonResDatacards_v2 --FeaturePlot-version prod_250307_nonResDatacards_v1 --FeatureHistogramRebin-version prod_250307_nonResDatacards_v1 --FeatureHistogram-version prod_250307_nonResDatacards_v1 --config-name bul_${YEAR}_ZZ_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal --FeatureHistogram-skip-dataset-tags resOnly,resSignal --CreateDatacards-feature-names dnn_ZZbbtt_500b \
 --CreateDatacards-process-group-name datacard_zz  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False \
 --make-plots --FeaturePlot-feature-names dnn_ZZbbtt_500b --FeaturePlot-skip-dataset-tags resOnly,resSignal --FeaturePlot-process-group-name datacard_zz \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --workers 10

law run CreateDatacards --version prod_250307_nonResDatacards_v2 --FeatureHistogramRebin-version prod_250307_nonResDatacards_v1 --FeatureHistogram-version prod_250307_nonResDatacards_v1 --config-name bul_${YEAR}_ZZ_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal --FeatureHistogram-skip-dataset-tags resOnly,resSignal --CreateDatacards-feature-names dnn_ZZbbtt_500b \
 --CreateDatacards-process-group-name datacard_zz  --category-name ZZ_EC90_resolved_1b_HPSTau --region-name mutau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False



# resonant
law run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 2


for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done




####################################### FeaturePlot