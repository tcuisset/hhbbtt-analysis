
###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

YEAR=2018

law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_${YEAR}_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,\
GluGluToXToZZTo2B2Tau_M360_aux,GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,\
GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,\
GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,\
GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,\
GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,GluGluToXToZZTo2B2Tau_M3500_aux,\
GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --workers 50 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240312 --category-names base --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

law run CategorizationWrapper --version prod_240318 --category-names ZZ_elliptical_cut_90_sr --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

###############################################################################################################################################
# RESONANT ANALYSIS ETAU, MUTAU, TAUTAU
###############################################################################################################################################

law run CategorizationWrapper --version prod_240430 --config-name ul_${YEAR}_ZZ_v12 \
 --skip-dataset-tags secondary --category-names ZZ_elliptical_cut_90 \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst_resZZ --workers 20 --Categorization-tasks-per-job 1 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

