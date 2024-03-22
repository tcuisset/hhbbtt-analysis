###############################################################################################################################################
############################################################  PREPROCESS  #####################################################################
###############################################################################################################################################

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

# DONE
law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

###############################################################################################################################################
############################################################  PRECOUNTER  #####################################################################
###############################################################################################################################################

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-tags secondary,res \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run MergeCategorizationStatsWrapper --version prod_240305 --config-name ul_2018_ZttHbb_v12 \
 --dataset-tags secondary,res \
 --workers 30 --PreCounter-weights-file weights --systematic-names pu \
 --PreCounter-workflow htcondor --PreCounter-htcondor-scheduler llrt3condor.in2p3.fr --PreCounter-transfer-logs \
 --PreCounter-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  CATEGORIZATION  #################################################################
###############################################################################################################################################

###############################################################################################################################################
# ELLIPTICAL MASS CUT
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240312 --category-names base,ZbbHtt_elliptical_cut_90_sr --config-name ul_2018_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# RUNNING 
law run CategorizationWrapper --version prod_240312 --category-names base,ZttHbb_elliptical_cut_90_sr --config-name ul_2018_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection --Categorization-feature-modules-file modulesrdf_Ellipse --workers 30 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# DNN INPUT
###############################################################################################################################################

# DONE
law run CategorizationWrapper --version prod_240318 --category-names ZbbHtt_elliptical_cut_90_sr --config-name ul_2018_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# DONE
law run CategorizationWrapper --version prod_240318 --category-names ZttHbb_elliptical_cut_90_sr --config-name ul_2018_ZttHbb_v12 \
 --skip-dataset-tags secondary,res \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_DNN  --Categorization-keep-and-drop-file keep_and_drop_file_DNN --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
# CONTROL REGION ETAU, MUTAU, TAUTAU
###############################################################################################################################################

# RUNNING TMUX 3 AI
law run CategorizationWrapper --version prod_240318 --config-name ul_2018_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res --category-names ZbbHtt_elliptical_cut_90_CR_etau,ZbbHtt_elliptical_cut_90_CR_mutau,ZbbHtt_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7' \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

# RUNNING TMUX 4 AI
law run CategorizationWrapper --version prod_240318 --config-name ul_2018_ZttHbb_v12 \
 --skip-dataset-tags secondary,res --category-names ZttHbb_elliptical_cut_90_CR_etau,ZttHbb_elliptical_cut_90_CR_mutau,ZttHbb_elliptical_cut_90_CR_tautau \
 --PreprocessRDF-version prod_240305 \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7' \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_syst --workers 50 \
 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
 --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

###############################################################################################################################################
############################################################  PLOTTING  #######################################################################
###############################################################################################################################################

###############################################################################################################################################
# PLOT ELLIPTICAL MASS CUT
###############################################################################################################################################
 
# 
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2018_ZbbHtt_v12 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name base --config-name ul_2018_ZttHbb_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Hbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack

law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZbbHtt_elliptical_cut_90_sr --config-name ul_2018_ZbbHtt_v12 \
 --feature-names Htt_svfit_mass_ellipse:Zbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack
law run FeaturePlot2D --version prod_240318 --PrePlot2D-version prod_240318 --category-name ZttHbb_elliptical_cut_90_sr --config-name ul_2018_ZttHbb_v12 \
 --feature-names Ztt_svfit_mass_ellipse:Hbb_mass_ellipse --workers 30 --PrePlot2D-workflow local --MergeCategorizationStats-version prod_240305 \
 --Categorization-version prod_240312 --PrePlot2D-skip-merging \
 --skip-dataset-tags secondary,res \
 --process-group-name zh_sig_vs_bkg --save-root --save-png --stack
