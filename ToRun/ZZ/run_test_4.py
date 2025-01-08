
import luigi
from luigi import scheduler, rpc, worker
from luigi.cmdline_parser import CmdlineParser
from pathlib import Path
import math

from cmt.base_tasks.preprocessing import (
    Categorization, MergeCategorization, DNNInference, JoinDNNInference
)

from config.bul_2018_ZZ_v12 import config
# from cmt.base_tasks.plotting import (
    
# )

# for Categorization status
# law run CategorizationWrapper --version prod_241023g --config-name bul_2018_ZZ_v12 \
#  --dataset-names tt_sl,tt_dl,tt_fh,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,GluGluToXToZZTo2B2Tau_M200,GluGluToXToZZTo2B2Tau_M1000,GluGluToXToZZTo2B2Tau_M2000,GluGluToXToZZTo2B2Tau_M3000,GluGluToXToZZTo2B2Tau_M4000,GluGluToXToZZTo2B2Tau_M5000 --Categorization-base-category-name base \
#  --category-names ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau  \
#   --Categorization-feature-modules-file modulesrdf_cat \
#   --workers 20 --Categorization-workflow htcondor --Categorization-htcondor-scheduler llrt3condor.in2p3.fr --Categorization-transfer-logs \
#  --Categorization-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7' \
#  --Categorization-tasks-per-job 5

local_cpus = 20

class MyWorkerSchedulerFactory:

    def create_local_scheduler(self):
        return scheduler.Scheduler(prune_on_get_work=True, record_task_history=False, resources=dict(local_cpus=local_cpus))

    def create_remote_scheduler(self, url):
        return rpc.RemoteScheduler(url)

    def create_worker(self, scheduler, worker_processes, assistant=False):
        return worker.Worker(
            scheduler=scheduler, worker_processes=worker_processes, assistant=assistant)


def check_cat_size(dataset_name, category_name):
    p = Path("/grid_mnt/data__data.polcms/cms/cuisset/cmt/Categorization") / config.name / dataset_name / ("cat_"+category_name) / "prod_241023g"
    size = 0
    file_count = 0
    for f in p.iterdir():
        if f.is_file():
            file_count += 1
            size += f.stat().st_size
    return file_count, size



condor_settings = {
    "workflow" : "htcondor",
    "custom_condor_tag" : 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7',
    "htcondor_scheduler" : "llrt3condor.in2p3.fr",
    "transfer_logs" : True,
    "poll_interval" : 2,
    "submission_threads" : 1,
    "retries" : 1
}

version = "prod_241119"

cmdline_args = [ "Categorization", 
                "--PreprocessRDF-version", "prod_241023g", 
                "--Categorization-version", version, 
                "--DNNInference-version", version, 
                "--JoinDNNInference-version", version, 
                "--JoinDNNInference-base-category-name", "base",
                "--JoinDNNInference-feature-modules-file", "modulesrdf_cat"
                ]
to_run = []
with CmdlineParser.global_instance(cmdline_args) as cp:
    for dataset in config.datasets:
        # if dataset.name != "ttzz":
        #     continue
        for category_name in "ZZ_EC90_resolved_1b_boostedTau,ZZ_EC90_resolved_2b_boostedTau,ZZ_EC90_boosted_bb_boostedTau,ZZ_EC90_resolved_1b_HPSTau,ZZ_EC90_resolved_2b_HPSTau,ZZ_EC90_boosted_bb_HPSTau".split(","):
            file_count, size = check_cat_size(dataset.name, category_name)
            
            
            ratio = file_count / size * 5e7
            print_str = f"dataset {dataset.name } - cat {category_name} file_count {file_count} size {size/1e6}MB  -- ratio {ratio} --"
            if size > 5e6 or ( size > 1e6 and file_count > 5 ) or (size > 1e5 and file_count > 10) or (file_count > 15): # size is in bytes
                print_str += " Categorization on condor "
                
                workflow_settings = condor_settings | {"tasks_per_job" : min(max(math.floor(ratio), 1), 50)}
            else:
                workflow_settings = {"workflow" : "local"}
                print_str += " Categorization local "

            # workflow_settings = {"workflow" : "local"}

            to_run.append(Categorization(
                version=version,
                config_name=config.name,
                base_category_name="base",
                category_name=category_name,
                dataset_name=dataset.name,

                feature_modules_file="modulesrdf_cat",
                
                **workflow_settings
            ))

            if size > 1e7 or ( size > 5e6 and file_count > 5 ) or (size > 5e5 and file_count > 10) or file_count > 20:
                print_str += " -- DNN on condor"
                workflow_settings = condor_settings | {"tasks_per_job" : min(max(math.floor(ratio), 1), 70)}
            else:
                workflow_settings = {"workflow" : "local"}
                print_str += " -- DNN local"
            print(print_str)

            to_run.append(DNNInference(
                version=version,
                config_name=config.name,
                base_category_name="base",
                category_name=category_name,
                dataset_name=dataset.name,

                feature_modules_file="modulesrdf_cat",

                
                **workflow_settings
            ))

            to_run.append(JoinDNNInference(
                version=version,
                config_name=config.name,
                base_category_name="base",
                category_name=category_name,
                dataset_name=dataset.name,

                feature_modules_file="modulesrdf_cat",

                
                **workflow_settings
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


    luigi.build(to_run,
        workers=150,
        worker_scheduler_factory=MyWorkerSchedulerFactory()
    )

