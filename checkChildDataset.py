#!/usr/bin/env python3
from subprocess import run
import os
from pathlib import Path
import requests
import yaml
import json
import argparse
import importlib
import sys
import csv
import functools

from analysis_tools import Dataset

def loadFileFromGithub(user, repo_name, branch, path_to_file):
    res = requests.get(f'https://raw.githubusercontent.com/{user}/{repo_name}/{branch}/{path_to_file}')
    if res.status_code == requests.codes.ok:
        return res.text
    else:
        raise RuntimeError("Could not access " + f'https://raw.githubusercontent.com/{user}/{repo_name}/{branch}/{path_to_file}\nReturned : {res.text}')
    

def getTempHTTPath(runYear):
    return Path(os.environ["CMT_TMP_DIR"]) / "HTT-reprocess-config" / f"{runYear}.pkl"

def downloadHTTConfigs(runYear):
    out = getTempHTTPath(runYear)
    complete = {}
    for filename in ["data.yaml","Dihiggs.yaml","Higgs_CP.yaml","nmssm.yaml","SingleTop.yaml","TTX.yaml","W.yaml","Diboson.yaml","DY.yaml","Higgs.yaml","QCD.yaml","Triboson.yaml","TT.yaml","Z.yaml"]:
        txt = loadFileFromGithub("cms-tau-pog", "NanoProd", "HTT_skim_v1", f"NanoProd/crab/Run2_{runYear}/" + filename)
        #print(txt)
        yaml_loaded = yaml.safe_load(txt)
        complete |= yaml_loaded
    del complete["config"]
    out.parent.mkdir(parents=True, exist_ok=True)
    with open(out, "w") as f:
        yaml.dump(complete, f)

@functools.cache
def readHTTConfigs(runYear):
    out = getTempHTTPath(runYear)
    with open(out, "r") as f:
        return yaml.safe_load(f)

def readOrMakeHTTConfigs(runYear):
    try:
        return readHTTConfigs(runYear)
    except FileNotFoundError:
        downloadHTTConfigs(runYear)
    return readHTTConfigs(runYear)

def findMiniAODFromHTTDataset(config, dataset:Dataset) -> str:
    """ Get MiniAOD dataset name that corresponds to the HTT-reprocessed NanoAODv12 given"""
    runYear = config.year
    if config.year == 2016 and config.x.get("ispreVFP", False):
        runYear = "2016_HIPM"
    return readOrMakeHTTConfigs(runYear)[dataset.folder.split("/")[-1]]

def findChildrenOfDataset(dataset_name:str) -> str:
    command = f"-query='child dataset={dataset_name}'"
    #print("dasgoclient " + command)
    das_res = run(" ".join(["dasgoclient", "-json", command]), check=True, capture_output=True, text=True, shell=True)
    json_res = json.loads(das_res.stdout)
    return [individ_res["child"][0]["child_dataset"] for individ_res in json_res]


def checkChildDatasets(config):
    errors = False
    for dataset in config.datasets:
        #print(dataset)
        if dataset.folder is not None and dataset.folder.startswith("/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_") and not dataset.name.startswith("data"): # HTT reprocess skim
            # find corresponding cmsdas dataset (miniaod)
            miniaod = findMiniAODFromHTTDataset(config, dataset)
            nanoaods = findChildrenOfDataset(miniaod)
            if len(nanoaods) > 1:
                print(f"Dataset {dataset.name} has more than one NanoAOD matching the MiniAOD used by HTT-reprocess")

            # Find the aux dataset
            dataset_aux = config.datasets.get(dataset.name + "_aux")

            if dataset_aux.dataset not in nanoaods:
                print(f"ERROR : dataset {dataset.name} has Nanov9 :\n{dataset_aux.dataset}\n but HTT-reprocessed based of MiniAOD :\n{miniaod}\nThis MiniAOD has for children :")
                print("\n".join(nanoaods))
                print()
                errors = True
    return errors


################# XSDB search
# import subprocess
# import pycurl
# import json

# class RequestWrapper:
#     """ Wrapper for making http requests to xsdb api """

#     # subprocess.Popen(['/home/llr/cms/cuisset/.local/bin/auth-get-sso-cookie', '-u', 'https://cms-gen-dev.cern.ch/xsdb',
#     #                   '-o', 'cookie.txt'], stdout=subprocess.PIPE).communicate()[0]

#     c = pycurl.Curl()
#     c.setopt(pycurl.FOLLOWLOCATION, 1)
#     # c.setopt(pycurl.COOKIEJAR, "cookie.txt")
#     # c.setopt(pycurl.COOKIEFILE, "cookie.txt")
#     c.setopt(pycurl.HTTPHEADER, ['Content-Type:application/json', 'Accept:application/json'])
#     c.setopt(pycurl.VERBOSE, 1)
#     c.setopt(pycurl.SSL_VERIFYPEER, 0)
#     c.setopt(pycurl.SSL_VERIFYHOST, 0)

#     def simple_search(self, keyval_dict):
#         return self._perform_post('https://cms-gen-dev.cern.ch/xsdb/api/search', json.dumps(keyval_dict))

#     def _perform_post(self, url, post_fields):
#         self.c.setopt(self.c.URL, url)
#         self.c.setopt(pycurl.POST, 1)
#         self.c.setopt(self.c.POSTFIELDS, post_fields)
#         from io import BytesIO
#         buffer = BytesIO()
#         self.c.setopt(self.c.WRITEDATA, buffer)
#         self.c.perform()
#         return buffer


# def queryXSDB(processName):
#     xsdb_request = RequestWrapper()
#     query = dict(process_name=processName)
#     return xsdb_request.simple_search(query)

info_fields = ["name", "type", "nanoV12", "miniAOD", "nanoV9", "xs_framework", "xs_framework_aux", "xs_xsdb_link"]

def datasetInfoSummary(config):
    infos = []
    for dataset in config.datasets:
        info = dict(name=dataset.name)
        if dataset.name.startswith("data"): # data
            break
        elif "secondary" not in dataset.tags: # NanoV12
            if dataset.folder.startswith("/eos/cms/store/group/phys_higgs/HLepRare/HTT_skim_v1/Run2_"): # HTT skim
                info["type"] = "HTT-reprocessed"
                info["nanoV12"] = dataset.folder.split("/")[-1]
                info["miniAOD"] = findMiniAODFromHTTDataset(config, dataset)
                dataset_aux = config.datasets.get(dataset.name + "_aux")
                info["nanoV9"] = dataset_aux.dataset
                info["xs_framework"] = dataset.xs
                info["xs_framework_aux"] = dataset_aux.xs
                info["xs_xsdb_link"] = "https://cms-gen-dev.cern.ch/xsdb/?searchQuery=DAS=" + findMiniAODFromHTTDataset(config, dataset).split("/")[1]

                infos.append(info)
            else:
                print("Unknown dataset " + dataset.name)
        

    return infos

def infoToCSV(infos:list[dict], file):
    writer = csv.DictWriter(file, fieldnames=info_fields)
    writer.writeheader()
    writer.writerows(infos)




if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="checkChildDataset.py", description="Check the coherence between HTT-reprocessed datasets and the NanoAODv9 used for normalization (aux/secondary datasets), checking that they come from the same MiniAOD")
    parser.add_argument("config", help="Configuration module to check (ex : ul_2018_ZZ_v12). You should not check the v9 config, only the v12")
    parser.add_argument("--clearCache", help="Remove cached HTT mappings", action="store_true")
    args = parser.parse_args()
    
    try:
        config = importlib.import_module(args.config).config
    except:
        config = importlib.import_module("config." + args.config).config
    
    if args.clearCache:
        getTempHTTPath(config.year).unlink(missing_ok=True)

    #print(queryXSDB("GluGluHToZZTo2L2Q_M125_TuneCP5_13TeV_powheg2_JHUGenV7011_pythia8").getvalue().decode())
    with open(config.name + ".csv", "w") as f:
        infoToCSV(datasetInfoSummary(config), f)

    if checkChildDatasets(config):
        print()
        print("THERE WERE ERRORS")
        sys.exit(-1)
    
