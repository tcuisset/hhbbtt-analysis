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


law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --workers 100

law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --split-syst-group 6 --workers 100

# remaining
# central only
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 100
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --split-syst-group 11 --workers 100


law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-tags met --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --workers 20

law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-tags hpsData --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 1 --workers 40

# testing

law run PreprocessRDF --version prod_241213c --category-name base_selection --config-name bul_2018_ZZ_v12 \
 --dataset-name data_tau_a --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 334

########### ZH
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 20

law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2018_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 1 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.5G,priority=1,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 50

########### 2017

# central
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2017_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,priority=-50,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-no-poll #--workers 100
# systematics
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2017_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf --skip-dataset-tags data \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 6 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,priority=50,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 10 --dataset-names zz_sl_background --PreprocessRDF-ignore-submission #--PreprocessRDF-no-poll #--workers 100
## ZH
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2017_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 10 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.5G,priority=-50,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 30

######### 2016
# central
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,priority=-50,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-no-poll #--workers 100
# systs
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf --skip-dataset-tags data \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 5 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,priority=-60,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 30 --PreprocessRDF-no-poll 
# ZH
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 7 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 40

######### 2016 HIPM
law run PreprocessRDF --version prod_241213c --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --dataset-name data_tau_a --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 0
law run PreprocessRDF --version prod_241213c --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --dataset-name tt_sl --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --branch 1
# central
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,priority=-50,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 20 --PreprocessRDF-no-poll #--workers 100
# systs
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_HIPM_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf --skip-dataset-tags data \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 10 --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,priority=-60,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 30 --PreprocessRDF-no-poll 
# ZH
law run PreprocessRDFWrapper --version prod_241213c --category-name base_selection --config-name bul_2016_HIPM_ZbbHtt_v12 \
 --dataset-tags zh --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --split-syst-group 10 --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 10 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4.G,priority=100,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --workers 40


###############################################################################################################################################
# PRECOUNTER
###############################################################################################################################################
law run MergeCategorizationStatsWrapper --version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data \
 --workers 100 --PreCounter-weights-file weights --systematic-names central,pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs --PreCounter-poll-interval 3 --PreCounter-submission-threads 1 --PreCounter-avoid-vms False \
 --PreCounter-tasks-per-job 5 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=0.8G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --print-status 0
law run MergeCategorizationStatsWrapper --version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --dataset-tags zh \
 --workers 50 --PreCounter-weights-file weights --systematic-names central,pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs --PreCounter-poll-interval 3 --PreCounter-submission-threads 1 --PreCounter-avoid-vms False \
 --PreCounter-tasks-per-job 10 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=0.8G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --print-status 0



###############################################################################################################################################
# CATEGORIZATION
###############################################################################################################################################

##################################### CATEGORIZATION for DNN training
law run Categorization --version prod_241213c --PreprocessRDF-version prod_241213c --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --config-name bul_2018_ZZ_v12 \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000 --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-name ZZ_elliptical_cut_90_sr \
  --version prod_241213c_test1 --print-status 0

# status
# 2018 : done incl tth_hbb, cat for tth_bb (ZZ done, ZH done)
# 2017 : ZZ:done, Zbb:done, Ztt:done
# 2016 : ZZ:done, Zbb:DY done, Ztt:DY done??
# 2016HIPM : ZZ:done  preprocess ZH done, ZbbHtt cat done, ZttHbbt:running

YEAR=2018
law run CategorizationWrapper --version prod_241213c_DNNtraining2 --PreprocessRDF-version prod_241213c --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_sr \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 3 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0  --workers 100 --print-status 0

law run CategorizationWrapper --version prod_241213c_DNNtraining2 --PreprocessRDF-version prod_241213c --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZbbHtt_OC90_sr \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 3 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --workers 100 --print-status 0
law run CategorizationWrapper --version prod_241213c_DNNtraining2 --PreprocessRDF-version prod_241213c --PreprocessRDF-category-name base_selection  --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZttHbb_OC90_sr \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 3 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --workers 100 --print-status 0

##################################### CATEGORIZATION with new 2025 DNN 
# pilot
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-names tt_sl --Categorization-feature-modules-file modulesrdf_cat --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution
# optimal auto-tasks-per-job : 17 (1 preproc branch=2jobs), 33 (1prepoc branch=1job)

# ZZ
--workers 50 
YEAR=2018
# ,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat --category-names ZZ_EC90_boosted_bb_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 15 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=7G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --auto-tasks-per-job 15 --parallel-jobs 50 --workers 100
# data : branch presence that changes causes issues with rdataframe hence special keep-and-drop
law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-tags data --Categorization-keep-and-drop-file keep_and_drop_file_cat_data --Categorization-feature-modules-file modulesrdf_cat --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 15 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-no-poll 
# ZbbHtt
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 10 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=5,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --auto-tasks-per-job 15 --Categorization-no-poll 
law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-tags data --Categorization-keep-and-drop-file keep_and_drop_file_cat_data --Categorization-feature-modules-file modulesrdf_cat --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 1 --auto-tasks-per-job 15 --workers 30 --Categorization-no-poll 
# ZttHbb
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241213c_DNN25 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 5 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=0,T3queue=long,WNTag=el9,request_memory=6G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 1  --auto-tasks-per-job 15 --workers 10 --Categorization-no-poll 
law run CategorizationWrapper --version prod_241213c_DNN25 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --dataset-tags data --Categorization-keep-and-drop-file keep_and_drop_file_cat_data --Categorization-feature-modules-file modulesrdf_cat --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 5 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,priority=10,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 1 --workers 50 --Categorization-no-poll 

####### Categorization 2016 light
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_240121 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=7G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --auto-tasks-per-job 15 --Categorization-parallel-jobs 20 --workers 40
# data : branch presence that changes causes issues with rdataframe hence special keep-and-drop
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_240121 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-tags data  --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 15 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=short,WNTag=el9,request_memory=6G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-no-poll 

cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_2016_HIPM_ZZ_v12/data_*.txt /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/tmp/bul_2016_HIPM_ZbbHtt_v12/  
# ZbbHtt (2017&2016 are using light categorization)
# 2018 has special 
for file in /grid_mnt/data__data.polcms/cms/cuisset/cmt/Categorization/bul_2018_ZbbHtt_v12/*/cat_ZbbHtt_*/prod_241501; do mv -nT $file $(dirname $file)/prod_241501_heavyCategorization; done

for file in /grid_mnt/data__data.polcms/cms/cuisset/cmt/MergeCategorization/bul_2018_ZbbHtt_v12/*/cat_ZbbHtt_*/prod_241501; do mv -nT $file $(dirname $file)/prod_241501_heavyCategorization; done


LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 10 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=6G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --auto-tasks-per-job 17 --workers 80
law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-tags data --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 3 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --auto-tasks-per-job 15 --workers 30 --Categorization-no-poll 
# ZttHbb
LAW__luigi_worker__force_multiprocessing=true law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-poll-interval 10 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-20,T3queue=long,WNTag=el9,request_memory=6G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0  --auto-tasks-per-job 17 --Categorization-parallel-jobs 30 --workers 50
law run CategorizationWrapper --version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --dataset-tags data --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 5 --Categorization-submission-threads 1 --Categorization-avoid-vms False \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,priority=-1,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --workers 50 --Categorization-no-poll 

# --ignore-submission
################# DNNInference
LAW__luigi_worker__force_multiprocessing=true 

# old prod
law run DNNInferenceBatchWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data --DNNInferenceBatchRunner-category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --DNNInferenceBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --DNNInferenceBatchRunner-transfer-logs --DNNInferenceBatchRunner-poll-interval 7 --DNNInferenceBatchRunner-submission-threads 1 --DNNInferenceBatchRunner-retries 0 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100

# new prod
law run DNNInferenceBatchWrapper --version prod_241501 --Categorization-version prod_241501 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data --DNNInferenceBatchRunner-category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --DNNInferenceBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --DNNInferenceBatchRunner-poll-interval 7 --DNNInferenceBatchRunner-retries 0 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100
law run DNNInferenceBatchWrapper --version prod_241501 --Categorization-version prod_241501 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data --DNNInferenceBatchRunner-category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --DNNInferenceBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr  --DNNInferenceBatchRunner-poll-interval 7 --DNNInferenceBatchRunner-retries 0 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 100

# for print-status
law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau  --MergeCategorization-from-DNN-inference True \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
 --print-status 2
# perf measurement
python3 -m cProfile -o DNNInferenceBatchWrapper.prof $(which law) run DNNInferenceBatchWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_2018_ZZ_v12 \
  --skip-dataset-tags data --DNNInferenceBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --DNNInferenceBatchRunner-systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --DNNInferenceBatchRunner-workflow htcondor

#### data
law run DNNInferenceBatchWrapper --version prod_241501 --Categorization-version prod_241501 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-tags data --DNNInferenceBatchRunner-category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --DNNInferenceBatchRunner-transfer-logs --DNNInferenceBatchRunner-poll-interval 10 --DNNInferenceBatchRunner-submission-threads 1 --DNNInferenceBatchRunner-retries 1 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20  --print-status 0
law run DNNInferenceBatchWrapper --version prod_241501 --Categorization-version prod_241501 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-tags data --DNNInferenceBatchRunner-category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr  --DNNInferenceBatchRunner-poll-interval 3 --DNNInferenceBatchRunner-retries 0 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 30 --DNNInferenceBatchRunner-ignore-submission
law run DNNInferenceBatchWrapper --version prod_241501 --Categorization-version prod_241501 --Categorization-no-run --PreprocessRDF-no-run --config-name bul_${YEAR}_ZttHbb_v12 \
  --dataset-tags data --DNNInferenceBatchRunner-category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau  \
  --DNNInferenceBatchRunner-workflow htcondor --DNNInferenceBatchRunner-htcondor-scheduler llrt3condor.in2p3.fr --DNNInferenceBatchRunner-transfer-logs --DNNInferenceBatchRunner-poll-interval 10 --DNNInferenceBatchRunner-submission-threads 1 --DNNInferenceBatchRunner-retries 1 \
 --DNNInferenceBatchRunner-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20

############ MergeCategorization

--skip-dataset-tags data
# --Categorization-feature-modules-file modulesrdf_cat --PreprocessRDF-category-name base_selection \
# ZbbHtt_OC90_boosted_bb_boostedTau
# ,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution
law run MergeCategorizationWrapper --version prod_241213c_DNN25_test2 --PreprocessRDF-version prod_241213c --PreprocessRDF-no-run --PreprocessRDF-category-name base_selection  --config-name bul_2018_ZZ_v12 \
 --dataset-names  dy_ptz5 \
 --category-names ZZ_EC90_boosted_bb_boostedTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --systematic-names central,jec_1 \
 --workers 10 --print-status 1


law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --DNNInference-workflow htcondor --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs --DNNInference-poll-interval 3 --DNNInference-submission-threads 1 \
 --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --JoinDNNInference-workflow htcondor --JoinDNNInference-htcondor-scheduler llrt3condor.in2p3.fr --JoinDNNInference-transfer-logs --JoinDNNInference-poll-interval 3 --JoinDNNInference-submission-threads 1 \
 --JoinDNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=3G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --workers 10 --print-status 1


law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_${YEAR}_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5

# light 2016 categorization
law run MergeCategorizationWrapper --version prod_240121 --Categorization-version prod_240121  --config-name bul_${YEAR}_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5



law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25 --PreprocessRDF-version  prod_241213c --PreprocessRDF-category-name base_selection --config-name bul_2018_ZbbHtt_v12 --PreprocessRDF-no-run  \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5
# light
law run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-version  prod_241213c --PreprocessRDF-category-name base_selection --config-name bul_${YEAR}_ZbbHtt_v12 --PreprocessRDF-no-run  \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 5
law run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-version  prod_241213c --PreprocessRDF-category-name base_selection --config-name bul_${YEAR}_ZttHbb_v12 --PreprocessRDF-no-run  \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 8


for CATEGORY in ZbbHtt_OC90_boosted_bb_boostedTau ZbbHtt_OC90_boosted_bb_HPSTau ZbbHtt_OC90_resolved_1b_HPSTau ZbbHtt_OC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-version  prod_241213c --PreprocessRDF-category-name base_selection --config-name bul_${YEAR}_ZbbHtt_v12 --PreprocessRDF-no-run  \
 --category-names $CATEGORY  \
 --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --skip-dataset-tags data \
 --MergeCategorization-from-DNN-inference True --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --workers 8
done


# data
law run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_${YEAR}_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --dataset-tags data \
  --workers 3
# --Categorization-no-run
law run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --config-name bul_${YEAR}_ZbbHtt_v12 --PreprocessRDF-no-run  \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --dataset-tags data --workers 8
law run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c  --config-name bul_${YEAR}_ZttHbb_v12 --PreprocessRDF-no-run \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --dataset-tags data \
  --workers 3




python3 -m cProfile -o MergeCat.prof $(which law) run MergeCategorizationWrapper --version prod_241213c_DNN25 --Categorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 --PreprocessRDF-no-run --Categorization-no-run \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat \
 --skip-dataset-tags data \
 --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution

# baseline signal
law run MergeCategorizationWrapper --version prod_241501 --Categorization-version prod_241501 --PreprocessRDF-category-name base_selection --PreprocessRDF-version prod_241213c --config-name bul_${YEAR}_ZbbHtt_v12 --PreprocessRDF-no-run  \
 --category-names baseline --dataset-names ZprimeToZH_ZToBB_HToTauTau_M500,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M5000  \
 --MergeCategorization-from-DNN-inference True --Categorization-feature-modules-file modulesrdf_cat_light --Categorization-keep-and-drop-file keep_and_drop_file_light \
 --workers 15


##################################### ##################################### ##################################### ##################################### ##################################### ##################################### 
############################## PLOTTING  2025 DNN ##################################### ##################################### ##################################### ##################################### ##################################### ##################################### 
##################################### ##################################### ##################################### ##################################### ##################################### ##################################### 
# non-flat ntuples : 18,17 ZZ
# flat ntuples 17,16 ZH,   16ZZ

# 16 ZZ : need to skip fatjet_msoftdrop feature : --PrePlot-skip-feature-names fatjet_msoftdrop

##########  preplot
law run PrePlot --version prod_241213c_test2  --MergeCategorization-version prod_241213c_DNN25 --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_boosted_bb_boostedTau --systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot

# --PrePlot-systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution does not do anything
# prod_250117 is bugged for 2017 & 2016 (weights issues with btag). prod_250117b is the fix.
for file in 
law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_240121  --config-name bul_${YEAR}_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau  \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10  --PrePlot-retries 0 --PrePlot-avoid-vms False \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-4,T3queue=long,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200

# ,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau

law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_241213c_DNN25  --config-name bul_${YEAR}_ZZ_v12 \
  --dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10 --PrePlot-submission-threads 1 --PrePlot-request-cpus 8 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=15G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"'  --workers 70


# ZH
law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_241501  --config-name bul_${YEAR}_ZbbHtt_v12 \
  --skip-dataset-tags data \
  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,T3queue=long,WNTag=el9,request_memory=12G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 40
law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_241501  --config-name bul_${YEAR}_ZbbHtt_v12 \
  --dataset-tags data \
  --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot
#  \
#  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 5 --PrePlot-retries 0 \
# --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=long,WNTag=el9,request_memory=6G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 40

law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_241501  --config-name bul_${YEAR}_ZttHbb_v12 \
  --skip-dataset-tags data \
  --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-5,T3queue=long,WNTag=el9,request_memory=12G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 40

law run PrePlotWrapper --version prod_250117b  --MergeCategorization-version prod_241501  --config-name bul_${YEAR}_ZttHbb_v12 \
  --dataset-tags data \
  --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 5 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=short,WNTag=el9,request_memory=4G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 40

## mergepreplot
# ZZ_EC90_resolved_2b_HPSTau
law run MergePrePlotWrapper --version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso --workers 3

law run MergePrePlotWrapper --version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --skip-dataset-names tt_fh --category-names ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --workers 5 

##################################### ##################################### ############# FeatureHistogram / FeaturePlot ##################################### ##################################### ##################################### ##################################### ##################################### ##################################### 
# unblinded features
# 
law run FeatureHistogramWrapper --version prod_250117 --PrePlot-version prod_250117  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat --FeatureHistogram-skip-feature-tags blind --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-process-group-name zz_res \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 5
law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-dataset-names-after-skip GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --FeaturePlot-process-group-name zz_res \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind  --FeaturePlot-process-group-name zz_res_limitedMass \
 --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5

# blinded features
law run FeatureHistogramWrapper --version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags dnn,blind --FeatureHistogram-process-group-name zz_res \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --workers 10
# QCD CR
# law run FeatureHistogramWrapper --version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau --region-names etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
#  --FeatureHistogram-feature-tags base,cat,dnn --FeatureHistogram-process-group-name zz_res \
#   --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd False --workers 25
# merge bins. For merge-bins we need to run one featureHistogram per resonant mass point as we need only one signal


# rebinning histograms
law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly --FeaturePlot-process-group-name zz_res_limitedMass \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --FeaturePlot-rebin-factor 2 --workers 5





function featurePlotZZ {
    CATEGORY=$1
    REGION_NAME=$2
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241213c_DNN25_noSignal --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name ${CATEGORY}   --feature-tags base,cat --skip-feature-tags blind   \
  --process-group-name zz_res_limitedMass --stack --hide-data False --do-qcd --region-name ${REGION_NAME} \
  --save-png --normalize-signals --workers 3  "${@:3}" 
#   law run FeaturePlotSyst --version prod_241213c --FeatureHistogram-version prod_241213c --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
#   --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
#   --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
}
#featurePlotTest etau_os_iso_HPSTaus
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for region in etau_os_iso mutau_os_iso tautau_os_iso ; do
featurePlotZZ ZZ_EC90_boosted_bb_HPSTau $region --skip-dataset-tags nonResOnly,met,res & # skipping res to not show signals
done
)

## os iso&noiso together regions
law run PrePlotWrapper --version prod_241213c_DNN25  --MergeCategorization-version prod_241213c_DNN25  --config-name bul_2018_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau --PrePlot-systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PrePlot-region-names etau_os,etau_ss,mutau_os,mutau_ss,tautau_os,tautau_ss \
  --PrePlot-feature-tags base,cat,dnn_limited --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 10 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --PrePlot-no-poll --workers 200
law run FeatureHistogramWrapper --version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os,etau_ss,mutau_os,mutau_ss,tautau_os,tautau_ss \
 --FeatureHistogram-feature-tags base,cat --FeatureHistogram-skip-feature-tags blind --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-process-group-name zz_res_limitedMass \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd False --workers 10
law run FeaturePlotWrapper --version prod_241213c_DNN25 --FeatureHistogram-version prod_241213c_DNN25 --PrePlot-version prod_241213c_DNN25  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau --region-names etau_os,etau_ss,mutau_os,mutau_ss,tautau_os,tautau_ss \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags nonResOnly --FeaturePlot-process-group-name zz_res_limitedMass \
 --FeaturePlot-do-qcd False  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5


############################## PLOTTING  pre-DNN
# test
law run PrePlot --version prod_241213c_test  --MergeCategorization-version prod_241213c_test --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_boosted_bb_boostedTau --systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot


function featurePlotTest {
    REGION_NAME=$1
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241213c_test --FeatureHistogram-version prod_241213c_test --PrePlot-version prod_241213c_test  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name ZZ_EC90_boosted_bb_boostedTau --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags base,cat,dnn   \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png --do-qcd False  "${@:2}"
}
featurePlotTest tautau_os_iso




law run MergeCategorizationWrapper --version prod_241213c  --JoinDNNInference-version prod_241213c  --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --category-names ZZ_EC90_boosted_bb_boostedTau  \
 --Categorization-feature-modules-file modulesrdf_cat \
 --MergeCategorization-from-DNN-inference True --workers 5


### plot full
#  --PrePlot-tasks-per-job 8
law run PrePlot --version prod_241213c_test  --MergeCategorization-version prod_241213c --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_boosted_bb_boostedTau --systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot

law run PrePlotWrapper --version prod_241213c  --MergeCategorization-version prod_241213c  --config-name bul_2018_ZZ_v12 \
  --skip-dataset-tags data \
  --category-names ZZ_EC90_boosted_bb_boostedTau --PrePlot-systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 200
law run PrePlotWrapper --version prod_241213c  --MergeCategorization-version prod_241213c  --config-name bul_2018_ZZ_v12 \
  --dataset-tags met \
  --category-names ZZ_EC90_boosted_bb_boostedTau  \
  --PrePlot-region-names etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnn --PrePlot-skip-feature-tags met --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=1.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 20


function featurePlotZZ {
    CATEGORY=$1
    REGION_NAME=$2
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241213c_noSignal --FeatureHistogram-version prod_241213c --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name ${CATEGORY}   --feature-tags base,cat --skip-feature-tags blind   \
  --process-group-name zz_res_limitedMass --stack --hide-data False --do-qcd --region-name ${REGION_NAME} \
  --save-png --normalize-signals --workers 3  "${@:3}" 
#   law run FeaturePlotSyst --version prod_241213c --FeatureHistogram-version prod_241213c --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
#  --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
#   --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
#   --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
}
#featurePlotTest etau_os_iso_HPSTaus
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for region in etau_os_iso mutau_os_iso tautau_os_iso ; do
featurePlotZZ ZZ_EC90_boosted_bb_boostedTau $region --skip-dataset-tags nonResOnly,hpsData,res & # skipping res to not show signals
done
)

# testing
--do-qcd
law run FeatureHistogram --version prod_241213c_test  --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name ZZ_EC90_boosted_bb_boostedTau   --feature-names fatjet_msoftdrop --skip-dataset-tags nonResOnly,hpsData  \
  --process-group-name zz_res --hide-data False  --region-name etau_ss_iso 



################################################################################################################ BASELINE
law run Categorization --version prod_241213c_test --PreprocessRDF-version prod_241213c --PreprocessRDF-category-name base_selection --config-name bul_2018_ZZ_v12 \
  --dataset-name tt_sl --Categorization-feature-modules-file modulesrdf_cat --category-name ZZ_EC90_resolved_1b_HPSTau \
   --print-status 0



law run CategorizationWrapper --version prod_241213c --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --category-names ZZ_EC90_resolved_1b_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
   --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 3 --Categorization-submission-threads 1 --Categorization-retries 0 \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,request_memory=4.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 1 --Categorization-no-poll






##### testing
law run PrePlotWrapper --version prod_241213c_test1  --PreprocessRDF-version prod_241213c  --config-name bul_2018_ZZ_v12 \
  --dataset-tags met --PrePlot-skip-categorization \
  --category-names base_selection  \
  --PrePlot-region-names etau_os_iso_boostedTaus \
  --PrePlot-feature-tags baseObjects --PrePlot-preplot-modules-file preplot \
   --workers 20





################################################################################################################################################################################################################################################################################################################################################
################################################################################################################ DATACARDS RESONANT
################################################################################################################################################################################################################################
# Making resonant datacards : 
# 1) usual PrePlot with everything (can be shared with regular plotting)
# 2) FeatureHistogram with datacard_zz_res_reduced, incl. all resonant samples & all DNN masses
# 3) FeatureHistogramRebin, separately for each mass. 
# 4) CreateDatacards, separately for each mass

# --FeatuerHistogram-skip-feature-names fatjet_msoftdrop

# versions : prod_250117_datacards_v4 : main FeatureHistogram, 18 only (17 16 bugged)
# - prod_250117b_datacards_v4 : fixed 17 16 using preplot prod_250117b
# - prod_250117b_datacards_v23 : ZH new Featurehistogram with xs of Z'->ZH set to 1 (instead Z'->ZH->bbtautau set to 1), for ZH combination

law run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 2


law run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau  --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 2

for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v4 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_zz_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done

for CATEGORY in ZbbHtt_OC90_boosted_bb_boostedTau ZbbHtt_OC90_boosted_bb_HPSTau ZbbHtt_OC90_resolved_1b_HPSTau ZbbHtt_OC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v23 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done
for CATEGORY in ZttHbb_OC90_boosted_bb_boostedTau ZttHbb_OC90_boosted_bb_HPSTau ZttHbb_OC90_resolved_1b_HPSTau ZttHbb_OC90_resolved_2b_HPSTau; do
./submit_condor.sh $(which law) run FeatureHistogramWrapper --version prod_250117b_datacards_v23 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZttHbb_v12 --region-names etau_os_iso,mutau_os_iso,tautau_os_iso  --FeatureHistogram-skip-dataset-tags nonResOnly --FeatureHistogram-feature-tags dnn --FeatureHistogram-process-group-name datacard_res_reduced   --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 8 --category-names $CATEGORY
done

# 200,1000,4000
# FeatureHistogram should be run first as for some reason '--FeatureHistogram-dataset-names-after-skip NO_STR' does not work as it should
# datacards version : v8 : removed prefiring and PU lnN (shape only)
# v11 : don't consider QCD for bin merging
# v19 : prune processes with <10 MC events (mostly wjets)
# v23 : new ZH xs for combination Zbb Ztt
# ZZ

law run CreateDatacardsResonantWrapper --version prod_250117b_datacards_v18 --version-template prod_250117b_datacards_v18/M__MASS__ --FeatureHistogramRebin-version prod_250117b_datacards_v11 --FeatureHistogram-version prod_250117b_datacards_v4 --config-name bul_${YEAR}_ZZ_v12  \
 --resonant-masses 200,210,220,230,240,250,260,270,280,300,320,350,360,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2200,2400,2500,2600,2800,3000,3500,4000,4500,5000 \
  --feature-names-template dnn_ZZbbtt_500bv_M__MASS__ --FeatureHistogram-feature-names NO_STR --FeatureHistogram-feature-tags dnn \
  --CreateDatacards-skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip-template GluGluToXToZZTo2B2Tau_M__MASS__ --FeatureHistogram-dataset-names-after-skip NO_STR --FeatureHistogram-skip-dataset-tags nonResOnly \
 --CreateDatacards-process-group-name datacard_zz_res_reduced  --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-drop-secondary-signals 20 --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs --CreateDatacards-prune-bad-negligible-systs --CreateDatacards-hide-data True --CreateDatacards-do-qcd \
 --make-plots --FeaturePlot-skip-dataset-tags nonResOnly,resSignal --FeaturePlot-process-group-name datacard_zz_res_reduced \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data True --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --workers 10

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




################################################################################################################################################################################################################################################################################################################################################
################################################################################################################ DATACARDS NON-RESONANT
################################################################################################################################################################################################################################
law run FeatureHistogramWrapper --version prod_250117b_datacards_nonres_v1 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly --FeatureHistogram-feature-names dnn_ZZbbtt_500b,ZZKinFit_mass --FeatureHistogram-process-group-name datacard_zz \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 10


law run CreateDatacardsWrapper --version prod_250117b_datacards_nonres_v1 --FeatureHistogramRebin-version prod_250117b_datacards_nonres_v1 --FeatureHistogram-version prod_250117b_datacards_nonres_v1 --config-name bul_${YEAR}_ZZ_v12  \
  --CreateDatacards-skip-dataset-tags resOnly --FeatureHistogram-skip-dataset-tags resOnly --CreateDatacards-feature-names dnn_ZZbbtt_500b \
 --CreateDatacards-process-group-name datacard_zz  --category-names ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --CreateDatacards-merge-bins --CreateDatacards-prune-shape-systs --CreateDatacards-prune-bad-qcd-systs  --CreateDatacards-hide-data True --CreateDatacards-do-qcd \
 --make-plots --FeaturePlot-feature-names dnn_ZZbbtt_500b --FeaturePlot-skip-dataset-tags resOnly --FeaturePlot-process-group-name datacard_zz \
 --FeaturePlot-merge-bins  --FeaturePlot-hide-data False --FeatureHistogramRebin-hide-data True --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --workers 10



law run FeatureHistogramWrapper --version prod_250117b_datacards_nonres_v1 --MergePrePlot-version prod_250117b --PrePlot-version prod_250117b --PrePlot-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-skip-dataset-tags resOnly --FeatureHistogram-feature-names dnn_ZZbbtt_500b,ZZKinFit_mass --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data True --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot  --workers 10

law run FeaturePlot --version prod_250117b_datacards_nonres_v1 --FeatureHistogram-version prod_250117b_datacards_nonres_v1 --config-name bul_${YEAR}_ZZ_v12  \
 --category-name ZZ_EC90_resolved_2b_HPSTau   --feature-names dnn_ZZbbtt_500b   \
  --process-group-name zz --stack --hide-data False --FeatureHistogramRebin-hide-data True --do-qcd --region-name tautau_os_iso \
  --FeaturePlot-merge-bins --FeaturePlot-blinded --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y --histogram-minimum 0.1 --workers 3  
