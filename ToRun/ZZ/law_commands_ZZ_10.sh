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

# no systs

law run PreprocessRDFWrapper --version prod_250225 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 100 --workers 70 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250225 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --skip-dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1






# law run FeaturePlotWrapper --version prod_250225_fromPreproc --FeatureHistogram-version prod_250225_fromPreproc --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --category-names base_selection --region-names etau_HPSTaus_os_iso,mutau_HPSTaus_os_iso,tautau_HPSTaus_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
#  --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal --FeaturePlot-process-group-name zz \
#  --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
#    --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 



# etau_HPSTaus_os_iso,etau_HPSTaus_ss_iso,etau_HPSTaus_os_inviso,etau_HPSTaus_ss_inviso,mutau_HPSTaus_os_iso,mutau_HPSTaus_ss_iso,mutau_HPSTaus_os_inviso,mutau_HPSTaus_ss_inviso,tautau_HPSTaus_os_iso,tautau_HPSTaus_ss_iso,tautau_HPSTaus_os_inviso,tautau_HPSTaus_ss_inviso
law run MergePrePlotWrapper --version prod_250225_fromPreproc  --PreprocessRDF-version prod_250225 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-skip-feature-names fatjet_msoftdrop --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 40 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll

law run FeaturePlotWrapper --version prod_250225_fromPreproc_crossTrigger --FeatureHistogram-version prod_250225_fromPreproc_crossTrigger --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 


law run FeaturePlotWrapper --version prod_250225_fromPreproc_crossTrigger --FeatureHistogram-version prod_250225_fromPreproc_crossTrigger --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 




##### cross trigger debug

law run MergeCategorizationWrapper --version prod_250225 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
--MergeCategorization-from-DNN-inference False \
  --category-names crossTrigger_debug  \
 --Categorization-feature-modules-file modulesrdf_empty --Categorization-keep-and-drop-file keep_and_drop_file_test \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 3 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 30 --Categorization-no-poll



law run MergePrePlotWrapper --version prod_250225_noWeights  --MergeCategorization-version prod_250225 --config-name bul_2018_ZZ_v12 \
  --category-name crossTrigger_debug  \
  --skip-dataset-tags resSignal  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base,weights --PrePlot-skip-feature-names fatjet_msoftdrop --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll
law run MergePrePlotWrapper --version prod_250225_noWeights_cat  --MergeCategorization-version prod_250225 --config-name bul_2018_ZZ_v12 \
  --category-name crossTrigger_debug  \
  --skip-dataset-tags resSignal,met  --skip-dataset-names wz_lnubb --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags cat  --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70


law run FeaturePlotWrapper --version prod_250225_noWeights --FeatureHistogram-version prod_250225_noWeights --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_noWeights --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names crossTrigger_debug --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,weights,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,met --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop,totalSFWeight 


## no weights




##################### new prod with dR trig match < 0.2
law run PreprocessRDFWrapper --version prod_250225_dR02 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 80 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250225_dR02 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --skip-dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1
law run PreprocessRDFWrapper --version prod_250225_dR02 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 5


law run MergePrePlotWrapper --version prod_250225_dR02_fromPreproc_v2  --PreprocessRDF-version prod_250225_dR02 --MergePrePlot-skip-categorization --PrePlot-skip-categorization --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal,met  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 40 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70




law run FeaturePlotWrapper --version prod_250225_dR02_fromPreproc_crossTrigger_v2 --FeatureHistogram-version prod_250225_dR02_fromPreproc_crossTrigger_v2 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02_fromPreproc_v2  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,met --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 

law run FeaturePlotWrapper --version prod_250225_dR02_fromPreproc_crossTrigger --FeatureHistogram-version prod_250225_dR02_fromPreproc_crossTrigger --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,met --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop 


law run MergeCategorizationWrapper --version prod_250225_dR02 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --skip-dataset-tags resSignal,met \
  --category-names crossTrigger_debug  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_all \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 3 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70 --Categorization-no-poll

# run without HEM filter in data & MC
law run MergePrePlotWrapper --version prod_250225_dR02  --MergeCategorization-version prod_250225_dR02 --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name crossTrigger_debug  \
  --skip-dataset-tags resSignal,met  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base,weights,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 40 --PrePlot-poll-interval 3  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50


law run FeaturePlotWrapper --version prod_250225_dR02_noWeights --FeatureHistogram-version prod_250225_dR02_noWeights --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names crossTrigger_debug --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,weights,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,met --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 --FeaturePlot-skip-feature-names fatjet_msoftdrop,totalSFWeight 



## res1b
law run MergeCategorizationWrapper --version prod_250225_dR02 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --skip-dataset-tags data,resSignal,met \
  --category-names ZZ_EC90_resolved_1b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_all \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 4 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70 --Categorization-no-poll

law run MergeCategorizationWrapper --version prod_250225_dR02 --PreprocessRDF-version prod_250225_dR02_privateSkims --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --dataset-tags data --skip-dataset-tags met \
  --category-names ZZ_EC90_resolved_1b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_all \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 4 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70 --Categorization-no-poll


law run MergePrePlotWrapper --version prod_250225_dR02  --MergeCategorization-version prod_250225_dR02 --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name ZZ_EC90_resolved_1b_HPSTau  \
  --skip-dataset-tags resSignal,met  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base,weights,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 5 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50


law run FeaturePlotWrapper --version prod_250225_dR02 --FeatureHistogram-version prod_250225_dR02 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_resolved_1b_HPSTau --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,weights,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,met --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10


########### private data skims
law run PreprocessRDFWrapper --version prod_250225_dR02_privateSkims --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --skip-dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 10 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=short,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 3



##################### boostedTau CR
law run MergeCategorizationWrapper --version prod_250225_dR02 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --MergeCategorization-from-DNN-inference False --skip-dataset-tags resSignal,hpsData \
  --category-names boostedTau_CR  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 5  --Categorization-retries 0 --Categorization-tasks-per-job 4 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70 --Categorization-no-poll


law run MergePrePlotWrapper --version prod_250225_dR02   --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name boostedTau_CR \
  --skip-dataset-tags resSignal,hpsData  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 1 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 80


law run FeaturePlotWrapper --version prod_250225_dR02_v3 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10
law run FeaturePlotWrapper --version prod_250225_dR02_v3 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False --FeaturePlot-rebin-factor 2 \
   --workers 10
law run FeaturePlotWrapper --version prod_250225_dR02_decompProcesses_v2  --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz_full \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10


## QCD CR
law run FeaturePlotWrapper --version prod_250225_dR02_QCD_CR_v3 --FeatureHistogram-version prod_250225_dR02_v3 --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd False --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10

### CR with DNN

LAW__luigi_worker__force_multiprocessing=true law run CategorizationDNNBatchWrapper --version prod_250225_dR02_DNN --skip-dataset-tags resSignal,hpsData --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-version prod_250225_dR02 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
  --CategorizationDNNBatchRunner-category-names boostedTau_CR --CategorizationDNNBatchRunner-systematic-names central \
   --CategorizationDNNBatchRunner-workflow htcondor --CategorizationDNNBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --CategorizationDNNBatchRunner-poll-interval 5 --CategorizationDNNBatchRunner-retries 0 \
 --CategorizationDNNBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.5G,request_disk=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100

law run MergeCategorizationWrapper --version prod_250225_dR02_DNN  --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names boostedTau_CR  \
 --MergeCategorization-from-DNN-inference True  \
 --skip-dataset-tags resSignal,hpsData --systematic-names central

law run MergePrePlotWrapper --version prod_250225_dR02_DNN   --PreprocessRDF-no-run --Categorization-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name boostedTau_CR  \
  --skip-dataset-tags resSignal,hpsData  --PrePlot-store-systematics False \
  --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags cat,dnn_limited --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 3 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 80

law run FeaturePlotWrapper --version prod_250225_dR02_DNN --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_dR02_DNN --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names boostedTau_CR --region-names etau_os_iso,mutau_os_iso,tautau_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags cat,dnn_limited --FeaturePlot-skip-dataset-tags resOnly,resSignal,hpsData --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd True --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10








  

################ fixed filter bits
law run PreprocessRDFWrapper --version prod_250225_fixFilterBits --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data,resSignal,noDefault --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1  --workers 100 --PreprocessRDF-tasks-per-job 1 --PreprocessRDF-no-poll


law run PreprocessRDFWrapper --version prod_250225_fixFilterBits --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-tags data --skip-dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 50 --PreprocessRDF-tasks-per-job 1



law run MergePrePlotWrapper --version prod_250225_fixFilterBits_fromPreproc  --PreprocessRDF-version prod_250225_fixFilterBits --MergePrePlot-skip-categorization --PrePlot-skip-categorization --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --category-name base_selection --PreprocessRDF-category-name base_selection  \
  --skip-dataset-tags resSignal,met,nonDefault  --PrePlot-store-systematics False \
  --region-names etau_HPSTaus_crossTrigger_os_iso,etau_HPSTaus_crossTrigger_ss_iso,etau_HPSTaus_crossTrigger_os_inviso,etau_HPSTaus_crossTrigger_ss_inviso,mutau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_ss_iso,mutau_HPSTaus_crossTrigger_os_inviso,mutau_HPSTaus_crossTrigger_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
    --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 40 --PrePlot-poll-interval 1  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 70


law run FeaturePlotWrapper --version prod_250225_fixFilterBits_fromPreproc --FeatureHistogram-version prod_250225_fixFilterBits_fromPreproc --FeatureHistogram-from-merge-preplot --MergePrePlot-version prod_250225_fixFilterBits_fromPreproc  --MergePrePlot-skip-categorization --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names base_selection --region-names etau_HPSTaus_crossTrigger_os_iso,mutau_HPSTaus_crossTrigger_os_iso --FeaturePlot-store-systematics False --FeatureHistogram-store-systematics False --FeaturePlot-plot-systematics False --FeatureHistogram-propagate-syst-qcd False \
 --FeaturePlot-feature-tags base --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal,met,nonDefault --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png  --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 10 

####################### QCD MC
law run PreprocessRDF --version prod_250225_fixFilterBits --category-name base_selection_boostedTausOnly --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-name qcd_ht1500_test --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light  \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-no-poll --workers 100 --PreprocessRDF-tasks-per-job 1

