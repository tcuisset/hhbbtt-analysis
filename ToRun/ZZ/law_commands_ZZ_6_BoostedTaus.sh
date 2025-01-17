# BoostedTaus pilot for third prod (systematics, hem veto, etc)
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

# categories ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
# systematics : jec_1 jer tes met_unclustered ele_scale ele_resolution

# pilots




law run PreprocessRDF --version prod_241213_test1 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file  --systematic-variations jec_1,up --branch 0

# ,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11
# valgrind --tool=massif 
law run PreprocessRDFWrapper --version prod_241213_test3 --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution --split-syst-group 4 --workers 10

law run PreprocessRDFWrapper --version prod_241213c --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names central,jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs --PreprocessRDF-poll-interval 3 --PreprocessRDF-submission-threads 1 \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el9,request_memory=2G,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' \
  --PreprocessRDF-retries 0 --split-syst-group 6 --workers 10


law run PreprocessRDFWrapper --version prod_241213c --category-name base --config-name bul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M1000 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --systematic-names ele_scale,ele_resolution --split-syst-group 4 --workers 20


### plotting pilot
law run PrePlot --version prod_241213c  --PreprocessRDF-version prod_241213c --skip-categorization --config-name bul_2018_ZZ_v12 \
  --category-name base --systematics  jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution \
  --dataset-name GluGluToXToZZTo2B2Tau_M1000  \
  --PrePlot-region-names etau_os_iso_HPSTaus,mutau_os_iso_HPSTaus,tautau_os_iso_HPSTaus,etau_os_iso_boostedTaus,mutau_os_iso_boostedTaus,tautau_os_iso_boostedTaus \
  --PrePlot-feature-tags baseObjects --PrePlot-preplot-modules-file preplot --workers 10 --remove-output 0,a,True


function featurePlotTest {
    REGION_NAME=$1
  # --skip-dataset-tags genfilter,met,resExtra 
    law run FeaturePlot --version prod_241213c --FeatureHistogram-version prod_241213c --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
  law run FeaturePlotSyst --version prod_241213c --FeatureHistogram-version prod_241213c --PrePlot-version prod_241213c  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot-skip-categorization --category-name base --dataset-names GluGluToXToZZTo2B2Tau_M1000  --feature-tags baseObjects   \
  --process-group-name zz_res --stack --hide-data True --region-name ${REGION_NAME} \
  --PrePlot-preplot-modules-file preplot --save-png  "${@:2}"
}
#featurePlotTest etau_os_iso_HPSTaus
# declare -a logCommands=("--FeaturePlot-multiply-signals-normalization 100." "--FeaturePlot-log-y True --FeaturePlot-histogram-minimum 0.1")
# for logParams in "${logCommands[@]}"; do
(for region in etau_os_iso_HPSTaus mutau_os_iso_HPSTaus tautau_os_iso_HPSTaus etau_os_iso_boostedTaus mutau_os_iso_boostedTaus tautau_os_iso_boostedTaus; do
 #etau_os mutau_os tautau_os etau_ss mutau_ss tautau_ss etau_os_iso etau_ss_iso etau_os_inviso etau_ss_inviso mutau_os_iso mutau_ss_iso mutau_os_inviso mutau_ss_inviso tautau_os_iso tautau_ss_iso tautau_os_inviso tautau_ss_inviso; do
featurePlotTest $region  &
done
)




############################# CATEGORIZATION
law run Categorization --version prod_241213c_test1 --config-name bul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M1000 --Categorization-feature-modules-file modulesrdf_cat --PreprocessRDF-category-name base  \
 --category-name ZZ_EC90_boosted_bb_boostedTau \
  --print-status 1


