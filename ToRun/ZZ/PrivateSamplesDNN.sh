# BoostedTaus 5th prod (fix e-tau trigger)
# prod_250314 : fix etau trigger
# prod_250315 : tight DeepTauVsEle in etau channel + bjet eta cut fix for 2016
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018


########## NOTES
## preprocess

# preplot
# res1b tt_sl tt_fh tt_dl  dy_ptz1/2/3 st_tw_top st_tw_antitop st_top st_antitop tth_tautau take more than 2 hours on condor

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
# systematics : jec_1 jer tes met_unclustered ele_scale ele_resolution
# 16 systematics : total 1+2*16 = 33 systs

# central only
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-names zz_bbtt_dnnTraining,zz_bbtt_vptFilter_dnnTraining --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15  \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=3.5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --PreprocessRDF-parallel-jobs 150 --workers 40 --PreprocessRDF-tasks-per-job 4

# systs
law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-names zz_bbtt_dnnTraining,zz_bbtt_vptFilter_dnnTraining --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr  --PreprocessRDF-poll-interval 15 --split-syst-group 11 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=-10,T3queue=long,WNTag=el9,request_memory=5G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0  --workers 10 --PreprocessRDF-tasks-per-job 1




law run PreprocessRDFWrapper --version prod_250315 --category-name base_selection --config-name bul_${YEAR}_ZZ_v12 \
 --dataset-names tt_ht600,tt_ht800,tt_ht1200 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_preproc_light --systematic-names central,tes,jec_9,jec_10,jec_11,jec_1,met_unclustered \
 --workers 5

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
  --dataset-names zz_bbtt_dnnTraining,zz_bbtt_vptFilter_dnnTraining,tt_ht800,tt_ht1200 --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --category-names ZZ_elliptical_cut_90_DNNtraining  \
  --systematic-names central,tes,jec_9,jec_10,jec_11,jec_1,met_unclustered \
     --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs --Categorization-poll-interval 10 --Categorization-submission-threads 1 --Categorization-avoid-vms False  \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=1,T3queue=long,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --Categorization-retries 0 --Categorization-tasks-per-job 5 --workers 30

