
import luigi
from luigi import scheduler, rpc, worker
from luigi.cmdline_parser import CmdlineParser
from pathlib import Path
import math, itertools
import statistics

from cmt.base_tasks.preprocessing import (
    Categorization, MergeCategorization, DNNInference, JoinDNNInference
)



# for Categorization status
# law run CategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
#  --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
#  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
#   --Categorization-feature-modules-file modulesrdf_cat \
#   --workers 20 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
#  --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
#  --Categorization-tasks-per-job 5

local_cpus = 15
condor_priority = 0
dry_run = True
no_poll = False

condor_settings = {
    "workflow" : "htcondor",
    "htcondor_scheduler" : "llrt3condor.in2p3.fr",
    "transfer_logs" : True,
    "poll_interval" : 5,
    "submission_threads" : 1,
    "retries" : 0,
    "no_poll" : no_poll,
}

#from config.bul_2018_ZZ_v12 import config
from config.bul_2018_ZbbHtt_v12 import config
version = "prod_241213c_DNN25"
version_preprocess = "prod_241213c"
version_categorization = version
version_DNN = version
run_categorization = False

# central
systematics = "jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution"
#systematics = "jec_1,jec_2,jec_3,jec_4,jec_5,jec_6,jec_7,jec_8,jec_9" #,jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution
#systematics = "jec_10,jec_11,jer,tes,met_unclustered,ele_scale,ele_resolution"
systematics = systematics.split(",")
syst_dirs = [("central", "central")] + list(itertools.product(systematics, ["up", "down"]))
print("Running systs : " + str(syst_dirs))

    # ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,
    # ,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau
    # ZZ_EC90_boosted_bb_boostedTau
    # ,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau
# ZZ_EC90_boosted_bb_boostedTau
#categories = "ZZ_EC90_boosted_bb_boostedTau".split(",")
#categories = "ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_boosted_bb_HPSTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau".split(",")
categories = "ZbbHtt_OC90_resolved_1b_HPSTau".split(",")
#categories = "ZbbHtt_OC90_boosted_bb_HPSTau,ZbbHtt_OC90_resolved_1b_HPSTau,ZbbHtt_OC90_resolved_2b_HPSTau,ZbbHtt_OC90_boosted_bb_boostedTau".split(",")

cmdline_args = [ "Categorization", 
                "--PreprocessRDF-version", version_preprocess, 
                "--PreprocessRDF-no-run",
                "--PreprocessRDF-category-name", "base_selection",
                "--Categorization-version", version_categorization, 
                "--DNNInference-version", version_DNN, 
                "--JoinDNNInference-version", version_DNN, 
                "--JoinDNNInference-feature-modules-file", "modulesrdf_cat",
                ]
if not run_categorization: cmdline_args.append("--Categorization-no-run")

class MyWorkerSchedulerFactory:
    def create_local_scheduler(self):
        return scheduler.Scheduler(prune_on_get_work=True, record_task_history=False, resources=dict(local_cpus=local_cpus))

    def create_remote_scheduler(self, url):
        return rpc.RemoteScheduler(url)

    def create_worker(self, scheduler, worker_processes, assistant=False):
        return worker.Worker(
            scheduler=scheduler, worker_processes=worker_processes, assistant=assistant)

def check_preproc_size(dataset_name):
    p = Path("/grid_mnt/data__data.polcms/cms/cuisset/cmt/PreprocessRDF") / config.name / dataset_name / "cat_base_selection" / version_preprocess
    if not p.is_dir():
        print("COuld not find reference PreprocessRDF output in " + str(p))
        raise RuntimeError(p)
    size = 0
    file_count = 0
    for f in p.iterdir():
        if "_up_" in f.name or "_down_" in f.name: continue
        if f.is_file():
            file_count += 1
            size += f.stat().st_size
    return file_count, size

from cmt.base_tasks.base import get_n_files_after_merging
def check_cat_size(dataset, category_name):
    """ Compute nb of categorization file, total categorization file, max categorization file size """
    config_name = config.name
    #config_name = "bul_2018_ZZ_v12"
    category_name_forFiles = category_name
    #category_name_forFiles = "ZZ_EC90_boosted_bb_boostedTau" # TODO forcing category
    p = Path("/grid_mnt/data__data.polcms/cms/cuisset/cmt/Categorization") / config_name / dataset.name / ("cat_"+category_name_forFiles) / version_categorization#"prod_241023g"
    if not p.is_dir():
        print("COuld not find reference Categorization output in " + str(p))
        raise RuntimeError(p)
        #return 100, 5e7*100 # magic numbers
    sizes = []
    file_count = 0
    for f in p.iterdir():
        if "_up_" in f.name or "_down_" in f.name: continue
        if f.is_file():
            file_count += 1
            sizes.append(f.stat().st_size)
    file_count = get_n_files_after_merging(dataset, config.categories.get(category_name), dataset_key="categorization_merging", default=file_count)
    return file_count, sum(sizes)

def make_condor_tag(request_memory="1G", queue="short"):
    return f'include : /opt/exp_soft/cms/t3/t3queue |,T3queue={queue},WNTag=el9,priority={condor_priority},request_memory={request_memory},+SingularityCmd = "/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/el7_container"'


to_run = []
with CmdlineParser.global_instance(cmdline_args) as cp:

    for category_name in categories:
        for dataset in config.datasets:
            if dataset.has_tag("data"):
                continue
                if not dataset.has_tag("met"):
                    continue
            if dataset.has_tag("zh"): continue
            # if dataset.name != "GluGluToXToZZTo2B2Tau_M1300":
            #     continue
            #if dataset.name == "tth_bb" : continue

            preproc_file_count, preproc_total_size = check_preproc_size(dataset.name)
            try:
                file_count, size = check_cat_size(dataset, category_name)
            except RuntimeError as e:
                print("Could not find categorization info for " + str(e))
                file_count = get_n_files_after_merging(dataset, config.categories.get(category_name), dataset_key="categorization_merging", default=1)
                size = file_count * 1e7 # 10MB per file of categorization
            average_cat_size = size/file_count
            
            # determination of size of previous Categorization dataset to decide whether we should run on condor or locally
            ratio = 1e9 / average_cat_size # target is one job for 1GB of categorization output in one condor job
            print_str = f"dataset {dataset.name } - cat {category_name} file_count {file_count} avg_size {average_cat_size/1e6}MB total size {size/1e6}MB  -- ratio {ratio} --"
            if size > 5e6 or ( size > 1e6 and file_count > 5 ) or (size > 1e5 and file_count > 10) or (file_count > 15) or preproc_total_size>1e8: # size is in bytes
                print_str += " Categorization on condor "
                
                if ratio < file_count and ratio > 0.6*file_count:
                    print(f"Overriding ratio from {ratio} to {math.floor(file_count/2+1)}")
                    ratio = file_count/2+1
                workflow_settings = condor_settings | {"tasks_per_job" : min(max(math.floor(ratio), 1), 60)}
            else:
                workflow_settings = {"workflow" : "local"}
                print_str += " Categorization local "
            
            if size > 1e7 or ( size > 5e6 and file_count > 5 ) or (size > 5e5 and file_count > 10) or file_count > 20:
                print_str += f" -- DNN on condor {min(max(math.floor(ratio*1.3), 1), 70)} tasks-per-job"
                workflow_settings_DNN = condor_settings | {"tasks_per_job" : min(max(math.floor(ratio*5), 1), 70)} # one job=5GB of input, clamp to between 1 and 70 tasks per job
                workflow_no_vm = {"avoid_vms":False}
            else:
                workflow_settings_DNN = {"workflow" : "local"}
                print_str += " -- DNN local"
                workflow_no_vm = {}
            print(print_str)

            # workflow_settings = {"workflow" : "local"}

            for syst_name, syst_dir in syst_dirs:
                if dataset.has_tag("data") and syst_name != "central": continue
                # Categorization is better run using law run with everything on condor
                if run_categorization:
                    to_run.append(Categorization(
                        version=version,
                        config_name=config.name,
                        category_name=category_name,
                        dataset_name=dataset.name,
                        systematic=syst_name,
                        systematic_direction=syst_dir,

                        feature_modules_file="modulesrdf_cat",
                        
                        **workflow_settings,
                        **workflow_no_vm,
                        custom_condor_tag=make_condor_tag("1.5G" if (ratio < 20 and size < 1e8) else "2G" if size < 1e9 else "3G")
                    ))

                

                to_run.append(DNNInference(
                    version=version,
                    config_name=config.name,
                    category_name=category_name,
                    dataset_name=dataset.name,
                    systematic=syst_name,
                    systematic_direction=syst_dir,

                    feature_modules_file="modulesrdf_cat",

                    **workflow_settings_DNN, # cannot use VMs (inference problems with tensorflow)
                    custom_condor_tag=make_condor_tag("2G" if workflow_settings_DNN.get("tasks_per_job", 1)*average_cat_size < 1e8 else "4G")
                ))

                to_run.append(JoinDNNInference(
                    version=version,
                    config_name=config.name,
                    category_name=category_name,
                    dataset_name=dataset.name,
                    systematic=syst_name,
                    systematic_direction=syst_dir,

                    feature_modules_file="modulesrdf_cat",

                    **workflow_settings_DNN,
                    **workflow_no_vm,
                    custom_condor_tag=make_condor_tag("0.8G")
                ))

                # causes issues (ends up running JoinDNNInference in local, possibly at the same time as on condor)
                # to_run.append(MergeCategorization(
                #     version=version,
                #     config_name=config.name,
                #     #base_category_name="base",
                #     category_name=category_name,
                #     dataset_name=dataset.name,

                #     from_DNN_inference=True,
                # ))

    #print(to_run)
    if not dry_run:
        luigi.build(to_run,
            workers=10 if no_poll else 250,
            worker_scheduler_factory=MyWorkerSchedulerFactory()
        )

