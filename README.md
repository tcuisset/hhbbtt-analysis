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

## Datasets
### ZZ (SM)
Dataset name in CMSDAS (dataset name in ul_2018_ZZ.py)

dl : dilepton, sl : semileptonic, fh:fully hadronic

 - ZZTo4L (zz_dl)
 - ZZTo2Q2L (zz_sl_background, zz_sl_signal, zz_bbtt)
 - ZZTo4Q_5f (zz_fh)
 - ZZTo2L2Nu (zz_lnu)
 - ZZTo2Q2Nu (zz_qnu)

## Categories
 - base-selection : removes the events where the object has low pt that have no way to be selected for speed (should maybe be cross checked for ZH)

## Systematics
Actual systematics are computed at Categorization step, configured by the yaml modules config.
Then at PrePlot step, the Feature definitions list of systematics are looked up. You can remove systematics from Feature.systematics = [....]. If requested systematics were not computed in Categorisation, then you will get an error saying ..._FlavorQCD_up symbol is missing for example.

## Analysis documentation ZZ
### Datasets
#### ZZ
ZZTo2Q2L : dataset name : process name
 - zz_sl_signal : zz_sl_signal
 - zz_sl_background : zz
 - zz_bbtt : zz_bbtt (bkg for resonant ZZ analysis)

#### ZH (background)
 - zh_hbb_zll (dataset ZH_HToBB_ZToLL_M-125) : process in ZZ analysis is zh_hbb (parent zh->higgs)
 - zh_htt (ZHToTauTau_M125) : (used in ZZ analysis, parent zh->higgs)
 - ttzh (dataset TTZH) : (used in ZZ analysis parent ttx->zz_background)
 - zh_hbb_zqq (ZH_HToBB_ZToQQ_M-125) : commented out ?

### Process tags
 - isZZsignal : if True, module Tools.Tools.ZZAnalysis.ZZBBTauTauFilterRDF will select at gen level ZZ->bbtt events
 - isZZbackground : if True, module Tools.Tools.ZZAnalysis.ZZBBTauTauFilterRDF will exclude at gen level ZZ->bbtt events (not used currently)

### Datasets and processes
Processes for ZZ analysis:
 - zz_sl_signal (isZZsignal, isSignal) : (dataset ZZTo2Q2L) -> SM ZZ->bbtt (signal for ZZ non-resonant analysis)
 - zz_bbtt (isZZsignal) : (dataset ZZTo2Q2L) : X->ZZ->bbtt, same as zz_sl_signal but isSignal=False (bkg for ZZ resonant analysis)
 - ggXZZbbtt_M$MASS (isZZSIgnal, isSignal) : X->ZZ->bbtt (signal for ZZ resonant analysis)




## ANalysis documentation ZH 
### Datasets
Datasets needing to be reprocessed compared to ZZ analysis :
zh_hbb_zll_background_aux
zh_zbb_htt_sl_signal_aux
zh_htt_background_aux
zh_ztt_hbb_sl_signal
zh_ztt_hbb_sl_signal_aux
zh_zbb_htt_sl_signal
zh_hbb_zll_background
zh_htt_background


#### Signal
 - zh_ztt_hbb_sl_signal (ZH_HToBB_ZToLL) -> process zh_ztt_hbb_sl_signal (to be genmatched)
 - zh_zbb_htt_sl_signal (ZHToTauTau) -> process zh_zbb_htt_sl_signal (to be genmatched)

#### ZH background
 - zh_hbb_zll_background -> process zh_sl_background (to be !genmatched)
 - zh_htt_background -> process zh_sl_background (to be !genmatched)

#### ZZ bkg
 - zz_sl_background (ZZTo2Q2L) -> process zz (zz_sl_signal and zz_bbtt get removed)

### Process tags
 - isZHsignal : can be set to [], "hbb_ztt", "ztt_hbb", ["zbb_htt", "ztt_hbb"]. module Tools.Tools.ZHAnalysis.ZHBBTauTauFilterRDF will filter at gen-level the requested decay modes.
 - isZHbackground : same but exclude decays into bbtautau or tautaubb

### Processes
Processes for ZH analysis:
 - zh_sl_signal (isZHsignal=["zbb_htt", "ztt_hbb"], isSignal) : (no dataset) -> SM ZH->bbtt (incl. 2 permutations of decays, signal for ZH non-resonant analysis)
 - zh_zbbhtt_sl_signal (isZHsignal="zbb_htt", isSignal, parent=zh_sl_signal) : (dataset ZZTo2Q2L) -> SM ZH (Z->bb, H->tautau)
 - zh_ztthbb_sl_signal (isZHsignal="ztt_hbb", isSignal, parent=zh_sl_signal) : (dataset ZZTo2Q2L) -> SM ZH (Z->tautau, H->bb)
 - ggZpZHttbb_M$MASS (isZHsignal="ztt_hbb", isSignal) : X->ZH->(Z->tautau, H->bb) (signal for ZH resonant analysis)
 - TODO : zh_sl SM as bkg for resonant ZH analysis
 - zh : all ZH production except bbtautau(or tautaubb) final states
 - zz : all ZZ production 
 - zz_background : this is actually all backgrounds for the ZH analysis (the name is misleading)

## Known bugs
When force reinstalling the software using setup.sh, if the rm calls fail (for example a .nfs file is remaining) then you will be left in a state where the script won't reinstall the software because the software folder exists, but it is mostly empty. You have to remove the folder by hand (`rm -r $CMT_SOFTWARE`), eventually fixing the stale process issue (`/usr/sbin/lsof xxx/.nfsxxx` is useful), then rerun `source setup.sh`

Do not use request_cpus > 1, as some modules are not thread-safe.

RuntimeError: Failed to find qcd_tesUp : you need to add --propagate-syst-qcd option (FeaturePlot option). You might need to clear out FeaturePlot output with `law run CreateDatacards ... --remove-output 1`

Framework : when there are inheriting tasks, say C depends on B depends on A and B inherits from A (but C does not inherit from B), then parameters to A should be passed on the CLI as --B-param (if passed as --A-param, they will not be passed on when running B.vreq, unless it is "version").
In particular : `law run RunCombineCombination ...  --FeaturePlot-version prod_240226_fixSystQcd --CreateDatacards-do-qcd --CreateDatacards-... ` rether than `--FeaturePlot-do-qcd`

### Notebooks issues
luigi v2.8.13 wants tornado>=4,<6 but notebook installed in cmssw wants tornado 6 ([issue](https://github.com/jupyter/notebook/issues/5920)). There is also a jinja issue.
In case you get the error ̀`ImportError: cannot import name 'contextfilter' from 'jinja2'`, then run `pip install --upgrade --prefix "$CMT_SOFTWARE" jinja2==3.0.3 `. The issue is due to a too recent version of jinja2 being installed , not compatible with the old jupyter nbconvert that comes with CMSSW.