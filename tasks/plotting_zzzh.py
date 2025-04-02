import json
import law
import luigi
import itertools
from collections import OrderedDict
from copy import deepcopy as copy
import os
import numpy as np
import subprocess
from collections import defaultdict
from pathlib import Path

import matplotlib.pyplot as plt
import mplhep

from analysis_tools.utils import import_root, randomize, create_file_dir

from cmt.base_tasks.base import ConfigTaskWithCategory, ConfigTask, ConfigTaskWithRegion
from cmt.base_tasks.plotting import FeatureHistogram, FeatureHistogramWrapper, FeaturePlot

"""
law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 4
law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name plot \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 10
law run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZttHbb_v12 \
 --category-names ZttHbb_OC90_boosted_bb_boostedTau,ZttHbb_OC90_boosted_bb_HPSTau,ZttHbb_OC90_resolved_1b_HPSTau,ZttHbb_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name plot \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-propagate-syst-qcd False --FeatureHistogram-from-merge-preplot --workers 10


# ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau
# plots non res
for CATEGORY in ZZ_EC90_boosted_bb_boostedTau ZZ_EC90_boosted_bb_HPSTau ZZ_EC90_resolved_1b_HPSTau ZZ_EC90_resolved_2b_HPSTau; do
./submit_condor.sh \
$(which law) run FeatureHistogramWrapper --version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_250315 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names $CATEGORY --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeatureHistogram-feature-tags base,cat,dnn_nonres --FeatureHistogram-skip-dataset-tags nonDefault,resOnly,resSignal --FeatureHistogram-process-group-name zz \
  --FeatureHistogram-hide-data False --FeatureHistogram-do-qcd --FeatureHistogram-from-merge-preplot --workers 8
done



law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZZ_v12 \
 --category-names ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_resolved_1b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name zz \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name plot \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
law run FeaturePlotWrapper --version prod_250315 --FeatureHistogram-version prod_250315 --PrePlot-version prod_250315  --MergeCategorizationStats-version prod_241024 --config-name bul_${YEAR}_ZbbHtt_v12 \
 --category-names ZbbHtt_OC90_boosted_bb_boostedTau,ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau --region-names etau_os_iso,mutau_os_iso,tautau_os_iso \
 --FeaturePlot-feature-tags base,cat --FeaturePlot-skip-feature-tags blind --FeaturePlot-skip-dataset-tags resOnly,resSignal  --FeaturePlot-process-group-name plot \
 --FeaturePlot-do-qcd  --FeaturePlot-save-png --FeaturePlot-normalize-signals --FeaturePlot-stack --FeaturePlot-hide-data False \
   --workers 5
"""

class RunPlots(law.Task):
    """ 
    Plot mode : 
     - SR unblinded plots of base variables
     - SR DNN plots partially blinded, log & non-log (after rebinning)
     - QCD CR plots (if requested)
    """
    version = luigi.Parameter(description="version of outputs to produce")

    ZZ_categories = law.CSVParameter(default=("ZZ_EC90_boosted_bb_boostedTau","ZZ_EC90_boosted_bb_HPSTau","ZZ_EC90_resolved_2b_HPSTau","ZZ_EC90_resolved_1b_HPSTau"))
    ZbbHtt_categories = law.CSVParameter(default=("ZbbHtt_OC90_boosted_bb_boostedTau","ZbbHtt_OC90_boosted_bb_HPSTau","ZbbHtt_OC90_resolved_1b_HPSTau","ZbbHtt_OC90_resolved_2b_HPSTau"))
    ZttHbb_categories = law.CSVParameter(default=("ZttHbb_OC90_boosted_bb_boostedTau","ZttHbb_OC90_boosted_bb_HPSTau","ZttHbb_OC90_resolved_1b_HPSTau","ZttHbb_OC90_resolved_2b_HPSTau"))

    region_names = law.CSVParameter(default=("etau_os_iso", "mutau_os_iso", "tautau_os_iso"), description="names of regions")
    qcd_region_names = law.CSVParameter(default=tuple("etau_ss_iso,etau_os_inviso,etau_ss_inviso,mutau_ss_iso,mutau_os_inviso,mutau_ss_inviso,tautau_ss_iso,tautau_os_inviso,tautau_ss_inviso".split(",")), description="names of regions")

    do_ZZ = luigi.BoolParameter(default=True)
    do_ZbbHtt = luigi.BoolParameter(default=True)
    do_ZttHbb = luigi.BoolParameter(default=True)

    do_QCD_CR = luigi.BoolParameter(default=False)

    years = law.CSVParameter(default=("2018", "2017", "2016_HIPM", "2016"))

    mode = luigi.ChoiceParameter(choices=("cards", "plot"))

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
    
    def complete(self): return False
    
    def requires(self):
        r = {}
        for year in self.years:
            if self.do_ZZ:
                r[("ZZ", year)] = { 
                    (category_name, region_name) : FeatureHistogram.vreq(self, config_name=f"bul_{year}_ZZ_v12", category_name=category_name, region_name=region_name, skip_dataset_tags=["nonDefault", "resOnly","resSignal"], process_group_name=process_group_name,
                        feature_tags=["base", "cat", "dnn_nonres"], do_qcd=True, propagate_syst_qcd=False) 
                    for category_name in self.ZZ_categories
                    for region_name in self.region_names
                    for process_group_name in ["zz"]
                }
            if self.do_ZbbHtt:
                r[("ZbbHtt", year)] = { 
                    (category_name, region_name) : FeatureHistogram.vreq(self, config_name=f"bul_{year}_ZbbHtt_v12", category_name=category_name, region_name=region_name, skip_dataset_tags=["nonDefault", "resOnly","resSignal"], process_group_name=process_group_name,
                        feature_tags=["base", "cat", "dnn_nonres"], do_qcd=True, propagate_syst_qcd=False) 
                    for category_name in self.ZbbHtt_categories
                    for region_name in self.region_names
                    for process_group_name in ["plot"]
                }
            if self.do_ZttHbb:
                r[("ZttHbb", year)] = { 
                    (category_name, region_name) : FeatureHistogram.vreq(self, config_name=f"bul_{year}_ZttHbb_v12", category_name=category_name, region_name=region_name, skip_dataset_tags=["nonDefault", "resOnly","resSignal"], process_group_name=process_group_name,
                        feature_tags=["base", "cat", "dnn_nonres"], do_qcd=True, propagate_syst_qcd=False) 
                    for category_name in self.ZttHbb_categories
                    for region_name in self.region_names
                    for process_group_name in ["plot"]
                }
        return r

    def run(self):
        r = {}
        if self.do_ZZ:
            for year in self.years:
                config_name = f"bul_{year}_ZZ_v12"
                common_kwargs = dict(config_name=config_name,hide_data=False, stack=True, save_png=True, skip_dataset_tags=["nonDefault", "resOnly","resSignal"])
                def add_plot(tag, param_lambda=lambda **kwargs:dict(), **kwargs):
                    r.update({
                        ("ZZ", year, category_name, region_name, tag) : FeaturePlot.vreq(self, region_name=region_name,  category_name=category_name, **param_lambda(region_name=region_name, category_name=category_name), **(common_kwargs|kwargs))
                        for region_name in self.region_names
                        for category_name in self.ZZ_categories
                    })
                if self.mode == "plot":
                    add_plot("base_variables", feature_tags=["base", "cat"], skip_feature_tags=["blind"], process_group_name="zz", normalize_signals=True, do_qcd=True)
                    #  --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y 
                    add_plot("dnn", feature_tags=["dnn_nonres"], skip_feature_tags=["dnn_extra"], process_group_name="zz", normalize_signals=True, do_qcd=True, blinded=True, merge_bins=True, merge_bins_signal="zz_sl_signal", equal_bin_width=True, log_y=False)
                    def log_lambda(region_name, category_name):
                        if "resolved_1b" in category_name: return dict(histogram_minimum=1)
                        elif "resolved_2b" in category_name: return dict(histogram_minimum=0.1)
                        else: return dict()
                    add_plot("dnn_log", feature_tags=["dnn_nonres"], skip_feature_tags=["dnn_extra"], process_group_name="zz", normalize_signals=True, do_qcd=True, blinded=True, merge_bins=True, merge_bins_signal="zz_sl_signal", equal_bin_width=True, log_y=True)
                    # merge_bins_signal=self.merge_bins_signal_template.replace("__MASS__", str(mass))

                    if self.do_QCD_CR:
                        r.update({
                            ("ZZ", year, category_name, region_name, tag) : FeaturePlot.vreq(self, category_name=category_name, region_name=region_name, do_qcd=False, **(common_kwargs|kwargs))
                            for region_name in self.qcd_region_names
                            for category_name in self.ZZ_categories
                        })
        def do_all_ZH(tag, signal_name, categories):
            for year in self.years:
                config_name = f"bul_{year}_{tag}_v12"
                common_kwargs = dict(config_name=config_name,hide_data=False, stack=True, save_png=True, skip_dataset_tags=["nonDefault", "resOnly","resSignal"])
                def add_plot(tag, param_lambda=lambda **kwargs:dict(), **kwargs):
                    r.update({
                        (tag, year, category_name, region_name, tag) : FeaturePlot.vreq(self, region_name=region_name,  category_name=category_name, **param_lambda(region_name=region_name, category_name=category_name), **(common_kwargs|kwargs))
                        for region_name in self.region_names
                        for category_name in categories
                    })
                if self.mode == "plot":
                    add_plot("base_variables", feature_tags=["base", "cat"], skip_feature_tags=["blind"], process_group_name="plot", normalize_signals=True, do_qcd=True)
                    #  --FeaturePlot-merge-bins  --FeaturePlot-hide-data False  --FeaturePlot-blinded --FeaturePlot-do-qcd --FeaturePlot-stack --FeaturePlot-normalize-signals --FeaturePlot-equal-bin-width --FeaturePlot-save-png --FeaturePlot-log-y 
                    dnn_opts = dict(feature_tags=["dnn_nonres"], skip_feature_tags=["dnn_extra"], process_group_name="plot", normalize_signals=True, do_qcd=True, blinded=True,
                        merge_bins=True, merge_bins_signal=signal_name, equal_bin_width=True)
                    add_plot("dnn", **dnn_opts, log_y=False)
                    def log_lambda(region_name, category_name):
                        if "resolved_1b" in category_name: return dict(histogram_minimum=1)
                        elif "resolved_2b" in category_name: return dict(histogram_minimum=0.1)
                        else: return dict()
                    add_plot("dnn_log", **dnn_opts, log_y=True, param_lambda=log_lambda)
                    # merge_bins_signal=self.merge_bins_signal_template.replace("__MASS__", str(mass))

                    if self.do_QCD_CR:
                        r.update({
                            (tag, year, category_name, region_name, tag) : FeaturePlot.vreq(self, category_name=category_name, region_name=region_name, do_qcd=False, **(common_kwargs|kwargs))
                            for region_name in self.qcd_region_names
                            for category_name in categories
                        })
        
        if self.do_ZbbHtt:
            do_all_ZH("ZbbHtt", "zh_zbb_htt_signal", self.ZbbHtt_categories)
        if self.do_ZttHbb:
            do_all_ZH("ZttHbb", "zh_ztt_hbb_signal", self.ZttHbb_categories)
        yield r
    