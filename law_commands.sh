###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# PreprocessRDF total #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,tt_dl,tt_sl,wjets,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
#     --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF total v2 (didn't work and received mail about AFS occupancy)
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --skip-dataset-tags secondary --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h \
#     --PreprocessRDF-htcondor-scheduler bigbird12.cern.ch

# PreprocessRDF dy #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --dataset-names dy --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF tth #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --dataset-names tth_bb,tth_tautau,tth_nonbb --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF single top #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --dataset-names st_tw_antitop,st_tw_top,st_antitop,st_top --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF di-boson #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_v10 \
#     --dataset-names zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,zzz --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

# Be careful cause the version name is different
law run PreCounterWrapper --version prod_230503 --config-name ul_2018_v10 --dataset-tags secondary \
    --PreCounter-weights-file weights --PreCounter-max-runtime 1h --workers 20 --PreCounter-workflow htcondor

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

law run CategorizationWrapper --version prod_0503 --category-names mutau --config-name ul_2018_v10 \
    --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,tt_dl,tt_sl,dy_high,wjets,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
    --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

law run MergeCategorizationStatsWrapper --version prod_0503 --PreCounter-version prod_230503 --config-name ul_2018_v10 --dataset-tags secondary --workers 10