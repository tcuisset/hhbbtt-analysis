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
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 150 --workers 40 --PreprocessRDF-tasks-per-job 1

# data
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=3.2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 40 --PreprocessRDF-tasks-per-job 1

## ZH
YEAR=2016_HIPM
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 17 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 50
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZttHbb_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 17 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 70

# Y=16_HIPM
# cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZZ_v12/data_met_*.txt /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZbbHtt_v12/
# cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZZ_v12/data_met_*.txt /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZttHbb_v12/
# cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZZ_v12/data_*.txt /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZbbHtt_v12/
# cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZZ_v12/data_*.txt /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_20${Y}_ZttHbb_v12/

hpsData
############################################################################# DNN SAMPLES
# main systs : tes,jec_9,jec_10,jec_11,jec_1,met_unclustered
# skipping ele systs 
# --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered



law run CategorizationWrapper --version prod_250315b --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data,nonDefault --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_DNNtraining  \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-tasks-per-job 5 --systematic-names central,tes,jec_9,jec_10,jec_11,jec_1,met_unclustered --workers 10

# cutflow
law run CategorizationWrapper --version prod_250315 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-tags nonResSignal,resLimited --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names base  \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-1,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --systematic-names central --workers 30


####################################### categorization
law run CategorizationDNNBatchWrapper --version prod_250315 --skip-dataset-tags nonDefault --config-name bul_${YEAR}_ZZ_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 50 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 60

--skip-dataset-names data_mutau_c

law run MergeCategorizationWrapper --version prod_250315 --Categorization-version prod_250315  --config-name bul_${YEAR}_ZZ_v12 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --Categorization-no-run False \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags nonDefault \
  --workers 30



law run CategorizationDNNBatchWrapper --version prod_250315 --skip-dataset-tags nonDefault --config-name bul_${YEAR}_ZbbHtt_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 70 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20
law run CategorizationDNNBatchWrapper --version prod_250315 --skip-dataset-tags nonDefault --config-name bul_${YEAR}_ZttHbb_v12 \
 --PreprocessRDF-version prod_250315 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-parallel-jobs 70 --CategorizationDNNBatchRunner-poll-interval 15 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20

law run MergeCategorizationWrapper --version prod_250315 --Categorization-version prod_250315  --config-name bul_${YEAR}_ZbbHtt_v12 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --Categorization-no-run False \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags nonDefault \
  --workers 10
law run MergeCategorizationWrapper --version prod_250315 --Categorization-version prod_250315  --config-name bul_${YEAR}_ZttHbb_v12 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --Categorization-no-run False \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --skip-dataset-tags nonDefault \
  --workers 10


############## preplot


# no request_memory as it's automatic
law run MergePrePlotWrapper --version prod_250315  --MergeCategorization-version prod_250315 --MergeCategorization-from-DNN-inference True --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags nonDefault \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr  --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --workers 20


law run MergePrePlotWrapper --version prod_250315  --MergeCategorization-version prod_250315 --MergeCategorization-from-DNN-inference True --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
 --skip-dataset-tags nonDefault \
  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr  --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --workers 10
law run MergePrePlotWrapper --version prod_250315  --MergeCategorization-version prod_250315 --MergeCategorization-from-DNN-inference True --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
 --skip-dataset-tags nonDefault \
  --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau  \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr  --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --workers 10

############### plot from preprocess (baseline)

# no systs
law run MergePrePlotWrapper --version prod_250315_fromPreproc  --PreprocessRDF-version prod_250315 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal,nonDefault  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base  --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 30 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50

law run FeaturePlotWrapper --version prod_250315_fromPreproc --FeatureHistogram-version prod_250315_fromPreproc --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 15

# systs
law run MergePrePlotWrapper --version prod_250315_fromPreproc_systs  --PreprocessRDF-version prod_250315 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal,nonDefault  --PrePlot-store-systematics True \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base  --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 15 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=long,WNTag=el9,request_memory=3.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll

law run FeaturePlotWrapper --version prod_250315_fromPreproc_systs --FeatureHistogram-version prod_250315_fromPreproc_systs --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250315_fromPreproc_systs --PreprocessRDF-version prod_250315  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics True --FeatureHistogram-store-systematics True --FeaturePlot-plot-systematics True --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 7



############################### plot
law run RunPlots --version prod_250315 --years 2017 --mode plot --PrePlot-version prod_250315 --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot 

law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 4
law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name plot \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 10
law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZttHbb_v12 \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name plot \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 10


# ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau
# plots non res
for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh \
$(which law) run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names $CATEGORY --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 8
done



law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name plot \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5

# QCD CR
law run FeaturePlotWrapper --version prod_250315_qcdCR --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name plot \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
# law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
#  --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind  --FeaturePlot-process-group-name zz_res_limitedMass \
#  --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
#    --workers 5

########## datacards
# non resonant
# pilot (memory usgae=5.5G)
law run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v3 --MergePrePlot-version prod_250315 --PrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-feature-tags dnn --FeatureHistogram-skip-feature-tags dnn_extra --FeatureHistogram-process-group-name datacard_zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot  --workers 5

law run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v3 --MergePrePlot-version prod_250315 --PrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-feature-tags dnn_nonres --FeatureHistogram-process-group-name datacard_zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot  --workers 10

for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v1 --MergePrePlot-version prod_250315 --PrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-feature-tags dnn_nonres --FeatureHistogram-process-group-name datacard_zz   --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done

# ZbbHtt
# datacard for resolved, datacard_reduced for boosted
law run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v3 --MergePrePlot-version prod_250315 --PrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-feature-tags dnn_nonres --FeatureHistogram-process-group-name datacard \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot  --workers 5 \
  --FeatureHistogram-process-group-name datacard_reduced --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau --workers 5
# ZttHbb
law run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v3 --MergePrePlot-version prod_250315 --PrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZttHbb_v12 \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-feature-tags dnn_nonres --FeatureHistogram-process-group-name datacard \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot  --workers 5 \
  --FeatureHistogram-process-group-name datacard_reduced --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau --workers 5


# versions datacards : v6 : fixing templates varying down to 0
law run CreateDatacardsWrapper --version prod_250315_nonResDatacards_v6 --FeaturePlot-version prod_250315_nonResDatacards_v4 --FeatureHistogramRebin-version prod_250315_nonResDatacards_v4 --FeatureHistogram-version prod_250315_nonResDatacards_v3 --config-name bul_${YEAR}_ZZ_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --CreateDatacards-feature-names dnn_ZZbbtt_500bv \
 --CreateDatacards-process-group-name datacard_zz  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False \
 --make-plots --FeaturePlot-feature-names dnn_ZZbbtt_500bv --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name datacard_zz \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --workers 10

# ZH
law run CreateDatacardsWrapper --version prod_250315_nonResDatacards_v7 --FeaturePlot-version prod_250315_nonResDatacards_v4 --FeatureHistogramRebin-version prod_250315_nonResDatacards_v4 --FeatureHistogram-version prod_250315_nonResDatacards_v3 --config-name bul_${YEAR}_ZbbHtt_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --CreateDatacards-feature-names dnn_ZHbbtt_500bv \
 --CreateDatacards-process-group-name datacard  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False \
 --make-plots --FeaturePlot-feature-names dnn_ZHbbtt_500bv --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name datacard \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --workers 10 \
 --CreateDatacards-process-group-name datacard_reduced --FeaturePlot-process-group-name datacard_reduced --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau --FeaturePlot-log-y False --workers 10
law run CreateDatacardsWrapper --version prod_250315_nonResDatacards_v7 --FeaturePlot-version prod_250315_nonResDatacards_v4 --FeatureHistogramRebin-version prod_250315_nonResDatacards_v4 --FeatureHistogram-version prod_250315_nonResDatacards_v3 --config-name bul_${YEAR}_ZttHbb_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --CreateDatacards-feature-names dnn_ZHbbtt_500bv \
 --CreateDatacards-process-group-name datacard  --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False \
 --make-plots --FeaturePlot-feature-names dnn_ZHbbtt_500bv --FeaturePlot-skip-dataset-tags resOnly,resSignal,nonDefault --FeaturePlot-process-group-name datacard \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --workers 10 \
 --CreateDatacards-process-group-name datacard_reduced --FeaturePlot-process-group-name datacard_reduced --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau --FeaturePlot-log-y False --workers 10

law run CreateDatacards --version prod_250315_nonResDatacards_v1 --FeatureHistogramRebin-version prod_250315_nonResDatacards_v1 --FeatureHistogram-version prod_250315_nonResDatacards_v1 --config-name bul_${YEAR}_ZZ_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal --FeatureHistogram-skip-dataset-tags resOnly,resSignal --CreateDatacards-feature-names dnn_ZZbbtt_500bv \
 --CreateDatacards-process-group-name datacard_zz  --category-name ZZ_EC90_resolved_1b_HPSTau --region-name mutau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False



law run CreateDatacards --version prod_250315_nonResDatacards_v6_test1 --FeatureHistogramRebin-version prod_250315_nonResDatacards_v4 --FeatureHistogram-version prod_250315_nonResDatacards_v3 --config-name bul_2016_ZbbHtt_v12  \
  --CreateDatacards-skip-dataset-tags resOnly,resSignal,nonDefault --FeatureHistogram-skip-dataset-tags resOnly,resSignal,nonDefault --CreateDatacards-feature-names dnn_ZHbbtt_500bv \
 --CreateDatacards-process-group-name datacard  --category-name ZbbHtt_OC90_boosted_bb_HPSTau --region-name mutau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --FeatureHistogramRebin-hide-data False --FeatureHistogram-hide-data False --remove-output 0,a,True

################################################################################################################################################################################################################################################################################################################################################
################################################################################################################ DATACARDS RESONANT
################################################################################################################################################################################################################################
# Making resonant datacards : 
# 1) usual PrePlot with everything (can be shared with regular plotting)
# 2) FeatureHistogram with datacard_zz_res_reduced, incl. all resonant samples & all DNN masses
# 3) FeatureHistogramRebin, separately for each mass. 
# 4) CreateDatacards, separately for each mass


# versions :prod_250315_nonResDatacards_v1 accidentally named nonres but is resonant
law run FeatureHistogramWrapper --version prod_250315_nonResDatacards_v1 --MergePrePlot-version prod_250315 --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags nonResOnly,nonDefault --FeatureHistogram-feature-tags dnn_res --FeatureHistogram-skip-feature-tags dnn_extra --FeatureHistogram-process-group-name datacard_zz_res_reduced \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot  --workers 10


# law run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
#  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
#  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced \
#   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 2

# for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
# ./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
# done

# for CATEGORY in ZbbHtt_OC90_boosted_bb_boostedTau ZbbHtt_OC90_boosted_bb_HPSTau ZbbHtt_OC90_resolved_1b_HPSTau ZbbHtt_OC90_resolved_2b_HPSTau; do
# ./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v23 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
# done
# for CATEGORY in ZttHbb_OC90_boosted_bb_boostedTau ZttHbb_OC90_boosted_bb_HPSTau ZttHbb_OC90_resolved_1b_HPSTau ZttHbb_OC90_resolved_2b_HPSTau; do
# ./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v23 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZttHbb_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
# done

# FeatureHistogram should be run first as for some reason '--FeatureHistogram-dataset-names-after-skip NO_STR' does not work as it should

# --CreateDatacards-prune-bad-qcd-systs
law run CreateDatacardsResonantWrapper --version prod_250315_resDatacards_v1 --version-template prod_250315_resDatacards_v1/M__MASS__ --FeatureHistogramRebin-version prod_250315_nonResDatacards_v1 --FeatureHistogram-version prod_250315_nonResDatacards_v1 --config-name bul_${YEAR}_ZZ_v12  \
 --resonant-masses 200,210,220,230,240,250,260,270,280,300,320,350,360,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2200,2400,2500,2600,2800,3000,3500,4000,4500,5000 \
  --feature-names-template dnn_ZZbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn_res --FeatureHistogram-skip-feature-tags dnn_extra \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal,nonDefault --dataset-names-after-skip-template GluGluToXToZZTo2B2Tau_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_zz_res_reduced  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-drop-secondary-signals 20 --CreateDatacards-prune-shape-systs  --CreateDatacards-prune-bad-negligible-systs --CreateDatacards-hide-data True --CreateDatacards-do-qcd --CreateDatacards-propagate-syst-qcd False \
 --make-plots --FeaturePlot-skip-dataset-tags nonResOnly,resSignal,nonDefault --FeaturePlot-process-group-name datacard_zz_res_reduced \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data False --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --workers 10

# ZbbHtt

law run CreateDatacardsResonantWrapper --version prod_250117b_datacards_v23 --version-template prod_250117b_datacards_v23/M__MASS__ --FeatureHistogramRebin-version prod_250117b_datacards_v23 --FeatureHistogram-version prod_250117b_datacards_v23 --config-name bul_${YEAR}_ZbbHtt_v12  \
 --resonant-masses 500,600,700,800,1000,1200,1400,1600,1800,2000,2500,3000,3500,4000,4500,5000,5500,6000 \
  --feature-names-template dnn_ZHbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template ZprimeToZH_ZToBB_HToTauTau_M__MASS__,ZprimeToZH_ZToTauTau_HToBB_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_res_reduced  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-drop-secondary-signals 20 --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs --CreateDatacards-prune-bad-negligible-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --workers 5 \
 --make-plots --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name datacard_res_reduced \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data True --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --workers 20
# ZttHbb
law run CreateDatacardsResonantWrapper --version prod_250117b_datacards_v23 --version-template prod_250117b_datacards_v23/M__MASS__ --FeatureHistogramRebin-version prod_250117b_datacards_v23 --FeatureHistogram-version prod_250117b_datacards_v23 --config-name bul_${YEAR}_ZttHbb_v12  \
 --resonant-masses 500,600,700,800,1000,1200,1400,1600,1800,2000,2500,3000,3500,4000,4500,5000,5500,6000 \
  --feature-names-template dnn_ZHbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template ZprimeToZH_ZToTauTau_HToBB_M__MASS__,ZprimeToZH_ZToBB_HToTauTau_M__MASS__ --merge-bins-signal-template Zprime_Zh_Ztautauhbb_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_res_reduced  --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-drop-secondary-signals 20 --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs --CreateDatacards-prune-bad-negligible-systs --CreateDatacards-hide-data True --CreateDatacards-do-qcd --workers 5 \
 --make-plots --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name datacard_res_reduced \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data True --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --workers 10

# 2018 only
law run CreateDatacardsResonantWrapper --version prod_250117b_datacards_v10 --version-template prod_250117b_datacards_v10/M__MASS__ --FeatureHistogramRebin-version prod_250117_datacards_v4 --FeatureHistogram-version prod_250117_datacards_v4 --config-name bul_${YEAR}_ZZ_v12  \
 --resonant-masses 200,210,220,230,240,250,260,270,280,300,320,350,360,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2200,2400,2500,2600,2800,3000,3500,4000,4500,5000 \
  --feature-names-template dnn_ZZbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template GluGluToXToZZTo2B2Tau_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_zz_res_reduced  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --workers 10

# law run CreateDatacardsResonantWrapper --version prod_250117_datacards_v4 --version-template prod_250117_datacards_v5_test1/M__MASS__ --FeatureHistogram-version prod_250117_datacards_v4 --config-name bul_${YEAR}_ZZ_v12  \
#  --resonant-masses 1000,3000 \
#   --feature-names-template dnn_ZZbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn \
#   --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template GluGluToXToZZTo2B2Tau_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
#  --CreateDatacards-process-group-name datacard_zz_res_reduced  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
#  --CreateDatacards-merge-bins  --CreateDatacards-hide-data True --CreateDatacards-do-qcd --workers 3



# 
law run CreateDatacardsResonantWrapper --version prod_250117_datacards_v6 --version-template prod_250117_datacards_v6/M__MASS__ --FeatureHistogramRebin-version prod_250117b_datacards_v4 --FeatureHistogram-version prod_250117b_datacards_v4 --config-name bul_${YEAR}_ZZ_v12  \
 --resonant-masses 200,210,220,230,240,250,260,270,280,300,320,350,360,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2200,2400,2500,2600,2800,3000,3500,4000,4500,5000 \
  --feature-names-template dnn_ZZbbtt_500bv_M__MASS__  --FeatureHistogram-feature-tags NO_STR  --plot-additional-feature-names dnn_ZZbbtt_100b_M__MASS__ \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template GluGluToXToZZTo2B2Tau_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_zz_res_reduced  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins  --CreateDatacards-hide-data True --CreateDatacards-do-qcd \
 --make-plots --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name datacard_zz_res_reduced \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data True --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png  --print-status 3


