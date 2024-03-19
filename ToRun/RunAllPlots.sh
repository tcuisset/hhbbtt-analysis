#########################
# CONFIG 
#########################

config_name=$1

if [[ $config_name == "ul_2016_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c"
    datatautau="data_tau_a,data_tau_b,data_tau_c"
elif [[ $config_name == "ul_2016_HIPM_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e"
elif [[ $config_name == "ul_2017_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e"
elif [[ $config_name == "ul_2018_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d"
fi

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${dataetau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datamutau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1,ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datatautau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd \
 --PrePlot-workflow htcondor --PrePlot-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot-transfer-logs \
 --PrePlot-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

##########

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${dataetau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datamutau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --hide-data False
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names ZZKinFit_chi2,ZZKinFit_mass,ZZ_svfit_pt,ZZ_svfit_eta,ZZ_svfit_phi,ZZ_svfit_mass,Ztt_svfit_pt,Ztt_svfit_eta,Ztt_svfit_phi,Ztt_svfit_mass,\
Ztt_met_pt,Ztt_met_eta,Ztt_met_phi,Ztt_met_mass,Zbb_pt,Zbb_eta,Zbb_phi,Zbb_mass,lep1_pt,lep1_eta,lep1_phi,lep2_pt,lep2_eta,lep2_phi,bjet1_eta,bjet1_phi,bjet1_pt,bjet2_eta,bjet2_phi,bjet2_pt \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datatautau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --hide-data False

##########

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${dataetau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --stack --do-qcd --log-y
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datamutau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --stack --do-qcd --log-y
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datatautau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --stack --do-qcd --log-y

##########

law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${dataetau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_etau --region-name etau_os_iso \
 --save-yields --do-qcd
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datamutau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_mutau --region-name mutau_os_iso \
 --save-yields --do-qcd
law run FeaturePlot --version prod_240210 --PrePlot-skip-merging --PrePlot-version prod_240210 --config-name $config_name \
 --feature-names dnn_ZZbbtt_kl_1 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,wjets,dy,ewk_z,ewk_wplus,ewk_wminus,tt_dl,tt_sl,tt_fh,st_tw_antitop,st_tw_top,st_antitop,st_top,zz_dl,zz_fh,zz_lnu,zz_qnu,wz_lllnu,wz_lnuqq,wz_lnununu,wz_llqq,ww_llnunu,ww_lnuqq,ww_qqqq,zzz,wzz,www,wwz,ttw_lnu,ttw_qq,ttww,ttwz,ttwh,ttzh,ttz_llnunu,ttz_qq,ttzz,wminush_htt,wplush_htt,tth_bb,tth_tautau,ggH_ZZ,ggf_sm,"${datatautau}" \
 --workers 20 --MergeCategorizationStats-version prod_240128 --Categorization-version prod_240207 \
 --process-group-name zz --save-root --save-png --category-name ZZ_elliptical_cut_80_tautau --region-name tautau_os_iso \
 --save-yields --do-qcd
