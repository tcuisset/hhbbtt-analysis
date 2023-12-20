# ZZ->bbtautau analysis
This is a fork of the [hhbbtt usercode repo](https://github.com/jaimeleonh/hhbbtt-analysis), used for the ZZ->bbtautau analysis (search for SM production of ZZ->bbtautau, ZH->bbtautau, and resonant ZZ and ZH productions as well).

## Links
 - [Framework docs](https://nanoaod-base-analysis.readthedocs.io/en/latest/Installation.html)
 - [hhbbtt repo Elena fork for ZZ and ZH](https://github.com/elenavernazza/hhbbtt-analysis)
 - [nanoaod_base_analysis Elena fork](https://gitlab.cern.ch/evernazz/nanoaod_base_analysis)
 - Information about the code, how to install it, setting a configuration to use it and more useful information about this framework cand be found [here](https://nanoaod-base-analysis.readthedocs.io).

## Setup
To setup at LLR, you should *not* set CMT_CERN_USER. Just run `source setup.sh`. Output will go into `/data_CMS/cms/$USER/cmt` (except for Elena, in which case the setup.sh script will replace $USER will $USER:1)


~~~bash
git clone --recursive https://github.com/elenavernazza/hhbbtt-analysis frameworkRepo
cd frameworkRepo

# git clone https://gitlab.cern.ch/cms-phys-ciemat/nanoaod_base_analysis.git --branch py3 nanoaod_base_analysis/
~~~
<details>
<summary> Updating submodule and setup.sh to use Elena's forks (now commited) </summary>
Editing the submodule to get Elena's fork : open ̀ .gitmodules` and change it to : 
~~~
[submodule "nanoaod_base_analysis"]
        path = nanoaod_base_analysis
        url = https://gitlab.cern.ch/evernazz/nanoaod_base_analysis
~~~


### Updating all the subrepos
You need to update all the subrepos to point to Elena's forks for ZZ->btt. For now this has to be done by hand.
The list of sub repositories to update is :
 - nanoaod_base_analysis https://gitlab.cern.ch/evernazz/nanoaod_base_analysis.git
 - nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Base/Modules : https://gitlab.cern.ch/evernazz/cmt-base-modules
 - nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HHKinFit2 https://github.com/elenavernazza/HHKinFit2.git (*branch=CMSSWversion*)
 - ClassicSVfit, SVfitTF : no fork
 - HTT-utilities : no fork
 - nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Tools/Tools https://github.com/elenavernazza/InferenceTools (aka InferenceTools)
 - nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_hh_proc_interface : https://github.com/elenavernazza/cms_hh_proc_interface : fork but up to date
 - cms_hh_tf_inference : no fork
 - nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models https://github.com/elenavernazza/cms_runII_dnn_models
 - all corrections : tau, muo, lum, jme, egm, btv, (on gitlab https://gitlab.cern.ch/users/evernazz/projects)
 - plotting_tools, analysis_tools (pip) https://gitlab.cern.ch/evernazz/plotting_tools https://gitlab.cern.ch/evernazz/analysis_tools



Now update submodule (probably better commands to do it, with recent git)
~~~bash
cd nanoaod_base_analysis
git remote add elena https://gitlab.cern.ch/evernazz/nanoaod_base_analysis.git
git fetch elena py3
git branch --set-upstream-to elena/py3
# careful : this will remove any changes in nanoaod_base_analysis
git reset --hard elena/py3
cd ..
~~~
</details>


Run setup.sh (this has to be done in outer repository, *not* in nanoaod_base_analysis )
~~~bash
source setup.sh
~~~
This should use all the forked repos

