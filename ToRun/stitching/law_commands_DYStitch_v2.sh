### computing weights


law run DrellYanCounter --version prod_240728 --config-name ul_2017_ZZ_v12 --dataset-name dy_ptz4 --branch 1

law run MergeStitchSkimWrapper --config-name ul_2016_HIPM_ZZ_v12 --version prod_240731 --dataset-names dy_aux,dy_0j_aux,dy_1j_aux,dy_2j_aux,dy_ptz1_aux,dy_ptz2_aux,dy_ptz3_aux,dy_ptz4_aux,dy_ptz5_aux,dy_ptz6_aux \
    --StitchSkim-workflow htcondor --StitchSkim-tasks-per-job 3 --StitchSkim-htcondor-scheduler llrt3condor.in2p3.fr --StitchSkim-transfer-logs --StitchSkim-poll-interval 2 --StitchSkim-submission-threads 1 --StitchSkim-retries 1 \
    --StitchSkim-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3Queue=short,WNTag=el7,request_memory=0.7G' --StitchSkim-parallel-jobs 5 --workers 15 --print-status 1

law run StichWeights --config-name ul_2018_ZZ_v12 --version prod_240731 --inclusive-dataset-name dy_aux \
 --dataset-names dy_aux,dy_0j_aux,dy_1j_aux,dy_2j_aux,dy_ptz1_aux,dy_ptz2_aux,dy_ptz3_aux,dy_ptz4_aux,dy_ptz5_aux,dy_ptz6_aux --print-status 2


## plotting
# DY not stitched
# First remove the "DYstitchEasyWeight" from weights inside ul_2018_v12.py
law run FeaturePlot --version prod_240801_stitching_baseline --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt,LHE_NpNLO,LHE_HT \
 --workers 30  --MergeCategorizationStats-version prod_240305 --MergeCategorization-version prod_240725  \
 --dataset-names dy --PrePlot-preplot-modules-file preplot \
 --process-group-name dy_incl --save-png --category-name ZZ_elliptical_cut_90_resolved_2b --stack --log-y


# DY stitched
# Put back the "DYstitchEasyWeight" inside ul_2018_v12.py (the PrePlot has to be rerun!)
law run FeaturePlot --version prod_240321 --PrePlot-skip-merging --config-name ul_2018_ZZ_v12 \
 --feature-names LHE_Vpt \
 --workers 20  --MergeCategorizationStats-version prod_240305 --Categorization-version prod_240312  \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,dy \
 --process-group-name dy_split --save-root --save-png --category-name base \
 --region-name os_iso --stack --log-y


################################################################# BUL
YEAR=2018
law run MergeStitchSkimWrapper --config-name bul_${YEAR}_ZZ_v12 --version prod_250108 --dataset-names dy,dy_0j,dy_1j,dy_2j,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 \
    --StitchSkim-workflow htcondor --StitchSkim-tasks-per-job 10 --StitchSkim-htcondor-scheduler llrt3condor.in2p3.fr --StitchSkim-transfer-logs --StitchSkim-poll-interval 2 --StitchSkim-submission-threads 1 --StitchSkim-retries 0 --StitchSkim-avoid-vms False \
    --StitchSkim-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=0.7G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --StitchSkim-parallel-jobs 10 --workers 20 --print-status 1

law run StichWeights --config-name bul_${YEAR}_ZZ_v12 --version prod_250108 --inclusive-dataset-name dy \
 --dataset-names dy,dy_0j,dy_1j,dy_2j,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 --print-status 2

