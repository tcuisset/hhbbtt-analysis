###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# New input ntuples containing the ZZ variables instead of HH
# PreprocessRDF for testing
law run PreprocessRDF --version prod_0621 --category-name base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-name zz_sl_signal --workflow local --modules-file modulesrdf_ZZ --workers 20 \
    --keep-and-drop-file keep_and_drop_file_test --branch 0
# flatten dnn missing input
law run PreprocessRDF --version prod_0623_test --category-name debug --config-name ul_2018_ZZ_v10 \
    --dataset-name zz_sl_signal --workflow local --modules-file modulesrdf_DNN --workers 20 \
    --keep-and-drop-file keep_and_drop_file_test --branch 0

# [FIXME] : find a way to handle initialization of 91/125 here
# /afs/cern.ch/work/e/evernazz/FrameworkNanoAOD/TestConfig/hhbbtt-analysis/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HHKinFit2/HHKinFit2Scenarios/interface/HHKinFitMasterHeavyHiggs.h

# compile with 125 and run
law run PreprocessRDFWrapper --version prod_0622_HH125 --category-names base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-names zz_sl_signal \
    --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf_HH --workers 20 \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h
# compile with 91 and run
law run PreprocessRDFWrapper --version prod_0622_ZZ91 --category-names base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-names zz_sl_signal,tt_sl \
    --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf_ZZ --workers 20 \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# Produce ntuples for DNN training
law run PreprocessRDFWrapper --version prod_0623_DNN --category-names base_selection --config-name ul_2018_ZZ_v10 \
    --dataset-names zz_sl_signal,tt_sl \
    --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf_DNN --workers 20 \
    --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# I cannot reprocess everything cause I don't have enough space on the cernbox: so I will add the features at the preplotting step
# The problem is that the features for ZZ are actually used for the elliptical cut, but myabe I can just add the same variable twice with two different names
# Here, before applying the DNN, I'm computing the new ZZ vairables and adding them to the tree: I will use the new ZZ variables as input to the DNN

law run PrePlot --version prod_0629 --skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
    --feature-names dnn_zzbbtt_kl_1 --workers 20 --workflow local --Categorization-version prod_0503 --dataset-name zz_sl_signal \
    --preplot-modules-file modulesrdf_zzdnn

law run FeaturePlot --version prod_0630 --PrePlot-version prod_0630 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
    --feature-names dnn_zzbbtt_kl_1,dnn_hhbbtt_kl_1,HHKinFit_mass,ZZKinFit_mass,HHKinFit_chi2,ZZKinFit_chi2 --workers 20 --PrePlot-workflow htcondor --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
    --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,singlet \
    --process-group-name zz_total  --PrePlot-preplot-modules-file modulesrdf_zzdnn --save-root --save-png --stack --hide-data True