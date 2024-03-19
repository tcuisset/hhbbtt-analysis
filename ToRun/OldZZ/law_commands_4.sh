# To test systematcis

law run FeaturePlot --version prod_230822_NewDNNScore_1 --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_new_zzbbtt_kl_1,ZZ_svfit_mass --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --PrePlot-preplot-modules-file tes_syst (--do-qcd) (--stack) (--log-y)

# When I will create the datacard, I cannot have the samples grouped into "others", so I need to have two versions of the feature plot

# Test prepocess with merge producers for ZZ and HH
# law run PreprocessRDFWrapper --version test_230823 --category-names debug --config-name ul_2018_ZZ_v10 \
#     --dataset-names zz_sl_signal \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_ZZ --workers 20 --PreprocessRDF-workflow htcondor \
#     --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
#     --PreprocessRDF-transfer-logs

law run PreprocessRDF --version test_230823 --category-name debug --config-name ul_2018_ZZ_v10 --dataset-name zz_sl_signal \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_ZZ --branch 0

law run CategorizationWrapper --version prod_230803 --category-names ZZ_elliptical_cut_80_tautau --config-name ul_2018_ZZ_v10 \
 --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,st_antitop,st_top,st_tw_antitop,st_tw_top,data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --Categorization-base-category-name base_selection \
 --workers 50 --PreprocessRDF-version prod_230718 --Categorization-feature-modules-file modulesrdf_DNN_New

law run FeaturePlot --version prod_230803_NewDNNScore --PrePlot-skip-merging --config-name ul_2018_ZZ_v10 \
 --feature-names dnn_zzbbtt_kl_1,dnn_new_zzbbtt_kl_1,ZZ_svfit_mass --workers 20 \
 --MergeCategorizationStats-version prod_230718 --Categorization-version prod_230803 \
 --dataset-names zz_sl_signal,dy,tt_dl,tt_sl,tt_fh,wjets,tth_bb,tth_tautau,tth_nonbb,ggf_sm,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,st_antitop,st_top,st_tw_antitop,st_tw_top,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
 --process-group-name zz_total_data --save-root --save-png --hide-data True \
 --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso --do-qcd (--stack) (--log-y)