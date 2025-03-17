# BoostedTaus third prod (systematics, hem veto, etc)
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

# pilots

law run PreprocessRDFWrapper --version prod_250211 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1  --workers 50 --PreprocessRDF-tasks-per-job 1

law run PreprocessRDFWrapper --version prod_250211 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 1 --workers 40

law run PreprocessRDF --version prod_250211_test3 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --dataset-name data_etau_c --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file  --branch 0

law run PrePlotWrapper --version prod_250211_fromPreproc  --PreprocessRDF-version prod_250211 --PrePlot-skip-categorization --config-name bul_2016_ZZ_v12 \
  --category-name ZZ_EC90_resolved_2b_HPSTau --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_os_iso,etau_HPSTaus_ss_iso,etau_HPSTaus_os_inviso,etau_HPSTaus_ss_inviso,tautau_HPSTaus_os_iso,tautau_HPSTaus_ss_iso,tautau_HPSTaus_os_inviso,tautau_HPSTaus_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 50 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll


law run MergePrePlotWrapper --version prod_250211_fromPreproc  --config-name bul_2016_ZZ_v12 \
 --skip-dataset-tags data,resSignal --category-names ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --PrePlot-store-systematics False --PrePlot-skip-categorization --workers 20


law run FeatureHistogramWrapper --version prod_250211_fromPreproc_v2 --MergePrePlot-version prod_250211_fromPreproc_v2 --MergePrePlot-skip-categorization --PrePlot-version prod_250211_fromPreproc --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12 \
 --category-names ZZ_EC90_resolved_2b_HPSTau --region-names etau_HPSTaus_os_iso,tautau_HPSTaus_os_iso \
 --FeatureHistogram-skip-dataset-tags resSignal --FeatureHistogram-feature-tags base --FeatureHistogram-process-group-name zz_full \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --FeatureHistogram-norm-use-precounter False --FeatureHistogram-store-systematics False   --workers 20


law run FeaturePlot --version prod_250211_fromPreproc_v2 --MergePrePlot-version prod_250211_fromPreproc_v2 --PrePlot-version prod_250211_fromPreproc --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12   \
 --category-name ZZ_EC90_resolved_2b_HPSTau --region-name tautau_HPSTaus_os_iso \
 --feature-tags base    --skip-dataset-tags resSignal \
 --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --FeatureHistogram-norm-use-precounter False \
 --store-systematics False --plot-systematics False \
  --process-group-name zz_full --stack --hide-data False --do-qcd \
  --FeaturePlot-save-png --FeaturePlot-log-y --histogram-minimum 0.1   --workers 5 



# testing no data

law run MergePrePlot --version prod_250211_fromPreproc  --config-name bul_2016_ZZ_v12 \
 --category-name ZZ_EC90_resolved_2b_HPSTau --region-name etau_os_iso \
 --PrePlot-store-systematics False --PrePlot-skip-categorization --dataset-name data_etau_b




# with categorization
law run MergeCategorizationWrapper --version prod_250211_fromPreproc   --config-name bul_2016_ZZ_v12 --PreprocessRDF-no-run --PreprocessRDF-version prod_250211 --PreprocessRDF-category-name base_selection \
 --category-names ZZ_EC90_resolved_2b_HPSTau --skip-dataset-tags resSignal \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 3  --Categorization-tasks-per-job 3 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --workers 50

law run PrePlotWrapper --version prod_250211  --MergeCategorization-version prod_250211_fromPreproc --config-name bul_2016_ZZ_v12 \
  --category-name ZZ_EC90_resolved_2b_HPSTau --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll


law run FeatureHistogramWrapper --version prod_250211  --PrePlot-version prod_250211 --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12 \
 --category-names ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resSignal --FeatureHistogram-feature-tags base --FeatureHistogram-process-group-name zz_full \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot False --FeatureHistogram-norm-use-precounter False --FeatureHistogram-store-systematics False   --workers 20

law run FeaturePlot --version prod_250211 --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12   \
 --category-name ZZ_EC90_resolved_2b_HPSTau --region-name tautau_os_iso \
 --feature-tags base    --skip-dataset-tags resSignal \
 --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --FeatureHistogram-norm-use-precounter False \
 --store-systematics False --plot-systematics False \
  --process-group-name zz_full --stack --hide-data False --do-qcd \
  --FeaturePlot-save-png --FeaturePlot-log-y --histogram-minimum 0.1   --workers 5 


law run FeaturePlotWrapper --version prod_250211_qcd_cr --FeatureHistogram-version prod_250211 --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12   \
 --category-names ZZ_EC90_resolved_2b_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --FeaturePlot-feature-tags base    --FeaturePlot-skip-dataset-tags resSignal \
 --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --FeatureHistogram-norm-use-precounter False \
 --FeaturePlot-store-systematics False --FeaturePlot-plot-systematics False \
  --FeaturePlot-process-group-name zz_full --FeaturePlot-stack --FeaturePlot-hide-data False --FeaturePlot-do-qcd False \
  --FeaturePlot-save-png --FeaturePlot-log-y --FeaturePlot-histogram-minimum 0.1   --workers 5 






############# new preprocess fixing tautau
law run PreprocessRDFWrapper --version prod_250212 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --skip-dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1 --PreprocessRDF-ignore-submission

law run PreprocessRDFWrapper --version prod_250212 --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-tasks-per-job 1 --workers 50 --PreprocessRDF-ignore-submission



law run MergeCategorizationWrapper --version prod_250212   --config-name bul_2016_ZZ_v12 --PreprocessRDF-no-run --PreprocessRDF-version prod_250212 --PreprocessRDF-category-name base_selection \
 --category-names ZZ_EC90_resolved_2b_HPSTau --skip-dataset-tags resSignal \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 3  --Categorization-tasks-per-job 4 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --workers 50

law run PrePlotWrapper --version prod_250212  --MergeCategorization-version prod_250212 --config-name bul_2016_ZZ_v12 \
  --category-name ZZ_EC90_resolved_2b_HPSTau --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 3 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll



law run FeaturePlot --version prod_250212 --PrePlot-no-run --PrePlot-store-systematics False --MergeCategorizationStats-version prod_241024 --config-name bul_2016_ZZ_v12   \
 --category-name ZZ_EC90_resolved_2b_HPSTau --region-name etau_os_iso \
 --feature-tags base    --skip-dataset-tags resSignal \
 --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot False --FeatureHistogram-norm-use-precounter False \
 --store-systematics False --plot-systematics False \
  --process-group-name zz_full --stack --hide-data False --do-qcd \
  --FeaturePlot-save-png --FeaturePlot-log-y --histogram-minimum 0.1   --workers 5 





################################" testing preprocess signal only"

law run PreprocessRDFWrapper --version prod_250213 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0   --PreprocessRDF-tasks-per-job 5 --workers 40


law run MergeCategorizationWrapper --version prod_250213_noSysts_noDNN   --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --PreprocessRDF-version prod_250213 --PreprocessRDF-category-name base_selection \
 --category-names ZZ_EC90_resolved_2b_HPSTau ---dataset-names zz_sl_signal \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 3  --Categorization-tasks-per-job 3 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --workers 50


################"" with systs
law run PreprocessRDFWrapper --version prod_250214b --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --dataset-names zz_sl_signal,zz_sl_background,zz_bbtt --workers 20 --split-syst-group 12 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1  --workers 50 --PreprocessRDF-tasks-per-job 1

law run MergeCategorizationWrapper --version prod_250214b_noSysts_noDNN   --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --PreprocessRDF-version prod_250214b --PreprocessRDF-category-name base_selection \
 --category-names ZZ_EC90_resolved_2b_HPSTau --dataset-names zz_sl_signal  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 3  --Categorization-tasks-per-job 4 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --workers 50

law run PrePlotWrapper --version prod_250214b_noSysts_noDNN  --MergeCategorization-version prod_250214b_noSysts_noDNN --config-name bul_2018_ZZ_v12 \
  --dataset-names zz_sl_signal  --category-name ZZ_EC90_resolved_2b_HPSTau --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics True \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 3 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll




###################
law run PreprocessRDFWrapper --version prod_250214b --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --dataset-names zz_sl_signal,zz_sl_background,zz_bbtt,dy_2j --workers 20 --split-syst-group 6 \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1