
# fixing bugs
law run CategorizationWrapper --version prod_241213c_DNN25 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat --category-names ZZ_EC90_boosted_bb_boostedTau \
  --systematic-names central\
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 5 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=100,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 1 --Categorization-tasks-per-job 2 --Categorization-no-poll 

law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data \
 --systematic-names central \
  --workers 10

law run PrePlotWrapper --version prod_241213c_DNN25  --MergeCategorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
  --dataset-names tt_sl,tt_dl,tt_fh,tth_tautau,ttz_qq \
  --category-names ZZ_EC90_boosted_bb_boostedTau --PrePlot-systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot --workers 20

law run FeatureHistogramWrapper --version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat --FeatureHistogram-skip-feature-tags blind --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-process-group-name zz_res_limitedMass \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd  --workers 10

law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly --FeaturePlot-process-group-name zz_res_limitedMass \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
  --FeaturePlot-rebin-factor 2 --FeaturePlot-hide-signals --workers 5
law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind  --FeaturePlot-process-group-name zz_res_limitedMass \
 --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
  --FeaturePlot-rebin-factor 2 --FeaturePlot-hide-signals --workers 5
  
# blinded features
law run FeatureHistogramWrapper --version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags dnn,blind --FeatureHistogram-process-group-name zz_res \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --workers 10


law run Categorization --version prod_241213c_test5 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_2018_ZZ_v12 \
  --dataset-name tt_sl --feature-modules-file modulesrdf_cat --category-name ZZ_EC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution 

law run DNNInference --version prod_241213c_DNN25  --Categorization-version prod_241213c


MASS=3000
law run FeaturePlotWrapper --version prod_241213c_DNN25_test1 --FeatureHistogram-version prod_241213c_DNN25_datacards_v2 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso \
 --FeaturePlot-feature-tags dnn_res_M$MASS --FeaturePlot-process-group-name datacard_zz_res_reduced_M$MASS \
 --FeaturePlot-do-qcd --FeaturePlot-merge-bins \
  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-log-y --FeaturePlot-hide-data True --FeaturePlot-equal-bin-width \
   --workers 1 "${@:2}"


####
law run MergePrePlot --version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
 --dataset-name tt_sl --category-name ZZ_EC90_resolved_1b_HPSTau --region-name tautau_os_iso --print-status 1
law run MergePrePlotWrapper --version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --skip-dataset-names tt_fh --category-names ZZ_EC90_resolved_1b_HPSTau --region-names tautau_os_iso --print-status 1

law run FeatureHistogramWrapper --version prod_241213c_test --MergePrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot 


LINE_PROFILE=1 law run FeatureHistogram --version prod_241213c_test2 --PrePlot-version prod_250117  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name ZZ_EC90_boosted_bb_boostedTau --region-name tautau_os_iso --dataset-names tt_sl,tt_dl,tt_fh,dy_2j \
 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced \
  --FeatureHistogram-hide-data True 





law run PrePlot --version prod_241213c_test3  --MergeCategorization-version prod_241213c_DNN25 --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_boosted_bb_boostedTau --systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot




law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-names tt_sl --print-status 0



law run DNNInference --version prod_241501_test1 --config-name bul_2018_ZZ_v12 \
 --dataset-name tt_sl --category-name  ZZ_EC90_boosted_bb_boostedTau \
 --branch 1 --print-status 1,5


law run PrePlotWrapper --version prod_250117  --MergeCategorization-version prod_241213c_DNN25  --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10 --PrePlot-submission-threads 1 --PrePlot-request-cpus 8 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"'  --workers 70


YEAR=2016
law run PrePlot --version prod_250117b_test1  --MergeCategorization-version prod_240121  --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-name dy_ptz6 --category-name ZZ_EC90_boosted_bb_boostedTau --region-names tautau_os_iso \
  --feature-names fatjet_pt_high --PrePlot-preplot-modules-file preplot --workers 10



law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_240121  --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-4,T3queue=long,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200




 law run PreprocessRDF --version prod_241213c_test1 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-name data_met_d --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 1
 law run PreprocessRDF --version prod_250218_test --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-name ggZH_HToBB_ZToLL --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0




law run FeatureHistogramWrapper --version prod_250117b_full --PrePlot-version prod_250117b  --MergeCategorizationStats-version prod_241024 --config-name bul_2016_HIPM_ZttHbb_v12 \
 --category-names ZttHbb_OC90_resolved_2b_HPSTau --region-names tautau_os_iso \
 --FeatureHistogram-feature-names dnn_ZHbbtt_500bv_M3000,dnn_ZHbbtt_kl_1_3000 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-process-group-name full \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd False



law run FeaturePlot --version prod_250117b_datacards_v18_test1 --FeatureHistogramRebin-version prod_250117_datacards_v11 --FeatureHistogram-version prod_250117_datacards_v4 --config-name bul_${YEAR}_ZZ_v12 \
 --feature-names dnn_ZZbbtt_500bv_M800 --category-name ZZ_EC90_boosted_bb_HPSTau --region-name tautau_os_iso \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip GluGluToXToZZTo2B2Tau_M800 --process-group-name datacard_zz_res_reduced \
 --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name datacard_zz_res_reduced  --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data True --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png 




############### debugging etau 2016
law run PreprocessRDF --version prod_250218_test1 --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0









## testing pdf weights

law run PrePlot --version prod_250217_test1  --MergeCategorization-version prod_250217 --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_boosted_bb_boostedTau  \
  --dataset-name GluGluToXToZZTo2B2Tau_M4000  \
  --PrePlot-region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
  --PrePlot-feature-tags base,weights --PrePlot-preplot-modules-file preplot

law run PrePlotWrapper --version prod_250117_pdfWeights_test  --MergeCategorization-version prod_250217  --config-name bul_2018_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau  \
  --region-names tautau_os_iso \
  --PrePlot-feature-names lep1_pt_high --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-4,T3queue=long,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200