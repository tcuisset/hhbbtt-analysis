# BoostedTaus second prod (MET trig SF, etc)
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau

law run PreprocessRDF --version prod_241115_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 1

law run PreprocessRDF --version prod_241115_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --retries 0



law run PreprocessRDFWrapper --version prod_241206 --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 3 --PreprocessRDF-retries 0 --workers 20

# pilots
law run PreprocessRDF --version prod_241207 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 
law run PreprocessRDF --version prod_241208_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 
law run PreprocessRDF --version prod_241207 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name data_tau_a --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --branch 0 


law run PreprocessRDFWrapper --version prod_241207 --category-names base --config-name bul_2018_ZZ_v12 \
 --skip-dataset-tags res,nonResOnly --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 3 --PreprocessRDF-retries 0 --workers 200
law run PreprocessRDFWrapper --version prod_241207 --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-tags resLimited --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 3 --PreprocessRDF-retries 0 --workers 50





### Running systematics
law run PreprocessRDF --version prod_241207_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 --systematic-name 



################################################################### CATEGORIZATION
law run JoinDNNInference --version prod_241207_test1 --PreprocessRDF-version prod_241207 --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M5000 --base-category-name base --DNNInference-base-category-name base --Categorization-base-category-name base --PreprocessRDF-category-name base \
 --category-name ZZ_EC90_boosted_bb_boostedTau  \
 --Categorization-feature-modules-file modulesrdf_cat --feature-modules-file modulesrdf_cat --branch 0



############################################################### PLOTTING (no categorization)
law run PrePlot --version prod_241207_test1  --PreprocessRDF-version prod_241207 --skip-categorization --config-name bul_2018_ZZ_v12 \
  --category-name base \
  --dataset-name dy_ptz6 \
  --PrePlot-region-names etau_os,mutau_os,tautau_os,etau_ss,mutau_ss,tautau_ss,etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot 

law run PrePlotWrapper --version prod_241207_baseline  --PreprocessRDF-version prod_241207 --PrePlot-skip-categorization --config-name bul_2018_ZZ_v12 \
  --category-names base \
  --skip-dataset-tags res,nonResOnly \
  --PrePlot-region-names etau_os,mutau_os,tautau_os,etau_ss,mutau_ss,tautau_ss,etau_os_iso,etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_os_iso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_os_iso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso \
  --PrePlot-feature-tags base --PrePlot-preplot-modules-file preplot \
  --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-tasks-per-job 8 --PrePlot-transfer-logs --PrePlot-poll-interval 3 --PrePlot-submission-threads 1 --PrePlot-retries 0 \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 200



function featurePlotZZ {
    REGION_NAME=$1
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241207_baseline --FeatureHistogram-version prod_241207_baseline --PrePlot-version prod_241207_baseline  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --skip-dataset-tags nonResOnly,res  --feature-tags base --skip-feature-names fatjet_pnet_SF   \
  --process-group-name zz_res --stack --hide-data False --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
}
featurePlotZZ etau_os
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for region in etau_os mutau_os tautau_os etau_ss mutau_ss tautau_ss etau_os_iso etau_ss_iso etau_os_inviso etau_ss_inviso mutau_os_iso mutau_ss_iso mutau_os_inviso mutau_ss_inviso tautau_os_iso tautau_ss_iso tautau_os_inviso tautau_ss_inviso; do
featurePlotZZ $region  &
done

)


############################################################### PLOTTING 2D Jet veto maps (no categorization)
#--region-name    --PrePlot2D-version prod_241207_baseline_test3  --PrePlot2D-weights-to-skip hem_weight
law run FeaturePlot2D --version prod_241207_baseline_test4  --PreprocessRDF-version prod_241207 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot2D-skip-categorization --category-name base --region-name baseline_hem_affected --dataset-names dy_ptz6  --feature-names jet_eta_hem:jet_phi_hem,jet_eta:jet_phi  \
  --process-group-name data_bkg --stack --hide-data False  \
  --PrePlot2D-preplot-modules-file preplot --save-png --workers 10

function featurePlot_jetMap {
law run FeaturePlot2D --version prod_241207_baseline_noHEMweight  --PreprocessRDF-version prod_241207 --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot2D-skip-categorization --category-name base  --region-name baseline_region --skip-dataset-tags nonResOnly,res,data  --feature-names jet_eta_hem:jet_phi_hem,jet_eta:jet_phi  \
  --process-group-name data_bkg --stack --hide-data False --PrePlot2D-weights-to-skip hem_weight \
  --PrePlot2D-preplot-modules-file preplot --save-png \
  --PrePlot2D-workflow htcondor --PrePlot2D-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot2D-tasks-per-job 30 --PrePlot2D-transfer-logs --PrePlot2D-poll-interval 3 --PrePlot2D-submission-threads 1 --PrePlot2D-retries 0 \
 --PrePlot2D-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 200 "${@:1}"
}

featurePlot_jetMap --version prod_241207_baseline_noHEMweight --region-name baseline_region --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap --version prod_241207_baseline_HEMweight --region-name baseline_region 

featurePlot_jetMap --version prod_241207_baseline_hemAffected_noHEMweight --region-name baseline_hem_affected --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap --version prod_241207_baseline_HEMweight --region-name baseline_hem_affected 






############ preprocess v2
law run PreprocessRDF --version prod_241208b --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M2000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 1 --PreprocessRDF-retries 0 --workers 10

law run PreprocessRDFWrapper --version prod_241208b --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 1 --PreprocessRDF-retries 0 --workers 10