# BoostedTaus tests prod_240912_BT
YEAR=2018
# New definition of the elliptical mass cut !!!

###############################################################################################################################################
# COMMON STEP TO ALL THE ANALYES: 
###############################################################################################################################################
# --dataset-name zz_sl_signal_BT \
law run PreprocessRDFWrapper --version prod_240917_BT --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M5000_BT \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PreprocessRDF-tasks-per-job 5 --workers 1


 #--dataset-tags BT \
law run PreprocessRDFWrapper --version prod_241016_BT --category-names base --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_BT,GluGluToXToZZTo2B2Tau_M1000_BT,GluGluToXToZZTo2B2Tau_M3000_BT,GluGluToXToZZTo2B2Tau_M5000_BT \
 --PreprocessRDF-modules-file modulesrdf --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
  --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
 --PreprocessRDF-tasks-per-job 5 --workers 5

# pilot
law run PreprocessRDF --version prod_240922_BT --category-name base --config-name ul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M3000_BT --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0



law run PreprocessRDFWrapper --version prod_241017 --category-names base --config-name bul_2018_ZZ_v12 \
 --dataset-names dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 5 



################################ CATEGORIZATION
law run MergeCategorizationWrapper --version prod_240921_BT --config-name ul_2018_ZZ_v12 \
 --dataset-tags BT \
 --category-names ZZ_elliptical_cut_90_boosted  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --workers 10



law run MergeCategorizationWrapper --version prod_241017 --config-name ul_2018_ZZ_v12 \
 --dataset-names dy_ptz6 \
 --category-names ZZ_elliptical_cut_90_boosted  \
 --MergeCategorization-from-DNN-inference False --Categorization-feature-modules-file modulesrdf_cat \
 --workers 10

# --JoinDNNInference-base-category-name base_selection  --JoinDNNInference-feature-modules-file modulesrdf_cat 



################################ Plot

law run FeaturePlot --version prod_240917_BT --PrePlot-version prod_240917_BT --avoid-normalization  --config-name ul_2018_ZZ_v12 \
 --category-name ZZ_elliptical_cut_90_boosted --dataset-names GluGluToXToZZTo2B2Tau_M5000_BT --feature-tags base,cat  \
  --process-group-name zz_res --stack --hide-data True --workers 1

## testing

law run PreprocessRDF --version prod_240912_BT --category-name base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-name GluGluToXToZZTo2B2Tau_M5000_BT --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 1 --branch 0



#### Testing new CMSSW
export CMT_CMSSW_VERSION=CMSSW_14_0_15
source setup.sh
export CLING_DEBUG=1


