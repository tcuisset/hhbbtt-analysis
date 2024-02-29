# Run combine as part of law workflow, rather than separately


law run RunCombineCombination --version prod_240226 --config-name ul_2018_ZbbHtt_v10 --category-names ZbbHtt_elliptical_cut_90_etau,ZbbHtt_elliptical_cut_90_mutau,ZbbHtt_elliptical_cut_90_tautau  \
  --combine-install /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/CMSSW_11_3_4 --feature dnn_ZHbbtt_kl_1  --region-name os_iso \
  --CreateDatacards-version prod_240226  --CreateDatacards-process-group-name datacard_ZbbHtt \
  --FeaturePlot-version prod_240226_fixSystQcd \
  --CreateDatacards-do-qcd --CreateDatacards-hide-data True --CreateDatacards-process-group-name datacard_ZbbHtt --CreateDatacards-feature-names dnn_ZHbbtt_kl_1 \
  --workers 5



law run RunCombineCombination --version prod_240226 --config-name ul_2018_ZttHbb_v10 --category-names ZttHbb_elliptical_cut_90_etau,ZttHbb_elliptical_cut_90_mutau,ZttHbb_elliptical_cut_90_tautau  \
  --combine-install /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/CMSSW_11_3_4 --feature dnn_ZHbbtt_kl_1  --region-name os_iso \
  --CreateDatacards-version prod_240226  --CreateDatacards-process-group-name datacard_ZttHbb \
  --FeaturePlot-version prod_240226_fixSystQcd \
  --CreateDatacards-do-qcd --CreateDatacards-hide-data True --CreateDatacards-process-group-name datacard_ZttHbb --CreateDatacards-feature-names dnn_ZHbbtt_kl_1 \
  --workers 5