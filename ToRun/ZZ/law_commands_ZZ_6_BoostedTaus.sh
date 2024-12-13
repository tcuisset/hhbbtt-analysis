# BoostedTaus third prod (systematics, hem veto, etc)
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
# systematics : jec_1 jer tes met_unclustered ele_scale ele_resolution

# pilots
law run PreprocessRDF --version prod_241210_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 

law run PreprocessRDF --version prod_241210_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 --systematic tes --systematic-direction up

law run PreprocessRDF --version prod_241212c --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --systematic jer --systematic-direction down --remove-output 0,a,True --workers 5


for syst in met_unclustered jec_1 jer tes ele_scale ele_resolution; do # 
for dir in up ; do # down
law run PreprocessRDF --version prod_241210_test11 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --systematic $syst --systematic-direction $dir --branch 0  >log-$syst-$dir.txt 2>&1  & # --branch $branch
done
done
law run PreprocessRDF --version prod_241212c --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file  --systematic jec_2 --systematic-direction up \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-retries 0 

# ,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11
law run PreprocessRDFWrapper --version prod_241212e --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-retries 0 --workers 30



### plotting pilot
law run PrePlot --version prod_241212e  --PreprocessRDF-version prod_241212e --skip-categorization --config-name bul_2018_ZZ_v12 \
  --category-name base --systematics jec_1,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso_HPSTaus,mutau_os_iso_HPSTaus,tautau_os_iso_HPSTaus,etau_os_iso_boostedTaus,mutau_os_iso_boostedTaus,tautau_os_iso_boostedTaus \
  --PrePlot-feature-tags baseObjects --PrePlot-preplot-modules-file preplot --workers 10 --remove-output 0,a,True


function featurePlotTest {
    REGION_NAME=$1
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241212e --FeatureHistogram-version prod_241212e --PrePlot-version prod_241212e  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
  law run FeaturePlotSyst --version prod_241212e --FeatureHistogram-version prod_241212e --PrePlot-version prod_241212e  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
}
featurePlotTest etau_os_iso_HPSTaus
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for region in etau_os_iso_HPSTaus,mutau_os_iso_HPSTaus,tautau_os_iso_HPSTaus,etau_os_iso_boostedTaus,mutau_os_iso_boostedTaus,tautau_os_iso_boostedTaus; do
 #etau_os mutau_os tautau_os etau_ss mutau_ss tautau_ss etau_os_iso etau_ss_iso etau_os_inviso etau_ss_inviso mutau_os_iso mutau_ss_iso mutau_os_inviso mutau_ss_inviso tautau_os_iso tautau_ss_iso tautau_os_inviso tautau_ss_inviso; do
featurePlotZZ $region  &
done
)


  law run FeaturePlotSyst --version prod_241210_test2 --FeatureHistogram-version prod_241210_test2 --PrePlot-version prod_241210_test2  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags base   \
  --process-group-name zz_res --stack --hide-data True --region-name etau_os \
  --PrePlot-preplot-modules-file preplot --save-png --remove-output 0,a

### Running systematics
law run PreprocessRDF --version prod_241207_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
 --branch 0 --systematic-name 


### testing condor
law run PreprocessRDFWrapper --version prod_241210_test_condor --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file_all \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-retries 0 --systematic-names jec_1,jec_2


################################### second plot
law run PreprocessRDFWrapper --version prod_241210_test3 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M5000,dy_2j --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 3 --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 0 \
 --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --workers 100

#testing

law run PreprocessRDF --version prod_241210_test3 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name dy_2j --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --systematic jec_1 --systematic-direction up --branch 0

law run PreprocessRDFWrapper --version prod_241210_test3 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_2j --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
 --PreprocessRDF-tasks-per-job 3 --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 --PreprocessRDF-retries 0 \
 --systematic-names jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --workers 100
