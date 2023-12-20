###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

ul_2018_v10 -----> ul_2018_ZZ_v10

# PreprocessRDF total #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,tt_dl,tt_sl,wjets,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
#     --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF total v2 (didn't work and received mail about AFS occupancy)
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --skip-dataset-tags secondary --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h \
#     --PreprocessRDF-htcondor-scheduler bigbird12.cern.ch

# PreprocessRDF dy #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names dy --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF tth #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names tth_bb,tth_tautau,tth_nonbb --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF single top #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names st_tw_antitop,st_tw_top,st_antitop,st_top --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# PreprocessRDF di-boson #DONE
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names zz_dl,zz_sl,zz_fh,zz_lnu,zz_qnu,zzz --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

# I have to re-run the pre-processign (in order to have the new zz_sl_signal and zz_sl_background folders) but the procedure is the same
# law run PreprocessRDFWrapper --version prod_0503 --category-names base_selection --config-name ul_2018_ZZ_v10 \
#     --dataset-names zz_dl,zz_fh,zz_lnu,zz_qnu,zzz,zz_sl_signal,zz_sl_background --PreprocessRDF-workflow htcondor --PreprocessRDF-modules-file modulesrdf --workers 20 \
#     --PreprocessRDF-keep-and-drop-file keep_and_drop_file_test --PreprocessRDF-transfer-logs --PreprocessRDF-max-runtime 24h

###############################################################################################################################################
###########################################################  PRECOUNTER  ######################################################################
###############################################################################################################################################

# Be careful cause the version name is different #DONE
# law run PreCounterWrapper --version prod_230503 --config-name ul_2018_ZZ_v10 --PreCounter-weights-file weights \
#  --PreCounter-max-runtime 1h --workers 20 --dataset-tags secondary --PreCounter-workflow local

# MergeCategorizationStatsWrapper #DONE
# law run MergeCategorizationStatsWrapper --version prod_0503 --PreCounter-version prod_230503 --config-name ul_2018_ZZ_v10 \
#  --dataset-tags secondary --workers 30 --PreCounter-weights-file weights

###############################################################################################################################################
##########################################################  CATEGORIZATION  ###################################################################
###############################################################################################################################################

# Categorization mutau #DONE
# law run CategorizationWrapper --version prod_0503 --category-names mutau --config-name ul_2018_ZZ_v10 \
#     --dataset-names data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,tt_dl,tt_sl,wjets,data_etau_a,data_etau_b,data_etau_c,data_etau_d \
#     --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

# Categorization total mutau #DONE
# law run CategorizationWrapper --version prod_0503 --category-names mutau --config-name ul_2018_ZZ_v10 \
#     --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection \
#     --skip-dataset-tags secondary  --Categorization-workflow htcondor
# when I launched it there were two root files absent from the preprocessing that were re-launched but without all the options so they create problem cause they miss some variables

# Categorization total etau #DONE
# law run CategorizationWrapper --version prod_0503 --category-names etau --config-name ul_2018_ZZ_v10 \
#     --skip-dataset-tags secondary \
#     --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

# Categorization total tautau #DONE
# law run CategorizationWrapper --version prod_0503 --category-names tautau --config-name ul_2018_ZZ_v10 \
#     --skip-dataset-tags secondary \
#     --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

# Categorization total inclusive category etau + mutau + tautau
# law run CategorizationWrapper --version prod_0503 --category-names base --config-name ul_2018_ZZ_v10 \
#     --skip-dataset-tags secondary \
#     --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

# Categorization total mutau with elliptical cut at 80% #DONE
# law run CategorizationWrapper --version prod_0616 --category-names elliptical_cut_80 --config-name ul_2018_ZZ_v10 --PreprocessRDF-version prod_0503 \
#     --skip-dataset-tags secondary \
#     --Categorization-workflow htcondor --workers 50 --Categorization-transfer-logs --Categorization-max-runtime 1h --Categorization-base-category-name base_selection

###############################################################################################################################################
#############################################################  PREPLOT  #######################################################################
###############################################################################################################################################

# law run PrePlot --version prod_0503 --skip-merging --category-name mutau --config-name ul_2018_v10 --region-name mutau_os_iso --dataset-name wjets \
#     --feature-names lep1_eta,lep1_pt,lep2_eta,lep2_pt,bjet1_eta,bjet1_pt,bjet2_eta,bjet2_pt --workers 20 --PrePlot-workflow local

# why do we need to specify the region name in the preplotting
# what's the difference between weights.yaml and the add_weights in the config file. Where does it eneter?

# PrePlot HH_mass (4-body mass) of all samples in mutau category for signal region (mutau_os_iso)
# law run PrePlot --version prod_0524 --skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names HH_mass --workers 20 --workflow local --Categorization-version prod_0503 \
#     --dataset-name ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,st_tw_antitop,st_tw_top,st_antitop,st_top,wjets,zz_sl_signal,zz_sl_background,zzz,zz_qnu,zz_lnu,zz_fh,zz_dl

###############################################################################################################################################
###########################################################  FEATURE PLOT  ####################################################################
###############################################################################################################################################

# ---------------------------------------------------- BASE SELECTIONS ----------------------------------------------------

##########################################################################################################
# FeaturePlot HH_mass (4-body mass) without QCD
# law run FeaturePlot --version prod_0524_1 --PrePlot-version prod_0524 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names HH_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,singlet \
#     --process-group-name zz_total_split --save-root --save-png --stack --hide-data True

# law run FeaturePlot --version prod_0524_1 --PrePlot-version prod_0524 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names HH_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True

##########################################################################################################
# mutau category for signal region (mutau_os_iso) : Hbb_mass vs Htt_mass
# law run PrePlot2D --version prod_0524 --skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_mass --workers 20 --workflow local --Categorization-version prod_0503 \
#     --dataset-name ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,st_tw_antitop,st_tw_top,st_antitop,st_top,wjets,zz_sl_signal,zz_sl_background,zzz,zz_qnu,zz_lnu,zz_fh,zz_dl

# law run FeaturePlot2D --version prod_0524 --PrePlot2D-version prod_0524 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True
# law run FeaturePlot2D --version prod_0524 --PrePlot2D-version prod_0524 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True
# law run FeaturePlot2D --version prod_0524 --PrePlot2D-version prod_0524 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True

##########################################################################################################
# mutau category for signal region (mutau_os_iso) : Hbb_mass vs Htt_svfit_mass
# law run PrePlot2D --version prod_0524_1 --skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_svfit_mass --workers 20 --workflow local --Categorization-version prod_0503 \
#     --dataset-name ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,st_tw_antitop,st_tw_top,st_antitop,st_top,wjets,zz_sl_signal,zz_sl_background,zzz,zz_qnu,zz_lnu,zz_fh,zz_dl

# law run FeaturePlot2D --version prod_0524_1 --PrePlot2D-version prod_0524_1 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_svfit_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True
# law run FeaturePlot2D --version prod_0524_1 --PrePlot2D-version prod_0524_1 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_svfit_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True
# law run FeaturePlot2D --version prod_0524_1 --PrePlot2D-version prod_0524_1 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_v10 \
#     --feature-names Hbb_mass:Htt_svfit_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True

# mutau category for signal region (mutau_os_iso) : Htt_svfit_mass vs Hbb_mass
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True --stack
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True --stack

# etau category for signal region (etau_os_iso) : Htt_svfit_mass vs Hbb_mass
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name etau_os_iso --category-name etau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True --stack
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name etau_os_iso --category-name etau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True --stack

# tautau category for signal region (tautau_os_iso) : Hbb_mass vs Htt_svfit_mass
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name tautau_os_iso --category-name tautau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True --stack
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --region-name tautau_os_iso --category-name tautau --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True --stack

# base category for signal region (base_os_iso) : Hbb_mass vs Htt_svfit_mass
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_background --save-root --save-png --hide-data True --stack
# law run FeaturePlot2D --version prod_0608 --PrePlot2D-version prod_0608 --PrePlot2D-skip-merging --category-name base --config-name ul_2018_ZZ_v10 \
#     --feature-names Htt_svfit_mass:Hbb_mass --workers 20 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal \
#     --process-group-name zz_signal --save-root --save-png --hide-data True --stack


# ----------------------------------------------------------------- ELLIPTICAL SELECTION -----------------------------------------------------------------

# FeaturePlot HH_mass (4-body mass) without QCD
# version prod_0601 with elliptical cut
# law run FeaturePlot --version prod_0601 --PrePlot-version prod_0601 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,singlet \
#     --process-group-name zz_total_split  --preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True

# law run FeaturePlot --version prod_0601 --PrePlot-version prod_0601 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True

# # version prod_0602 without elliptical cut
# law run FeaturePlot --version prod_0602 --PrePlot-version prod_0602 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True

# mutau category for signal region (mutau_os_iso, mutau_os_inviso, mutau_ss_iso, mutau_ss_inviso) : HH_mass
# law run FeaturePlot --version prod_0608 --PrePlot-version prod_0608 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png (--stack)
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png (--stack)
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name mutau_os_inviso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack (--hide-data False)
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name mutau_ss_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack (--hide-data False)
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name mutau_ss_inviso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack (--hide-data False)
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack --do-qcd

# # etau category for signal region (etau_os_iso) : HH_mass
# law run FeaturePlot --version prod_0608 --PrePlot-version prod_0608 --PrePlot-skip-merging --region-name etau_os_iso --category-name etau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name etau_os_iso --category-name etau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True

# # tautau category for signal region (tautau_os_iso) : HH_mass
# law run FeaturePlot --version prod_0608 --PrePlot-version prod_0608 --PrePlot-skip-merging --region-name tautau_os_iso --category-name tautau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True
# law run FeaturePlot --version prod_0608_Ellipse --PrePlot-version prod_0608_Ellipse --PrePlot-preplot-modules-file modulesrdf_ellipse \
#     --PrePlot-skip-merging --region-name tautau_os_iso --category-name tautau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet \
#     --process-group-name zz_total --save-root --save-png --stack --hide-data True

######################################################################################################
# The elliptical selection was wrongly optimized: 15/6 correct optimization for efficiency 80% and 90%
# mutau(also etau,tautau) category : HH_mass,HH_eta,HH_phi,HH_pt
# law run FeaturePlot --version prod_0615 --PrePlot-version prod_0615 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack --hide-data True (--do-qcd)

# law run FeaturePlot --version prod_0615_Ellipse80 --PrePlot-version prod_0615_Ellipse80 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --PrePlot-preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True (--do-qcd)

# law run FeaturePlot --version prod_0615_Ellipse90 --PrePlot-version prod_0615_Ellipse90 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names HH_mass,HH_eta,HH_phi,HH_pt --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --PrePlot-preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True (--do-qcd)

######################################################################################################
# mutau category : add angular variables and pt balance
# law run FeaturePlot --version prod_0616 --PrePlot-version prod_0616 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names ZZ_pt_balance,ZZ_deta,ZZ_dphi,ZZ_dR --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --save-root --save-png --stack --hide-data True

# law run FeaturePlot --version prod_0616_Ellipse80 --PrePlot-version prod_0616_Ellipse80 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names ZZ_pt_balance,ZZ_deta,ZZ_dphi,ZZ_dR --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --PrePlot-preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True

# law run FeaturePlot --version prod_0616_Ellipse90 --PrePlot-version prod_0616_Ellipse90 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
#     --feature-names ZZ_pt_balance,ZZ_deta,ZZ_dphi,ZZ_dR --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
#     --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,dy,wjets,singlet,data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d \
#     --process-group-name zz_total_data --PrePlot-preplot-modules-file modulesrdf_ellipse --save-root --save-png --stack --hide-data True

######################################################################################################
# adding ZZDNN module
law run PrePlot --version prod_0613 --skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
    --feature-names dnn_zzbbtt_kl_1 --workers 20 --workflow local --Categorization-version prod_0503 --dataset-name zz_sl_signal \
    --preplot-modules-file modulesrdf_zzdnn

law run FeaturePlot --version prod_0613 --PrePlot-version prod_0613 --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
    --feature-names dnn_zzbbtt_kl_1,dnn_hhbbtt_kl_1 --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
    --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,singlet \
    --process-group-name zz_total  --PrePlot-preplot-modules-file modulesrdf_zzdnn --save-root --save-png --stack --hide-data True

law run FeaturePlot --version prod_0613A --PrePlot-version prod_0613A --PrePlot-skip-merging --region-name mutau_os_iso --category-name mutau --config-name ul_2018_ZZ_v10 \
    --feature-names HHKinFit_mass --workers 20 --PrePlot-workflow local --MergeCategorizationStats-version prod_0503 --Categorization-version prod_0503 \
    --dataset-names zz_sl_signal,zz_sl_background,zz_qnu,zz_lnu,zz_dl,zz_fh,zzz,ggf_sm,dy,tt_dl,tt_sl,tt_fh,tth_bb,tth_tautau,tth_nonbb,wjets,singlet \
    --process-group-name zz_total  --PrePlot-preplot-modules-file modulesrdf_zzdnn --save-root --save-png --stack --hide-data True
