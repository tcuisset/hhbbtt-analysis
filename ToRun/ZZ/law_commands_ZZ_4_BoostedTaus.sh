# BoostedTaus first prod
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau

###############################################################################################################################################
# PRECOUNTER
###############################################################################################################################################
law run MergeCategorizationStatsWrapper --version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags data \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-tasks-per-job 1 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --print-status 0



law run PreprocessRDF --version prod_241021_test3 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M200 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0

law run PreprocessRDFWrapper --version prod_241022 --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_ptz6 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PreprocessRDF-tasks-per-job 3


law run MergeCategorizationWrapper --version prod_241022 --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_ptz6 --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --workers 20

cat=ZZ_EC90_resolved_1b_boostedTau
for cat in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
law run FeaturePlot --version prod_241021 --PrePlot-version prod_241021 --avoid-normalization  --config-name bul_2018_ZZ_v12 \
 --category-name $cat --dataset-names dy_ptz6 --feature-tags base,cat  \
  --process-group-name zz_res --stack --hide-data True --workers 10
done

cat=ZZ_EC90_boosted_bb_boostedTau
law run FeaturePlot --version prod_241022 --PrePlot-version prod_241022 --MergeCategorization-version prod_241022 --avoid-normalization  --config-name bul_2018_ZZ_v12 \
 --category-name $cat --dataset-names dy_ptz6 --feature-tags base,cat  \
  --process-group-name zz_res --stack --hide-data True --workers 10


###########################################################################
law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 10
# 

law run PreprocessRDF --version prod_241023g --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M3000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all --workers 1 --branch 0

law run PreprocessRDF --version prod_241022 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name ggf_sm --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 5



########################################################################### First partial reprocessing
law run PreprocessRDFWrapper --version prod_241023f --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names dy,tt_sl,tt_dl --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 10

# continuation
law run PreprocessRDFWrapper --version prod_241023f --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 10


law run MergeCategorizationWrapper --version prod_241023f --config-name bul_2018_ZZ_v12 \
 --dataset-names dy,tt_sl,tt_dl,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 3 --workers 20

law run MergeCategorizationWrapper --version prod_241023f --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 3 --workers 20


# plotting pilot
cat=ZZ_EC90_boosted_bb_boostedTau
law run FeaturePlot --version prod_241023f_norm2 --FeatureHistogram-version prod_241023f --PrePlot-version prod_241023f  --MergeCategorization-version prod_241023f  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $cat --dataset-names dy,tt_sl,tt_dl,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000 --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data True --region-name tautau_os_iso --multiply-signals-normalization 0.02 \
  --workers 10


# SR+QCD CR
for cat in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
law run FeaturePlot --version prod_241023f --PrePlot-version prod_241023f --avoid-normalization  --config-name bul_2018_ZZ_v12 \
 --category-name $cat --dataset-names dy,tt_sl,tt_dl,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --feature-tags base,cat  \
  --process-group-name zz_res --stack --hide-data True --workers 10
done


function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2

    law run FeaturePlot --version prod_241023f_norm2 --FeatureHistogram-version prod_241023f --PrePlot-version prod_241023f  --MergeCategorization-version prod_241023f  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --dataset-names dy,tt_sl,tt_dl,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000 --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso --normalize-signals True \
  --workers 1 "${@:3}"
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &
done
wait)
# wait
# done




############### BoostedTau signal with new version

law run PreprocessRDF --version prod_241030_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name data_met_a --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0

law run PreprocessRDFWrapper --version prod_241031 --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 10
law run MergeCategorizationWrapper --version prod_241031 --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 3 --workers 20




########################################################################### Second partial reprocessing 
# zz_sl_signal,zz_sl_background,
law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 15

law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 15
law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names data_met_a,data_met_b,data_met_c,data_met_d --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --PreprocessRDF-tasks-per-job 3 \
 --workers 15

#  --skip-dataset-tags genfilter,data
law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --workers 30

law run PreprocessRDFWrapper --version prod_241023g --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-tags data --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' --PreprocessRDF-poll-interval 5 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 1 \
 --workers 30


 # bugged files : 
# /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_dl/cat_base/prod_241023g/data_267.root is corrupted in dau1_pt somewhere
# /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1168.root

# /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_535.root
# /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_463.root
# /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_880.root
# logs : /data_CMS/cms/cuisset/ZHbbtautau/frameworkJobs/nanoaod_base_analysis/data/store/PreprocessRDF/bul_2018_ZZ_v12/tt_dl/cat_base/prod_241023g/stdall_267To268.txt
# finding bugged files

# new bugged
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1198.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1187.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_835.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1191.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1169.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_535.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_602.root

#
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_1221.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_847.root

rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_603.root
rm /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_783.root


/data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/tt_sl/cat_base/prod_241023g/data_880.root

# TODO 
law run MergeCategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
 --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 5 --workers 20

# --skip-dataset-tags genfilter
law run MergeCategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
  --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 10 --workers 50

# for Categorization status
law run CategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
 --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
  --Categorization-feature-modules-file modulesrdf_cat \
  --workers 20 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 5
law run CategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags genfilter \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
  --Categorization-feature-modules-file modulesrdf_cat --print-status 1
law run Categorization --version prod_241023g --config-name bul_2018_ZZ_v12 \
 --dataset-name tt_sl --Categorization-base-category-name base \
 --category-name ZZ_EC90_resolved_1b_boostedTau  \
  --Categorization-feature-modules-file modulesrdf_cat --print-status 0

### for DNN training
law run Categorization --version prod_241023g_DNNtraining3 --PreprocessRDF-version prod_241023g --config-name bul_2018_ZZ_v12 \
 --dataset-name tt_sl --Categorization-base-category-name base \
 --category-name ZZ_elliptical_cut_90_sr  \
  --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --print-status 0
law run CategorizationWrapper --version prod_241023g_DNNtraining3 --PreprocessRDF-version prod_241023g --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags data --Categorization-base-category-name base \
 --category-names ZZ_elliptical_cut_90_sr  \
  --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN \
  --workers 70 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --Categorization-tasks-per-job 10


# ,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000
cat=ZZ_EC90_boosted_bb_boostedTau
law run FeaturePlot --version prod_241023g_test2 --FeatureHistogram-version prod_241023g_test2 --PrePlot-version prod_241023g  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $cat --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data True --region-name tautau_os_iso --multiply-signals-normalization 0.02 \
  --PrePlot-preplot-modules-file preplot --workers 10


cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018


function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2

    law run FeaturePlot --version prod_241023g_full --FeatureHistogram-version prod_241023g_full --PrePlot-version prod_241023g_full  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags genfilter,met --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso --normalize-signals True \
  --PrePlot-preplot-modules-file preplot --workers 10 "${@:3}"
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &
wait
done
)
# wait
# done
category=ZZ_EC90_resolved_1b_boostedTau
category=ZZ_EC90_resolved_2b_boostedTau
category=ZZ_EC90_boosted_bb_boostedTau
category=ZZ_EC90_resolved_1b_HPSTau
category=ZZ_EC90_resolved_2b_HPSTau
category=ZZ_EC90_boosted_bb_HPSTau
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &

################################ PLOTTING
function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2

    law run FeaturePlot --version prod_241023g_resLimited --FeatureHistogram-version prod_241023g_resLimited --PrePlot-version prod_241023g_full  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags genfilter,met,resExtra --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --workers 10 "${@:3}"
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &
wait
done
)

featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005

featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &




####### plot with data
# pilot
law run PrePlotWrapper --PrePlot-version prod_241023g_full3  --MergeCategorization-version prod_241023g --PrePlot-config-name bul_2018_ZZ_v12 \
  --category-names ZZ_EC90_resolved_1b_boostedTau \
  --region-names etau_ss_inviso \
  --PrePlot-feature-tags base,cat,dnnInput --PrePlot-preplot-modules-file preplot \
  --dataset-names GluGluToXToZZTo2B2Tau_M1000 \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PrePlot-tasks-per-job 10
law run PrePlotWrapper --PrePlot-version prod_241023g_full2  --MergeCategorization-version prod_241023g --PrePlot-config-name bul_2018_ZZ_v12 \
  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau \
  --region-names etau_os_iso,etau_os_inviso,etau_ss_inviso,etau_ss_iso,mutau_os_iso,mutau_os_inviso,mutau_ss_inviso,mutau_ss_iso,tautau_os_iso,tautau_os_inviso,tautau_ss_inviso,tautau_ss_iso \
  --PrePlot-feature-tags base,cat,dnnInput --PrePlot-preplot-modules-file preplot \
  --dataset-names tt_sl,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_2j,zz_sl_signal,zz_bbtt \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 2 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PrePlot-tasks-per-job 10 --workers 100

python3 -m cProfile -o preplot.prof $(which law)  run PrePlotWrapper --PrePlot-version prod_241023g_full2  --MergeCategorization-version prod_241023g --PrePlot-config-name bul_2018_ZZ_v12 \
  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau \
  --region-names etau_os_iso,etau_os_inviso,etau_ss_inviso,etau_ss_iso,mutau_os_iso,mutau_os_inviso,mutau_ss_inviso,mutau_ss_iso,tautau_os_iso,tautau_os_inviso,tautau_ss_inviso,tautau_ss_iso \
  --PrePlot-feature-tags base,cat,dnnInput --PrePlot-preplot-modules-file preplot \
  --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,GluGluToXToZZTo2B2Tau_M400 \
  --print-status 0



function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241023g_resLimited --FeatureHistogram-version prod_241023g_resLimited --PrePlot-version prod_241023g_full3  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-tags base,cat,dnnInput  \
  --process-group-name zz_res --stack --hide-data False --do-qcd --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --workers 10 "${@:3}"
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau; do
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &
wait
done
)

featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005

featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &







###################### DNN ZZ resonant
# prod prod_241119b -> DNN ZZ resonant retrained for boostedTaus (Categorization + DNN + MergeCat), old DNN for non-resonant (no boostedTaus)
# preplot prod_241119 is bugged

# --dataset-names tt_sl \
law run MergeCategorizationWrapper --version prod_241118d --Categorization-version prod_241118d --PreprocessRDF-version prod_241023g --config-name bul_2018_ZZ_v12 \
--dataset-names ttzz \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat \
 --JoinDNNInference-base-category-name base --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat \
 --workers 40

# main all datasets
# --systematic-names ele_scale,ele_resolution,tes,jer,jec 
# --DNNInference-workflow htcondor --DNNInference-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7,request_memory=500M,priority=6' --DNNInference-htcondor-scheduler llrt3condor.in2p3.fr --DNNInference-transfer-logs  --DNNInference-retries 1 --DNNInference-poll-interval 3 --DNNInference-tasks-per-job 10  \

#   --dataset-names tth_tautau,ttw_qq \
law run MergeCategorizationWrapper --version prod_241119  --Categorization-version prod_241119 --PreprocessRDF-version prod_241023g --config-name bul_2018_ZZ_v12 \
 --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
 --Categorization-feature-modules-file modulesrdf_cat \
 --JoinDNNInference-base-category-name base --MergeCategorization-from-DNN-inference True --JoinDNNInference-feature-modules-file modulesrdf_cat

# bugged files
/data_CMS/cms/cuisset/cmt/Categorization/bul_2018_ZZ_v12/ttw_qq/cat_ZZ_EC90_resolved_2b_HPSTau/prod_241119/data_1.root
/data_CMS/cms/cuisset/cmt/Categorization/bul_2018_ZZ_v12/tt_sl/cat_ZZ_EC90_resolved_2b_boostedTau/prod_241119/data_935.root

/data_CMS/cms/cuisset/cmt/Categorization/bul_2018_ZZ_v12/ttw_qq/cat_ZZ_EC90_resolved_2b_HPSTau/prod_241119/data_1.root

for step in Categorization DNNInference JoinDNNInference; do
rm /data_CMS/cms/cuisset/cmt/$step/bul_2018_ZZ_v12/tth_tautau/cat_ZZ_EC90_boosted_bb_boostedTau/prod_241119/data_90.root
rm /data_CMS/cms/cuisset/cmt/$step/bul_2018_ZZ_v12/tth_tautau/cat_ZZ_EC90_resolved_1b_boostedTau/prod_241119/data_10.root
rm /data_CMS/cms/cuisset/cmt/$step/bul_2018_ZZ_v12/ttw_qq/cat_ZZ_EC90_resolved_2b_HPSTau/prod_241119/data_1.root
done


law run PrePlotWrapper --version prod_241119c  --MergeCategorization-version prod_241119 --config-name bul_2018_ZZ_v12 \
  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau \
  --PrePlot-region-names etau_os_iso,etau_os_inviso,etau_ss_inviso,etau_ss_iso,mutau_os_iso,mutau_os_inviso,mutau_ss_inviso,mutau_ss_iso,tautau_os_iso,tautau_os_inviso,tautau_ss_inviso,tautau_ss_iso \
  --PrePlot-feature-tags base,cat,dnnInput,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 200
# boostedTau only
 


function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241119d_resLimited --FeatureHistogram-version prod_241119d --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-tags base,cat,dnnInput,dnn --FeatureHistogram-feature-tags base,cat,dnnInput \
  --process-group-name zz_res --stack --hide-data False --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.05 --workers 4  "${@:3}"
  # --do-qcd 
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
# ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau
#  ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_boosted_bb_HPSTau
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau; do
featurePlotZZ_SR_res $category etau  &
featurePlotZZ_SR_res $category mutau  &
featurePlotZZ_SR_res $category tautau  &
done
)

featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --region-name tautau_ss_iso --do-qcd False --version prod_241119_resLimited_qcdCR --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --region-name tautau_ss_inviso --do-qcd False --version prod_241119_resLimited_qcdCR --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --region-name tautau_os_inviso --do-qcd False --version prod_241119_resLimited_qcdCR --multiply-signals-normalization 0.005

featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005
featurePlotZZ_SR_res ZZ_EC90_boosted_bb_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.005

featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau etau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau mutau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &
featurePlotZZ_SR_res ZZ_EC90_resolved_2b_boostedTau tautau --version prod_241023g_resLimited3 --FeatureHistogram-version prod_241023g_resLimited2 --multiply-signals-normalization 0.5 &

######## making AN plots
FEATURES=ZZ_svfit_mass_res_veryHigh,ZZKinFit_mass_res,ZZKinFit_mass_res_high,ZZKinFit_mass_res_low
FEATURES_DNN=dnn_ZZbbtt_M200_10b,dnn_ZZbbtt_M1000_10b,dnn_ZZbbtt_M2000_10b,dnn_ZZbbtt_M3000_10b,dnn_ZZbbtt_M5000_10b
FEATURES_DNN_mergeBins=dnn_ZZbbtt_M200_500b,dnn_ZZbbtt_M1000_500b,dnn_ZZbbtt_M2000_500b,dnn_ZZbbtt_M3000_500b,dnn_ZZbbtt_M5000_500b
FEATURES_ALL=$FEATURES,$FEATURES_DNN
RESONANT_MASSES="200 210 220 230 240 250 260 280 300 320 350 360 400 450 500 550 600 650 700 750 800 850 900 1000 \
                    1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2200 2400 2500 2600 2800 3000 3500 4000 4500 5000"

REGION_NAME=etau
REGION_NAME=mutau
REGION_NAME=tautau

CATEGORY=ZZ_EC90_boosted_bb_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES --FeatureHistogram-feature-names $FEATURES_ALL \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.01 --remove-output 1,a,True&
done

CATEGORY=ZZ_EC90_resolved_1b_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES --FeatureHistogram-feature-names $FEATURES_ALL \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.5  --remove-output 1,a,True& # --remove-output 1,a,True
done

CATEGORY=ZZ_EC90_resolved_2b_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES --FeatureHistogram-feature-names $FEATURES_ALL \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.5  --remove-output 1,a,True &
done

## DNN

DATASETS=zz_bbtt,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,\
wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,tt_dl,tt_sl,tt_fh,\
zz_sl_background,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,\
zh_htt,zh_hbb_zll,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,\
ewk_z,ewk_wplus,ewk_wminus,st_tw_antitop,st_tw_top,st_antitop,st_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e,data_met_a,data_met_b,data_met_c,data_met_d

CATEGORY=ZZ_EC90_boosted_bb_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES_DNN_mergeBins --FeatureHistogram-feature-names $FEATURES \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.005 --merge-bins --equal-bin-width &
done

for MASS in 200 210 220 230 240 250 260 280 300 320 350 360 400 450 500 550 600 650 700 750 800 850 900 1000 \
                    1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2200 2400 2500 2600 2800 3000 3500 4000 4500 5000; do
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN_DNN --FeatureHistogram-version prod_241119d_AN_DNN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --dataset-names GluGluToXToZZTo2B2Tau_M$MASS,$DATASETS --feature-names dnn_ZZbbtt_M${MASS}_500b  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.005 --merge-bins --equal-bin-width &
done
done

CATEGORY=ZZ_EC90_resolved_1b_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES_DNN --FeatureHistogram-feature-names $FEATURES \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.1  & # --remove-output 1,a,True
done
for MASS in 200 210 220 230 240 250 260 280 300 320 350 360 400 450 500 550 600 650 700 750 800 850 900 1000 \
                    1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2200 2400 2500 2600 2800 3000 3500 4000 4500 5000; do
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN_DNN --FeatureHistogram-version prod_241119d_AN_DNN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --dataset-names GluGluToXToZZTo2B2Tau_M$MASS,$DATASETS --feature-names dnn_ZZbbtt_M${MASS}_500b  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.1 --merge-bins --equal-bin-width &
done
done

CATEGORY=ZZ_EC90_resolved_2b_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN --FeatureHistogram-version prod_241119d_AN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --feature-names $FEATURES_DNN --FeatureHistogram-feature-names $FEATURES \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.1   &
done
for MASS in 200 210 220 230 240 250 260 280 300 320 350 360 400 450 500 550 600 650 700 750 800 850 900 1000 \
                    1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2200 2400 2500 2600 2800 3000 3500 4000 4500 5000; do
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_241119d_resLimited_AN_DNN --FeatureHistogram-version prod_241119d_AN_DNN --PrePlot-version prod_241119c  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --dataset-names GluGluToXToZZTo2B2Tau_M$MASS,$DATASETS --feature-names dnn_ZZbbtt_M${MASS}_500b  \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME}_os_iso \
  --PrePlot-preplot-modules-file preplot --save-png --multiply-signals-normalization 0.1 --merge-bins --equal-bin-width &
done
done




######### plotting noregion 

# law run PrePlotWrapper --version prod_241119b  --MergeCategorization-version prod_241119 --config-name bul_2018_ZZ_v12 \
#   --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau \
#   --PrePlot-region-names , \
#   --PrePlot-feature-tags base,cat,dnnInput,dnn --PrePlot-preplot-modules-file preplot \
#   --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
#  --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
#  --workers 200


########################################################### Datacards ###########################################################
###########################################################
function makeResonantDatacards_ZZ {
    MASS=$1
    CATEGORY=$2
    REGION_NAME=$3

    # make datacards for both the parametrized an non-parametrized DNN
    law run CreateDatacards --version prod_241119e_M$MASS --FeatureHistogram-version prod_241119e_datacards --PrePlot-version prod_241119c --config-name bul_2018_ZZ_v12 \
 --feature-names dnn_ZZbbtt_M${MASS}_500b  \
 --MergeCategorizationStats-version prod_241024 \
 --dataset-names GluGluToXToZZTo2B2Tau_M$MASS,$DATASETS \
 --process-group-name datacard_zz_res_reduced  --category-name $CATEGORY \
 --region-name ${REGION_NAME}_os_iso  --hide-data True --merge-bins "${@:4}"  &
}

for res_mass in $RESONANT_MASSES; do
    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_1b_boostedTau etau 
    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_1b_boostedTau mutau 
    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_1b_boostedTau tautau 

    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_2b_boostedTau etau  
    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_2b_boostedTau mutau  
    makeResonantDatacards_ZZ $res_mass ZZ_EC90_resolved_2b_boostedTau tautau 

    # makeResonantDatacards_ZZ $res_mass ZZ_EC90_boosted_bb_boostedTau etau  
    # makeResonantDatacards_ZZ $res_mass ZZ_EC90_boosted_bb_boostedTau mutau  
    # makeResonantDatacards_ZZ $res_mass ZZ_EC90_boosted_bb_boostedTau tautau 
done


########################################################### noregion plots
# making plots without any region cut
#pilot
law run PrePlot --version prod_241130  --MergeCategorization-version prod_241119 --config-name bul_2018_ZZ_v12 \
  --category-name ZZ_EC90_resolved_1b_boostedTau \
  --dataset-name dy_ptz6 \
  --PrePlot-region-names etau_os,mutau_os,tautau_os,etau_ss,mutau_ss,tautau_ss \
  --PrePlot-feature-tags base,cat,dnnInput,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --branch 0
law run PrePlotWrapper --version prod_241130  --MergeCategorization-version prod_241119 --config-name bul_2018_ZZ_v12 \
  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau \
  --PrePlot-region-names etau_os,mutau_os,tautau_os,etau_ss,mutau_ss,tautau_ss \
  --PrePlot-feature-tags base,cat,dnnInput,dnn --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --workers 200



function featurePlotZZ_SR_res {
    CATEGORY=$1
    REGION_NAME=$2
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241130 --FeatureHistogram-version prod_241130 --PrePlot-version prod_241130  --MergeCategorization-version prod_241023g  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --category-name $CATEGORY --skip-dataset-tags nonResOnly,resExtra --skip-dataset-names GluGluToXToZZTo2B2Tau_M200 --feature-tags base,cat --skip-feature-names fatjet_pnet_SF  \
  --process-group-name zz_res --stack --hide-data False --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png --normalize-signals --workers 10 "${@:3}"
}
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for category in ZZ_EC90_resolved_1b_boostedTau ZZ_EC90_resolved_2b_boostedTau ZZ_EC90_boosted_bb_boostedTau; do
featurePlotZZ_SR_res $category etau_os  &
featurePlotZZ_SR_res $category mutau_os  &
featurePlotZZ_SR_res $category tautau_os  &
wait
done
)
