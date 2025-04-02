# https://indico.cern.ch/event/1466604/contributions/6174805/attachments/2948215/5182032/2024_10_15_B2G_JME_contact_report.pdf

# testing

law run FeaturePlot2D --version prod_250225_baseline_test2  --PreprocessRDF-version prod_250225 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot2D-skip-categorization --category-name base_selection --region-name baseline_hem_affected --dataset-names dy_ptz6  --feature-names jet_eta_hem:jet_phi_hem,jet_eta:jet_phi  \
  --process-group-name data_bkg --stack --hide-data False  \
  --PrePlot2D-preplot-modules-file preplot --store-systematics False --save-png --workers 20

# testing
function featurePlot_jetMap_test {
law run FeaturePlot2D --version prod_250225_baseline_test  --PreprocessRDF-version prod_250225 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run  --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot2D-skip-categorization --category-name base_selection  --region-name TO_CHANGE --dataset-names dy_ptz6 --skip-dataset-tags nonResOnly,res,data  --feature-names jet_eta_hem:jet_phi_hem,jet_eta:jet_phi  \
  --process-group-name data_bkg --stack --hide-data False  --store-systematics False \
  --PrePlot2D-preplot-modules-file preplot --save-png \
    --workers 10 "${@:1}"
}
featurePlot_jetMap_test --version prod_241207_baseline_noHEMweight_test --region-name baseline_region --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap_test --version prod_241207_baseline_HEMweight --region-name baseline_region 

featurePlot_jetMap_test --version prod_241207_baseline_hemAffected_noHEMweight --region-name baseline_hem_affected --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap_test --version prod_241207_baseline_HEMweight_test --region-name baseline_hem_affected 



# --skip-dataset-names ggZH_HToBB_ZToLL,tt_dl
# --PrePlot2D-weights-to-skip hem_weight
function featurePlot_jetMap {
law run FeaturePlot2D --version prod_250225_baseline_noHEMweight  --PreprocessRDF-version prod_250225 --PreprocessRDF-category-name base_selection --PreprocessRDF-no-run --MergeCategorizationStats-version prod_241024 --config-name bul_2018_ZZ_v12 \
 --PrePlot2D-skip-categorization --category-name base_selection  --region-name TO_CHANGE --skip-dataset-tags nonResOnly,res  --feature-names jet_eta_hem:jet_phi_hem,jet_eta:jet_phi  \
  --process-group-name data_bkg --stack --hide-data False --store-systematics False \
  --PrePlot2D-preplot-modules-file preplot --save-png \
  --PrePlot2D-workflow htcondor --PrePlot2D-htcondor-scheduler llrt3condor.in2p3.fr --PrePlot2D-tasks-per-job 30 --PrePlot2D-poll-interval 5 --PrePlot2D-retries 0 \
 --PrePlot2D-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,priority=10,request_memory=0.5G,T3queue=short,WNTag=el9,+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"' --workers 50 "${@:1}"
}

featurePlot_jetMap --version prod_250225_baseline_noHEMweight --region-name baseline_region --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap --version prod_250225_baseline_HEMweight --region-name baseline_region 

featurePlot_jetMap --version prod_250225_baseline_hemAffected_noHEMweight --region-name baseline_hem_affected --PrePlot2D-weights-to-skip hem_weight
featurePlot_jetMap --version prod_250225_baseline_HEMweight --region-name baseline_hem_affected 



--dataset-tags data --skip-dataset-tags NO_STR --skip-dataset-names data_etau_d