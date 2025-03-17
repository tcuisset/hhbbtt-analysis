# BoostedTaus third prod (systematics, hem veto, etc)
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

# prod_250217 : 2018 with bugged HEM weight
# prod_250218 : 2017 prod

########## NOTES
## preprocess
# tt_fh takes more than 2 hours 

# preplot
# res1b tt_sl tt_fh tt_dl  dy_ptz1/2/3 st_tw_top st_tw_antitop st_top st_antitop tth_tautau take more than 2 hours on condor

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
# systematics : jec_1 jer tes met_unclustered ele_scale ele_resolution
# 16 systematics : total 1+2*16 = 33 systs

# pilots

law run PreprocessRDFWrapper --version prod_250217 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 11 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 50 --workers 30 --PreprocessRDF-tasks-per-job 1

# no systs

law run PreprocessRDFWrapper --version prod_250225 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 100 --workers 50 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250225 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1

law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 1 --workers 80
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 10 --workers 40


# 2017
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2017_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 12 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 200 --workers 20 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2017_ZZ_v12 \
 --dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 1 --workers 40
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2017_ZZ_v12 \
 --dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 10 --workers 40

# 2016
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 12 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 200 --workers 30 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 1 --workers 40
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 10 --workers 40

# 2016 HIPM
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 12 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --PreprocessRDF-parallel-jobs 200 --workers 30 --PreprocessRDF-tasks-per-job 1


################# 
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250217 --skip-dataset-tags data --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-version prod_250217 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100
--print-status 3
# failures
ww_lnuqq,wjets_ht3,st_tw_top
#  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --DNNInferenceBatchRunner-poll-interval 7 --DNNInferenceBatchRunner-retries 0 \
# --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100



LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250218 --skip-dataset-tags data --config-name bul_2017_ZZ_v12 \
 --PreprocessRDF-version prod_250218 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250218 --dataset-tags data --config-name bul_2017_ZZ_v12 \
 --PreprocessRDF-version prod_250218 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-poll-interval 5 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=3G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100



# 2016
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250218 --skip-dataset-tags data --config-name bul_2016_ZZ_v12 \
 --PreprocessRDF-version prod_250218 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100

# 2016 HIPM
LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250218 --skip-dataset-tags data --config-name bul_2016_HIPM_ZZ_v12 \
 --PreprocessRDF-version prod_250218 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --CategorizationDNNBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100


############## mergecategorization
law run MergeCategorizationWrapper --version prod_250218   --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data --skip-dataset-names wjets_ht3,tt_dl,tt_sl,st_tw_top,ww_lnuqq \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5

law run MergeCategorizationWrapper --version prod_250218   --config-name bul_2017_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 30
law run MergeCategorizationWrapper --version prod_250218   --config-name bul_2017_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --dataset-tags data \
  --workers 10


# 2016
law run MergeCategorizationWrapper --version prod_250218   --config-name bul_2016_ZZ_v12 --PreprocessRDF-version prod_250218 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 30
law run MergeCategorizationWrapper --version prod_250218   --config-name bul_2016_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --dataset-tags data \
  --workers 10

####################### Preplot
law run PrePlot --version prod_250218  --config-name bul_2017_ZZ_v12 \
  --dataset-name dy_2j \
  --category-name ZZ_EC90_boosted_bb_boostedTau  \
  --PrePlot-region-names etau_os_iso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot 


law run PrePlotWrapper --version prod_250218 --PreprocessRDF-no-run --Categorization-no-run --MergeCategorization-from-DNN-inference True --config-name bul_2017_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=100,T3queue=short,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200
law run PrePlotWrapper --version prod_250218 --PreprocessRDF-no-run --Categorization-no-run --MergeCategorization-from-DNN-inference True --config-name bul_2017_ZZ_v12 \
  --dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-poll-interval 5  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"'  --workers 100



law run MergePrePlotWrapper --version prod_250218  --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso --workers 25

######################### PLOT
law run FeatureHistogramWrapper --version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_limited --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-process-group-name zz_res \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 10


# unblinded features
# 
law run FeaturePlotWrapper --version prod_250218 --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-dataset-names-after-skip GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
law run FeaturePlotWrapper --version prod_250218_nosignal --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
# QCD CR
law run FeaturePlotWrapper --version prod_250218_nosignal --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10

# blinded DNN
law run FeaturePlotWrapper --version prod_250218_blind --FeatureHistogram-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-blinded --FeaturePlot-feature-tags dnn_limited  --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-dataset-names-after-skip GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd True  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False --FeatureHistogram-hide-data False \
  --workers 10


# indiviudal features
law run FeaturePlotWrapper --version prod_250218_nosignal --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-names dR_tautau_low --FeaturePlot-rebin 3 --FeaturePlot-skip-dataset-tags nonResOnly,resSignal  --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data True --FeaturePlot-plot-systematics False --FeatureHistogram-hide-data False \
   --workers 10


############ crashed
law run PreprocessRDFWrapper --version prod_250218 --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 12 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 200 --workers 30 --PreprocessRDF-tasks-per-job 1




######################### PLOT NON RESONANT ####################################################################

law run FeatureHistogramWrapper --version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags resOnly --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 10


# unblinded features
# 
law run FeaturePlotWrapper --version prod_250218_nonres --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
law run FeaturePlotWrapper --version prod_250218_nonres --FeatureHistogram-version prod_250218 --PrePlot-version prod_250218  --MergeCategorizationStats-version prod_241024 --config-name bul_2017_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False --FeaturePlot-rebin 3 \
   --workers 10


### actual plotting
function featurePlotZbbHtt_SR_nonres {
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3

    law run FeaturePlot --version prod_240528_nonres --FeatureHistogram-version prod_240528_nonres --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names $ALL_FEATURES_ZbbHtt_old \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --workers 5 --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240522 \
 --process-group-name plot --save-png --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY --region-name ${REGION_NAME}_os_iso \
 --stack --do-qcd --hide-data True "${@:4}"
}
declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 1000." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
for logParams in "${logCommands[@]}"; do
for category in resolved_2b resolved_1b boosted_noPNet; do
featurePlotZbbHtt_SR_nonres $category etau $DATASETS_DATA_ETAU $logParams & 
featurePlotZbbHtt_SR_nonres $category mutau $DATASETS_DATA_MUTAU $logParams & 
featurePlotZbbHtt_SR_nonres $category tautau $DATASETS_DATA_TAUTAU $logParams & 
done
wait
done




function makeNonResonantDatacards_ZbbHtt(){
    CATEGORY=$1
    REGION_NAME=$2
    DATASETS_DATA=$3
    # CHECK features : $ALL_FEATURES_ZbbHtt_old or dnn_ZHbbtt_kl_1,ZHKinFit_mass
    law run FeatureHistogram --version prod_240528_nonres_fixXS --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso "${@:4}" \
&& \
    law run CreateDatacards --version prod_240528_nonres_fixXS --FeaturePlot-version prod_240528_nonres_fixXS --FeatureHistogram-version prod_240528_nonres_fixXS --PrePlot-version prod_240522 --config-name ul_${YEAR}_ZbbHtt_v12 \
 --feature-names dnn_ZHbbtt_kl_1,ZHKinFit_mass --workers 5 --MergeCategorizationStats-version prod_240305 \
 --dataset-names $DATASETS_ZH_nonres,$DATASETS_DATA \
 --process-group-name datacard --hide-data True  --category-name ZbbHtt_orthogonal_cut_90_$CATEGORY \
 --region-name ${REGION_NAME}_os_iso --FeaturePlot-hide-data True  "${@:4}"
}
# QCD only for resolved_1b
makeNonResonantDatacards_ZbbHtt resolved_1b etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt resolved_1b tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
for category in  resolved_2b boosted_noPNet; do
makeNonResonantDatacards_ZbbHtt $category etau $DATASETS_DATA_ETAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt $category mutau $DATASETS_DATA_MUTAU --do-qcd --propagate-syst-qcd &
makeNonResonantDatacards_ZbbHtt $category tautau $DATASETS_DATA_TAUTAU --do-qcd --propagate-syst-qcd &
done