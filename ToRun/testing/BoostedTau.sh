############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

#  BOOSTED TAU TEST & DEBUG

# 1. V12 new triggers
# I need to test the new triggers implemented by Theo and check that they do not change too muche the analysis flow on V12 (reference)
law run PreprocessRDFWrapper --version prod_240619_A --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

# 2. V9 new triggers
# Appply the flow to V9, this shouldn't change anything (maybe issue with trigger bits)
law run PreprocessRDFWrapper --version prod_240619_B --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

# 3. V9 new triggers and boosted tau triggers
# Check how the boosted taus behave
law run PreprocessRDFWrapper --version prod_240619_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux \
 --PreprocessRDF-modules-file modulesrdfdev \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

# 2. V9 new triggers
# Appply the flow to V9, this shouldn't change anything (maybe issue with trigger bits)
law run PreprocessRDFWrapper --version prod_240619_B --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M2000_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

# 3. V9 JET TRIGGER
law run PreprocessRDFWrapper --version prod_240619_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M2000_aux \
 --PreprocessRDF-modules-file modulesrdfAK8Jet \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency

# 4. V9 SINGLETAU TRIGGER
law run PreprocessRDFWrapper --version prod_240619_D --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M2000_aux \
 --PreprocessRDF-modules-file modulesrdfSingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

# 1. V12
law run PreprocessRDFWrapper --version prod_240620_A --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200 \
 --PreprocessRDF-modules-file modulesrdfDiTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# 2. V9
law run PreprocessRDFWrapper --version prod_240620_A --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux \
 --PreprocessRDF-modules-file modulesrdfDiTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

law run FeaturePlot --version prod_240620_A --PrePlot-version prod_240620_A --config-name ul_2018_ZZ_v12 \
 --feature-names lep1_eta,lep2_eta,lep1_pt_NoSyst,lep2_pt_NoSyst --PreprocessRDF-version prod_240620_A \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M200_aux --category-name base_NoSyst \
 --workers 20 --MergeCategorizationStats-version prod_240305 --PrePlot-skip-merging \
 --process-group-name zz_test_aux --save-png --region-name os_iso --stack --hide-data True

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

# 1. V12 new triggers
law run PreprocessRDFWrapper --version prod_240620_A --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdfDiTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# 2. V9 new triggers
law run PreprocessRDFWrapper --version prod_240620_B --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfDiTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# 3. V9 new JET TRIGGER
law run PreprocessRDFWrapper --version prod_240620_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfAK8Jet \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# 3. V9 new SINGLETAU TRIGGER
law run PreprocessRDFWrapper --version prod_240620_D --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfSingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

##############################################################################################################################
# Re-do after removing trigger bits for CrossTau and DiTau triggers

# 3. V9 new JET TRIGGER
law run PreprocessRDFWrapper --version prod_240621_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfAK8Jet \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# 3. V9 new SINGLETAU TRIGGER
law run PreprocessRDFWrapper --version prod_240621_D --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfSingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

##############################################################################################################################
# Change Trigger Object Id from 6 to 1 for jets

# 3. V9 new JET TRIGGER
law run PreprocessRDFWrapper --version prod_240622_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdfAK8Jet \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

law run MergeCutFlowWrapper --version prod_240620_A --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 --workers 30

law run MergeCutFlowWrapper --version prod_240620_B --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux --workers 30

law run MergeCutFlowWrapper --version prod_240620_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux --workers 30

law run MergeCutFlowWrapper --version prod_240620_D --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux --workers 30

##############################################################################################################################
# Re-do after removing trigger bits for CrossTau and DiTau triggers

law run MergeCutFlowWrapper --version prod_240621_C --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux --workers 30

law run MergeCutFlowWrapper --version prod_240621_D --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux --workers 30

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

# cut flow split all

law run PreprocessRDFWrapper --version prod_240622_CutFlow --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

law run PreprocessRDFWrapper --version prod_240620_test1 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M500 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

law run PreprocessRDFWrapper --version prod_240620_test1 --category-names base_selection --config-name ul_2018_ZttHbb_v12 \
 --dataset-names ZprimeToZH_ZToTauTau_HToBB_M500 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 

law run PreprocessRDFWrapper --version prod_240622_CutFlow --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow_SingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-branch 0 --PreprocessRDF-compute-filter-efficiency 


# ZZbbtt
law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# ZbbHtt
law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M500,ZprimeToZH_ZToBB_HToTauTau_M600,ZprimeToZH_ZToBB_HToTauTau_M800,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M1200,\
ZprimeToZH_ZToBB_HToTauTau_M1400,ZprimeToZH_ZToBB_HToTauTau_M1600,ZprimeToZH_ZToBB_HToTauTau_M1800,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M2500,\
ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M3500,ZprimeToZH_ZToBB_HToTauTau_M4000,ZprimeToZH_ZToBB_HToTauTau_M4500,ZprimeToZH_ZToBB_HToTauTau_M5000 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# ZttHbb
law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZttHbb_v12 \
 --dataset-names ZprimeToZH_ZToTauTau_HToBB_M500,ZprimeToZH_ZToTauTau_HToBB_M600,ZprimeToZH_ZToTauTau_HToBB_M800,ZprimeToZH_ZToTauTau_HToBB_M1000,ZprimeToZH_ZToTauTau_HToBB_M1200,\
ZprimeToZH_ZToTauTau_HToBB_M1400,ZprimeToZH_ZToTauTau_HToBB_M1600,ZprimeToZH_ZToTauTau_HToBB_M1800,ZprimeToZH_ZToTauTau_HToBB_M2000,ZprimeToZH_ZToTauTau_HToBB_M2500,\
ZprimeToZH_ZToTauTau_HToBB_M3000,ZprimeToZH_ZToTauTau_HToBB_M3500,ZprimeToZH_ZToTauTau_HToBB_M4000,ZprimeToZH_ZToTauTau_HToBB_M4500,ZprimeToZH_ZToTauTau_HToBB_M5000 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

############################################################################################################################## 
############################################################################################################################## 
##############################################################################################################################

law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200_aux,GluGluToXToZZTo2B2Tau_M210_aux,GluGluToXToZZTo2B2Tau_M220_aux,GluGluToXToZZTo2B2Tau_M230_aux,GluGluToXToZZTo2B2Tau_M240_aux,GluGluToXToZZTo2B2Tau_M250_aux,\
GluGluToXToZZTo2B2Tau_M260_aux,GluGluToXToZZTo2B2Tau_M270_aux,GluGluToXToZZTo2B2Tau_M280_aux,GluGluToXToZZTo2B2Tau_M300_aux,GluGluToXToZZTo2B2Tau_M320_aux,GluGluToXToZZTo2B2Tau_M350_aux,GluGluToXToZZTo2B2Tau_M360_aux,\
GluGluToXToZZTo2B2Tau_M400_aux,GluGluToXToZZTo2B2Tau_M450_aux,GluGluToXToZZTo2B2Tau_M500_aux,GluGluToXToZZTo2B2Tau_M550_aux,GluGluToXToZZTo2B2Tau_M600_aux,GluGluToXToZZTo2B2Tau_M650_aux,GluGluToXToZZTo2B2Tau_M700_aux,\
GluGluToXToZZTo2B2Tau_M750_aux,GluGluToXToZZTo2B2Tau_M800_aux,GluGluToXToZZTo2B2Tau_M850_aux,GluGluToXToZZTo2B2Tau_M900_aux,GluGluToXToZZTo2B2Tau_M1000_aux,GluGluToXToZZTo2B2Tau_M1100_aux,GluGluToXToZZTo2B2Tau_M1200_aux,\
GluGluToXToZZTo2B2Tau_M1300_aux,GluGluToXToZZTo2B2Tau_M1400_aux,GluGluToXToZZTo2B2Tau_M1500_aux,GluGluToXToZZTo2B2Tau_M1600_aux,GluGluToXToZZTo2B2Tau_M1700_aux,GluGluToXToZZTo2B2Tau_M1800_aux,GluGluToXToZZTo2B2Tau_M1900_aux,\
GluGluToXToZZTo2B2Tau_M2000_aux,GluGluToXToZZTo2B2Tau_M2200_aux,GluGluToXToZZTo2B2Tau_M2400_aux,GluGluToXToZZTo2B2Tau_M2500_aux,GluGluToXToZZTo2B2Tau_M2600_aux,GluGluToXToZZTo2B2Tau_M2800_aux,GluGluToXToZZTo2B2Tau_M3000_aux,\
GluGluToXToZZTo2B2Tau_M3500_aux,GluGluToXToZZTo2B2Tau_M4000_aux,GluGluToXToZZTo2B2Tau_M4500_aux,GluGluToXToZZTo2B2Tau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow_SingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --dataset-names ZprimeToZH_ZToBB_HToTauTau_M500_aux,ZprimeToZH_ZToBB_HToTauTau_M600_aux,ZprimeToZH_ZToBB_HToTauTau_M800_aux,ZprimeToZH_ZToBB_HToTauTau_M1000_aux,ZprimeToZH_ZToBB_HToTauTau_M1200_aux,\
ZprimeToZH_ZToBB_HToTauTau_M1400_aux,ZprimeToZH_ZToBB_HToTauTau_M1600_aux,ZprimeToZH_ZToBB_HToTauTau_M1800_aux,ZprimeToZH_ZToBB_HToTauTau_M2000_aux,ZprimeToZH_ZToBB_HToTauTau_M2500_aux,\
ZprimeToZH_ZToBB_HToTauTau_M3000_aux,ZprimeToZH_ZToBB_HToTauTau_M3500_aux,ZprimeToZH_ZToBB_HToTauTau_M4000_aux,ZprimeToZH_ZToBB_HToTauTau_M4500_aux,ZprimeToZH_ZToBB_HToTauTau_M5000_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow_SingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZttHbb_v12 \
 --dataset-names ZprimeToZH_ZToTauTau_HToBB_M500_aux,ZprimeToZH_ZToTauTau_HToBB_M600_aux,ZprimeToZH_ZToTauTau_HToBB_M800_aux,ZprimeToZH_ZToTauTau_HToBB_M1000_aux,ZprimeToZH_ZToTauTau_HToBB_M1200_aux,\
ZprimeToZH_ZToTauTau_HToBB_M1400_aux,ZprimeToZH_ZToTauTau_HToBB_M1600_aux,ZprimeToZH_ZToTauTau_HToBB_M1800_aux,ZprimeToZH_ZToTauTau_HToBB_M2000_aux,ZprimeToZH_ZToTauTau_HToBB_M2500_aux,\
ZprimeToZH_ZToTauTau_HToBB_M3000_aux,ZprimeToZH_ZToTauTau_HToBB_M3500_aux,ZprimeToZH_ZToTauTau_HToBB_M4000_aux,ZprimeToZH_ZToTauTau_HToBB_M4500_aux,ZprimeToZH_ZToTauTau_HToBB_M5000_aux \
 --PreprocessRDF-modules-file modulesrdf_cutflow_SingleTau \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"

# prod_240621_CutFlow : skip_trigger was skipping offline selections of pt and eta of the two objects too
# prod_240622_CutFlow : new pass_trigger_split with options (always part of the workflow)
# prod_240623_CutFlow : new pass_trigger_split with options (part of the workflow only if we don't skip offline or trigger requirements)
# prod_240624_CutFlow : make sure we compiled before and same as prod_240623_CutFlow --> Correct!
# prod_240625_CutFlow : make sure we compiled before and same as prod_240622_CutFlow

# Test

law run PreprocessRDFWrapper --version prod_240624_CutFlow --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M210,GluGluToXToZZTo2B2Tau_M220,GluGluToXToZZTo2B2Tau_M230,GluGluToXToZZTo2B2Tau_M240,GluGluToXToZZTo2B2Tau_M250,\
GluGluToXToZZTo2B2Tau_M260,GluGluToXToZZTo2B2Tau_M270,GluGluToXToZZTo2B2Tau_M280,GluGluToXToZZTo2B2Tau_M300,GluGluToXToZZTo2B2Tau_M320,GluGluToXToZZTo2B2Tau_M350,GluGluToXToZZTo2B2Tau_M360,\
GluGluToXToZZTo2B2Tau_M400,GluGluToXToZZTo2B2Tau_M450,GluGluToXToZZTo2B2Tau_M500,GluGluToXToZZTo2B2Tau_M550,GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M650,GluGluToXToZZTo2B2Tau_M700,\
GluGluToXToZZTo2B2Tau_M750,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M850,GluGluToXToZZTo2B2Tau_M900,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M1100,GluGluToXToZZTo2B2Tau_M1200,\
GluGluToXToZZTo2B2Tau_M1300,GluGluToXToZZTo2B2Tau_M1400,GluGluToXToZZTo2B2Tau_M1500,GluGluToXToZZTo2B2Tau_M1600,GluGluToXToZZTo2B2Tau_M1700,GluGluToXToZZTo2B2Tau_M1800,GluGluToXToZZTo2B2Tau_M1900,\
GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M2200,GluGluToXToZZTo2B2Tau_M2400,GluGluToXToZZTo2B2Tau_M2500,GluGluToXToZZTo2B2Tau_M2600,GluGluToXToZZTo2B2Tau_M2800,GluGluToXToZZTo2B2Tau_M3000,\
GluGluToXToZZTo2B2Tau_M3500,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M4500,GluGluToXToZZTo2B2Tau_M5000 \
 --PreprocessRDF-modules-file modulesrdf_cutflow \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-compute-filter-efficiency --workers 20 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag "include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7"