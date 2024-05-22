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

## Plotting conventions
### Legend ordering
Ordering of legend for plots :
 - Signal
 - DY
 - Wjets
 - ttbar
 - VV(V)
 - H
 - TTX
 - others
 - QCD

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

The systematics shift are loaded in FeaturePlot by calling config.get_norm_systematics which loads the files in nanoaod_base_analysis/cmt/files/systematics. Systematics are taken from : 
 - Feature.systematics
 - looking at config.weights[category_name], if the weight has a feature of the same name, add all Feature.systematics
 - Looking at category.sleection, look at all features in double brackets ({{feature_name}}) and add their systematics
 - Same for region.selection

## Weights
Preplot weight :
$ w^P_i = \text{gen}_i * \text{PU}_i * \text{St}_i * X_i$
where $\text{St}_i$ is the eventual stitching weight (used for Drell-Yan only) $X_i$ has $prescaleWeight*trigSF*idAndIsoAndFakeSF*PUjetID_SF*bTagweightReshape$

PreCounter weight :
$ w^C_j = \text{gen}_j * \text{PU}_j * \text{St}_j$

FeaturePlot weight :
$$ w^F_i = w^P_i * \frac{\sigma \mathcal{L}}{\sum_{j \in \text{NanoV9}} w^C_j}$$
or in full : 
$$ w^F_i = \text{gen}_i * \text{PU}_i * \text{St}_i * X_i * \frac{\sigma \mathcal{L}}{\sum_{j \in \text{NanoV9}} \text{gen}_j * \text{PU}_j * \text{St}_j}$$

The bin error in bin $k$ is :
$$ E^F_k = \frac{\sigma \mathcal{L}}{\sum_{j \in \text{NanoV9}} w^C_j} \sqrt{\sum_{i \in \text{bin k}} (w^P_i)^2} $$

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

## Monte Carlo corrections
### PUweight
ALready in NanoAOD. Used for normalization in nanoV12 and v9 for some reason

### pileup jet id SF
[TWiki](https://twiki.cern.ch/twiki/bin/view/CMS/PileupJetID), [TWiki for UL](https://twiki.cern.ch/twiki/bin/view/CMS/PileupJetIDUL)

Computed in `CMSSW_12_3_0_pre6/src/Corrections/JME/interface/PUjetID_SFinterface.h`

### L1PrefiringWeight
<https://twiki.cern.ch/twiki/bin/view/CMS/L1PrefiringWeightRecipe>
Already in NanoAOD. SHape systematic called "prefiring"

### Stitching weight
Currently used only for Drell-Yan

### trigger prescale weights
already included in efficiency scale factors ie trigSF

### trigSF

### btag Weight reshape
We use reshape scale factors (rather than fixed WP SFs) because HHBtag uses raw score as input I think. btagWeightReshape needs to be recomputed for every JES. Framework needs to take into account shifted btagWeight when computing weight for shifted JES (TODO determine how to do this in framework)

### FatJet discriminant SF

The analysis uses two btag : DeepJet (Jet_btagDeepFlavB) for AK4 jets and ParticleNet (FatJet_particleNet_XbbVsQCD) for AK8 jets (boosted category)

#### DeepJet
For AK4 jets, Computed in `nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/BTV/python/btag_SF.py`, makes bTagweightReshape. Uses the shape correction SFs (presumably because HHbtag uses the score of the bjet discriminator). Wp corrections are also computed (not entirely correctly I think) but thy are not used.
Docs :  <https://btv-wiki.docs.cern.ch/ScaleFactors/>

Info from `python3 -m correctionlib.cli summary /cvmfs/cms.cern.ch/rsync/cms-nanoAOD/jsonpog-integration/POG/BTV/2018_UL/btagging.json.gz`
~~~
deepCSV reshaping scale factors for UL 2018. The scale factors have 8 default uncertainty       
│   sources (hf,lf,hfstats1/2,lfstats1/2,cferr1/2). All except the cferr1/2 uncertainties are to be 
│   applied to light and b jets. The cferr1/2 uncertainties are to be applied to c jets.            
│   hf/lfstats1/2 uncertainties are to be decorrelated between years, the others correlated.        
│   Additional jes-varied scale factors are supplied to be applied for the jes variations.          
│   Node counts
~~~

#### ParticleNet (AK8)
We use the NanoV12 `FatJet_particleNet_XbbVsQCD`  ([branch](https://cms-nanoaod-integration.web.cern.ch/autoDoc/NanoAODv12/2022/2023/doc_DYJetsToLL_M-50_TuneCP5_13p6TeV-madgraphMLM-pythia8_Run3Summer22NanoAODv12-130X_mcRun3_2022_realistic_v5-v2.html)) : ParticleNet X->bb vs. QCD score: Xbb/(Xbb+QCD)
[Nano def in CMSSW](https://github.com/cms-sw/cmssw/blame/e503e2d7de40839e0b64ef78c91530f9357a4b6b/PhysicsTools/NanoAOD/python/jetsAK8_cff.py#L118) : `bDiscriminator('pfParticleNetFromMiniAODAK8DiscriminatorsJetTags:HbbvsQCD')`

>NanoAODv11 (and v9, v10)
>Legacy ParticleNet trained on Run-2.
>
>NanoAODv12:
>ParticleNet re-trained on Run-2. Added other decay modes (Detailed talk).
>Single architecture for mass regression and classification (Xbb).
>Mass regression: correction to mass (includes JECS)
>Definitions:
>XbbvsQCD discriminator: pfParticleNetFromMiniAODAK8DiscriminatorsJetTags:HbbvsQCD
>Mass regression: pfParticleNetFromMiniAODAK8JetTags:masscorr * FatJet_mass

According to Bruno, SFs need to be applied separately per process. The SFs computed in AN apparently should only be for X->bb processes like Z->bb, not for ttbar. There should be a gen-level lookup to apply the correct one. Simona Palluotto is doing it for HH resonant. 

Discussion with Simona : looking at SFs for bkgs. Drell-Yan in mumu channel. ttbar in ttbar-enriched region in etau & tautau channel by filtering on tautau visible mass. We can contact the HH resonant boosted analysis also

Docs :
 - <https://indico.cern.ch/event/1382063/contributions/5839629/attachments/2813742/4911527/ParticleNet_in_NanoAODv14.pdf>
 - <https://indico.cern.ch/event/1300663/contributions/5468706/attachments/2676781/4642517/cooperstein_ParticleNet_july32023.pdf>
 - [Latest slides on SF derivation](https://indico.cern.ch/event/1372043/contributions/5922330/attachments/2846865/4977821/24.04.29_BTV-22-001_updates.pdf)
 - [boohft-calib : SFs for PNet](https://github.com/colizz/boohft-calib)
 - [CADI for BTV-22-001](https://cms.cern.ch/iCMS/analysisadmin/cadilines?line=BTV-22-001)
 - [slides for calibration](https://indico.cern.ch/event/1253794/contributions/5588643/attachments/2746372/4778861/23.11.06_ML4Jets_Boosted_jet_tagging_performance_MM.pdf)
Analyses using AK8 bb tagging : 
 - HIG-24-003 (VVH(bb)) [AN23-016](http://cms.cern.ch/iCMS/jsp/openfile.jsp?tp=draft&files=AN2023_016_v5.pdf)
 - [Simona's slides](https://indico.cern.ch/event/1360977/contributions/5953985/attachments/2855831/4994825/ParticleNet_SF_14_05_2024.pdf)

##### NanoV12 FatJet_particleNet_XbbVsQCD aka ParticleNetFromMiniAODAK8
MiniAOD : pfParticleNetFromMiniAODAK8DiscriminatorsJetTags:HbbvsQCD
[PR](https://github.com/cms-sw/cmssw/pull/40745)
Trained on UL18 samples [README](https://github.com/scooperstein/RecoBTag-Combined/blob/master/ParticleNetFromMiniAODAK8/README.md), only for central jets (from PUPPI)
[Slides JERC (AK4 only)](https://indico.cern.ch/event/1220368/contributions/5141019/attachments/2548768/4389765/cooperstein_ParticleNet_nov162022.pdf), [TAU POG](https://indico.cern.ch/event/1223165/contributions/5158297/attachments/2561047/4414677/cooperstein_ParticleNetPlusTau_dec62022.pdf) [AN-022/094](http://cms.cern.ch/iCMS/jsp/openfile.jsp?tp=draft&files=AN2022_094_v6.pdf)
[Perf study and comparison](https://indico.cern.ch/event/1382063/contributions/5839629/attachments/2813742/4911527/ParticleNet_in_NanoAODv14.pdf)

##### NanoV12 FatJet_particleNetWithMass_HbbvsQCD (mass-correlated)
Mass-correlated : 
NanoV12 FatJet_particleNetWithMass_HbbvsQCD, MiniAOD pfParticleNetDiscriminatorsJetTags:HbbvsQCD from pfParticleNetJetTags

##### ParticleNet-MD
Mass-decorrelated :
NanoV9 (particleNetMD_Xbb), NanoV12 (particleNetLegacy_Xbb), NanoV14 (particleNetLegacy_Xbb), MiniAOD pfMassDecorrelatedParticleNetDiscriminatorsJetTags from pfMassDecorrelatedParticleNetJetTags

[PR](https://github.com/cms-sw/cmssw/pull/28902)
[ PR for adding it back to nanoV14](https://github.com/cms-sw/cmssw/pull/44507)
[DP2020_002](https://cds.cern.ch/record/2707946/files/DP2020_002.pdf)
[BTV slides](https://indico.cern.ch/event/868673/contributions/3671036/attachments/1960696/3258484/ParticleNet_BTV_20191211_H_Qu.pdf)

[KLUB ntuplizer ak8jets_particleNetMDJetTags_mass](https://github.com/LLRCMS/LLRHiggsTauTau/blob/429fd9eb6b2c6455a7954abeeef883c68c7a0518/NtupleProducer/plugins/HTauTauNtuplizer.cc#L2741)
[AN21-005 with SF for ParticleNet-MD](http://cms.cern.ch/iCMS/jsp/openfile.jsp?tp=draft&files=AN2021_005_v10.pdf)
[AN22-156 with SF](http://cms.cern.ch/iCMS/jsp/openfile.jsp?tp=draft&files=AN2022_156_v20.pdf)

#### Ideas for SFs for background
##### Drell-Yan
Go into mumu

##### ttbar
emu + 1b jet tagged + FatJet

### DeepTau SF for hadronic taus
Cmoputed in `CMSSW_12_3_0_pre6/src/Corrections/TAU/python/tauCorrections.py` and then used in `CMSSW_12_3_0_pre6/src/Tools/Tools/python/dauIdIso.py` where it is used to make idAndIsoAndFakeSF

### Electron and muon scale factors
Put in idAndIsoAndFakeSF

### Tau energy scale corrections (TES)

## SYstematics
<https://twiki.cern.ch/twiki/bin/viewauth/CMS/DoubleHiggsToBBTauTauWorkingLegacyRun2>
### idAndIsoAndFakeSF
HHbbtt anaylsis splits it in barrel/endcap, but we don't (yet?)

Uncertanities : jetTauFakes, etauFR, mutauFR, eleIso, muIso, eleId, muId
#### ele_iso and muon_iso
Computed in `CMSSW_12_3_0_pre6/src/Corrections/EGM/python/eleCorrections.py`, not used by HHbbtt (??)
Electron scale factors uncertainties

### trigSFs
SYsts : ele, mu, DM0, DM1, DM10, DM11
in `CMSSW_12_3_0_pre6/src/Tools/Tools/python/Htt_trigSF.py`

### pujetIDSF
Systs : only one

### JEC
<https://twiki.cern.ch/twiki/bin/view/CMS/JECUncertaintySources>

Specifically for AK8 jets, see <https://cms-talk.web.cern.ch/t/jecs-for-ak8/36525>

### btag
See <https://btv-wiki.docs.cern.ch/PerformanceCalibration/shapeCorrectionSFRecommendations/#correlation-across-years-run-2> for correlation recommendations across years

## Known bugs
### Installation
When force reinstalling the software using setup.sh, if the rm calls fail (for example a .nfs file is remaining) then you will be left in a state where the script won't reinstall the software because the software folder exists, but it is mostly empty. You have to remove the folder by hand (`rm -r $CMT_SOFTWARE`), eventually fixing the stale process issue (`/usr/sbin/lsof xxx/.nfsxxx` is useful), then rerun `source setup.sh`

Undefined symbols during `scram b` in framwork setup : many BuildFile.xml are missing various externals, mainly "root" and "rootvecops" (for ROOT::VecOps::RVec)

### Running
Do not use request_cpus > 1, as some modules are not thread-safe.

RuntimeError: Failed to find qcd_tesUp : you need to add --propagate-syst-qcd option (FeaturePlot option). You might need to clear out FeaturePlot output with `law run CreateDatacards ... --remove-output 1`

Framework : when there are inheriting tasks, say C depends on B depends on A and B inherits from A (but C does not inherit from B), then parameters to A should be passed on the CLI as --B-param (if passed as --A-param, they will not be passed on when running B.vreq, unless it is "version").
In particular : `law run RunCombineCombination ...  --FeaturePlot-version prod_240226_fixSystQcd --CreateDatacards-do-qcd --CreateDatacards-... ` rether than `--FeaturePlot-do-qcd`

Framework : Dataset.selection is applied at Categorization and at PrePlot level (why both is a mystery). Especially it is not applied at Preprocess or PreCounter level.

Framework : creating a Dataset from another Dataset copies all properties except the "aux" dictionary, in particular it discards the "selection" and other attributes. This happens when copying the v9 datasets to v12.

`Exception: too few leaves (28) for number of requested trees (40)` during MergeCategorization : you should reduce the numbers in Dataset.merging such that it is less than the number of files in the dataset.

"ValueError: Attempted a redefinition of variable weight. If you want to proceed, please rerun with allow_redefinition = True" : this is sometimes reported but is actually not the cause of the error. Usually it's because of a missing variable or something

Using a dataset or feature that odes not exist is silently ignored.

Using `--workers 1` in combination with RDataFrame will lead to a memory leak, as every new RDataFrame creation will use some memory that will never be freed.

### Notebooks issues
luigi v2.8.13 wants tornado>=4,<6 but notebook installed in cmssw wants tornado 6 ([issue](https://github.com/jupyter/notebook/issues/5920)). There is also a jinja issue.
In case you get the error ̀`ImportError: cannot import name 'contextfilter' from 'jinja2'`, then run `pip install --upgrade --prefix "$CMT_SOFTWARE" jinja2==3.0.3 `. The issue is due to a too recent version of jinja2 being installed , not compatible with the old jupyter nbconvert that comes with CMSSW.