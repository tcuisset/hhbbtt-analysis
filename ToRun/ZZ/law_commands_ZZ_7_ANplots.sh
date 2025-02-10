# BoostedTaus third prod (systematics, hem veto, etc)
cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018



## PNN
MASS=800
for CATEGORY_NAME in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_2b_HPSTau ZZ_EC90_resolved_1b_HPSTau; do
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_250117_AN_v1 --FeatureHistogramRebin-version prod_250117_datacards_v4 --FeatureHistogram-version prod_250117_datacards_v4 --config-name bul_${YEAR}_ZZ_v12  \
 --category-name $CATEGORY_NAME --region-name ${REGION_NAME}_os_iso --process-group-name datacard_zz_res_reduced \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip GluGluToXToZZTo2B2Tau_M${MASS} \
 --feature-names dnn_ZZbbtt_500bv_M${MASS} \
 --do-qcd --merge-bins --hide-data --stack --equal-bin-width --save-png --log-y --histogram-minimum 0.1 &
done
done



## KinFit
CATEGORY_NAME=ZZ_EC90_boosted_bb_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_250117_AN_v1 --FeatureHistogram-version prod_250117 --config-name bul_${YEAR}_ZZ_v12  \
 --category-name $CATEGORY_NAME --region-name ${REGION_NAME}_os_iso --process-group-name zz_res \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000 \
 --feature-names ZZ_svfit_mass_res_high \
 --do-qcd --FeaturePlot-hide-data True --FeatureHistogram-hide-data False --stack  --save-png --multiply-signals-normalization 0.01 --rebin-factor 3 &
done
# --log-y --histogram-minimum 0.01 

CATEGORY_NAME=ZZ_EC90_boosted_bb_HPSTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_250117_AN_v1 --FeatureHistogram-version prod_250117 --config-name bul_${YEAR}_ZZ_v12  \
 --category-name $CATEGORY_NAME --region-name ${REGION_NAME}_os_iso --process-group-name zz_res \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip GluGluToXToZZTo2B2Tau_M600,GluGluToXToZZTo2B2Tau_M800,GluGluToXToZZTo2B2Tau_M1000 \
 --feature-names ZZ_svfit_mass \
 --do-qcd --FeaturePlot-hide-data True --FeatureHistogram-hide-data False --stack  --save-png --multiply-signals-normalization 0.05 --rebin-factor 3 &
done



CATEGORY_NAME=ZbbHtt_OC90_boosted_bb_boostedTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_250117_AN_v1 --FeatureHistogram-version prod_250117 --config-name bul_${YEAR}_ZbbHtt_v12  \
 --category-name $CATEGORY_NAME --region-name ${REGION_NAME}_os_iso --process-group-name plot_res \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip ZprimeToZH_ZToBB_HToTauTau_M500,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M4000 \
 --feature-names ZZ_svfit_mass_res_high \
 --do-qcd --FeaturePlot-hide-data True --FeatureHistogram-hide-data False --stack  --save-png --multiply-signals-normalization 0.01 --rebin-factor 3 &
done
# --log-y --histogram-minimum 0.01 

CATEGORY_NAME=ZbbHtt_OC90_boosted_bb_HPSTau
for REGION_NAME in etau mutau tautau; do
law run FeaturePlot --version prod_250117_AN_v1 --FeatureHistogram-version prod_250117 --config-name bul_${YEAR}_ZbbHtt_v12  \
 --category-name $CATEGORY_NAME --region-name ${REGION_NAME}_os_iso --process-group-name plot_res \
 --skip-dataset-tags nonResOnly,resSignal --dataset-names-after-skip ZprimeToZH_ZToBB_HToTauTau_M500,ZprimeToZH_ZToBB_HToTauTau_M1000,ZprimeToZH_ZToBB_HToTauTau_M2000,ZprimeToZH_ZToBB_HToTauTau_M3000,ZprimeToZH_ZToBB_HToTauTau_M4000 \
 --feature-names ZZ_svfit_mass \
 --do-qcd --FeaturePlot-hide-data True --FeatureHistogram-hide-data False --stack  --save-png --multiply-signals-normalization 0.05 --rebin-factor 3 &
done
