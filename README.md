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
### Dataset documentation
List of special dataset features : 
 - event_threshold (used by Preprocess/PreCounter) : allows to merge multiple InputData into one Preprocess, by nb of events. See Dataset.get_file_groups.
 - preprocess_merging_factor (used by Preprocess/PreCounter) : same as event_threshold but is a simple multiplicative factor.

### ZZ (SM)
Dataset name in CMSDAS (dataset name in ul_2018_ZZ.py)

dl : dilepton, sl : semileptonic, fh:fully hadronic

 - ZZTo4L (zz_dl)
 - ZZTo2Q2L (zz_sl_background, zz_sl_signal, zz_bbtt)
 - ZZTo4Q_5f (zz_fh)
 - ZZTo2L2Nu (zz_lnu)
 - ZZTo2Q2Nu (zz_qnu)

### Fast datasets (no long queue needed)
ewk_wminus, ewk_z, ggH_ZZ, GluGluToXToZZ, st_top, st_antitop, ttwh, ttwz, ttzh, ww_llnunu, ww_qqqq, wwz, wz_llqq, wzz, zz_bbtt, zz_dl, zz_lnu, zz_qnu, zz_sl_signal, zz_sl_background, zzz

### Generator filter
#### Doc
[TAU POG presentation about DY gen filter](https://indico.cern.ch/event/1170879/contributions/4917733/attachments/2460890/4219167/TauPOG_DYJetsToMuTauh_20220611.pdf)
[Madgraph doc on cards params](https://answers.launchpad.net/mg5amcnlo/+faq/2014)

#### Madgraph on-shell
        bwcutoff
        The run_card parameter bwcutoff defines what is considered to be on-shell s-channel resonances: The resonance if considered to be on-shell if the invariant mass of an s-channel resonance is within M +/- bwcutoff*Gamma, and will then be included as a comment particle in the LHE event file (with status code 2). The value of bwcutoff does not affect the cross section of any processes, except if
        1) you use the decay chain formalism: [a b > c d , c > e f, d > g h] Decay chain processes are strictly valid only in the narrow width limit, and we have therefore chosen to allow only production of on-shell particles. This means that the cross section will get smaller as bwcutoff gets smaller, since more of the tails of the Breit Wigner distributions are cut off.
        2) If you forbid s-channel particles to be on shell ($ symbol)[a b> e f g h $ c d]. This is the exact complementary of the previous case. Where the a b > c d , c > e f, d > g h is not contributing of the mass of the c or the d is on-shell (i,e again M +/- bwcutoff*Gamma).

#### ZZTo2L2Q sample
Madgraph NLO (FXFX) +up to 1 jet, [cards](https://github.com/cms-sw/genproductions/tree/master/bin/MadGraph5_aMCatNLO/cards/production/2017/13TeV/ZZTo2L2Q01j_5f_NLO_FXFX)
`p p > Z l+ l-` (NLO QCD) with Madspin `z > qq`

Parameters:
~~~
15  = bwcutoff
4  = mll_sf  ! Min inv. mass of all opp. sign same-flavor lepton pairs
~~~
[Madgraph forum](https://answers.launchpad.net/mg5amcnlo/+question/696360)

#### ZHToTauTau
Powheg producing H on shell + Z->anything, Pythia force decay H->tautau
[card](https://github.com/cms-sw/genproductions/blob/master/bin/Powheg/production/2017/13TeV/Higgs/HZJ_HanythingJ_NNPDF31_13TeV/HZJ_HanythingJ_NNPDF31_13TeV_M125_Vinclusive.input)

#### ZH_HToBB_ZToLL
Powheg producing H on shell + Z->ll, Pythia force decay H->bb
[card](https://github.com/cms-sw/genproductions/blob/master/bin/Powheg/production/2017/13TeV/Higgs/HZJ_HanythingJ_NNPDF31_13TeV/HZJ_HanythingJ_NNPDF31_13TeV_M125_Vleptonic.input)

## Categories
 - base-selection : removes the events where the object has low pt that have no way to be selected for speed (should maybe be cross checked for ZH)

## Systematics
### Computing systematics
Actual systematics are computed at Categorization step, configured by the yaml modules config.

The `analysis_tool.feature.Systematic` has as special attributes : 
 - name : used for refrerence in framework and also for datacard. "central" is a special name
 - label: not used anywhere I think
 - expression : if string, suffix to append for systematic variation, "_up" & "_down" will be automatically added (ex : "_FlavorQCD" will lead to "_FlavorQCD_up" & "_FlavorQCD_down"). If "", then up/down are used. If tuple, this is used in case this systematic is defined in Feature.central: a replacement will be performed in the feature expression, replacing the first tuple value with the second (ex : `Systematic("met_smearing", ("MET", "MET_smeared"))` used with `Feature("met_pt_smeared", "MET_phi", central="met_smearing")` will plot `MET_smeared_phi` as central value)
 - up, down : suffixes that are used in case you need different up/down or if "_up"/"_down" standard suffixes are not used
 - module_syst_type : used in `RDFModuleTask.get_feature_modules`, in case a Preprocess/Categorization systematic is specified. If str, then for every module run, a keyword argument is added, with key `module_syst_type` and value `systematic.expression+direction` (where direction is systematic.up/down). If list(str) then one can combine several systematics. Can also be dict of shape `{module_syst_type:{up:expr_up, down:expr_down}}`
 - affected_categories: list of categories that will have event migration due to this category. A different PreProcess&Categorization will be made for this systematic (up&down separately), with output name `data_systematic_up/down_0.root`. See `cmt.base_tasks.preprocessing.PreprocessRDF.get_addendum`.

The `analysis_tool.feature.Feature` has as special syst-related attributes :
 - central: name of a systematic to use for central value (used for ex to plot smeared jet values as central)
 - systematics: list of systematics to consider for this feature
 - selection: selection to apply at PrePlot level, for each systematic variation, after modules are run


### Categories
In a category selection expression, if a Feature name is wrapped in double brackets (`{{my_feature}}`), then it is expanded including the systematic that is currenlty used during PreProcess/Categorization/... (done in `cmt.config.base_config.Config.get_object_expression`). Actual replacement code is rather intricate (should also support vector access with `.at`).

### Plotting systematics
Then at PrePlot step, the Feature definitions list of systematics are looked up. You can remove systematics from Feature.systematics = [....]. If requested systematics were not computed in Categorisation, then you will get an error saying ..._FlavorQCD_up symbol is missing for example.

The systematics shift are loaded in FeaturePlot by calling config.get_norm_systematics which loads the files in nanoaod_base_analysis/cmt/files/systematics. Systematics are taken from : 
 - Feature.systematics
 - looking at config.weights[category_name], if the weight has a feature of the same name, add all Feature.systematics
 - Looking at category.sleection, look at all features in double brackets ({{feature_name}}) and add their systematics
 - Same for region.selection


### Disabling fully systematics
Add : 
~~~yaml
        jet_syst: ''
        jet_central: ''
        tau_central: ''
        tau_syst: ''
        met_smear_tag: ''
~~~
to the configs in modulesrdf.yaml (as by default smearing is applied)


### Systematics affecting selections
Listing object-modifying systematics that can lead to migration of events from one category to another/outside selections

Categories make selection on : 
 - pairType, isBoosted
 - DeepTauVSjet
 - isOS
 - Xbb_mass
 - Ztt_svfit_mass

List of object-changing systematics : 
 - tau energy scale
 - electron scaling/smearing uncertainties
 - JER (smearing up/down of MC jets)
 - JEC (11 variations)


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

## NanoAOD skims
[Repo for skims](https://github.com/cms-tau-pog/NanoProd/tree/HTT_skim_v1)
[CMSSW version](https://github.com/cms-tau-pog/NanoProd/blob/b5140b3dc7034dd62ae4cf3c455e6f5c27d4243a/env.sh#L84)
[Customizations](https://github.com/cms-tau-pog/NanoProd/blob/HTT_skim_v1/NanoProd/python/customize.py)
[Skim config](https://github.com/cms-tau-pog/NanoProd/blob/HTT_skim_v1/NanoProd/config/skim_htt.yaml)

The skims may have sometimes stricter cuts than us (electron ISO WP 80 vs 90 for example).

## Analysis documentation ZZ
### Datasets
#### Data
2016HIPM = APV = preVFP
2016 = noHIPM = postVFP

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

## Triggers
### SingleMu
 - 2018 : HLT_IsoMu24
 - 2017 : HLT_IsoMu27 (HLT_IsoMu24 is prescaled, recommendation is to use 27)
 - 2016 : HLT_IsoMu24

Cuts : offline = trig + 2 GeV in pt (Muon HLT recommendation for 2016, also what HH res uses). Eta < 2.4 (Used to be 2.3, Muon POG recommends 2.4). 
Trigger matching : Muon recommends DeltaR<0.1, we use 0.5 : **TODO** check this

### SingleEle
SFs : by C. Caillol, see (https://github.com/LLRCMS/KLUBAnalysis/pull/330).
For 2017 special case (see HHLepton.py)

### Cross
#### SFs
[AN/22-159 (gammagamma->tautau)](https://icms.cern.ch/tools-api/restplus/relay/piggyback/notes/AN/2022/159/files/8/download) (see appendix A) computed SFs with tag&probe on Z for cross triggers (based on work in AN/20-014). Approved by POG for gg->tautau analysis.

[Approval Muon POG](https://indico.cern.ch/event/1297171/contributions/5453041/attachments/2668478/4624848/mutrgSFs.pdf)
[Approval EGamma](https://indico.cern.ch/event/1288547/#25-trigger-sfs-for-gamma-gamma)

## Monte Carlo corrections & systematics
<https://twiki.cern.ch/twiki/bin/viewauth/CMS/DoubleHiggsToBBTauTauWorkingLegacyRun2>

### Per-event
#### PUweight
ALready in NanoAOD. Used for normalization in nanoV12 and v9 for some reason

#### L1PrefiringWeight
<https://twiki.cern.ch/twiki/bin/view/CMS/L1PrefiringWeightRecipe>
Already in NanoAOD. SHape systematic called "prefiring". There seems to be the option of a single shape variation or ECAL/muon split. We combine them.

#### Stitching weight
Currently used only for Drell-Yan

#### Trigger SFs & prescale
See AN. No prescale weights (no prescaled triggers)
SYsts : ele, mu, DM0, DM1, DM10, DM11
in `CMSSW_12_3_0_pre6/src/Tools/Tools/python/Htt_trigSF.py`

For electrons we should theoretically use Supercluster eta rather than electron eta (PV vs 0,0,0).

### Jets & MET
The analysis uses two btag : DeepJet (Jet_btagDeepFlavB) for AK4 jets and ParticleNet (FatJet_particleNet_XbbVsQCD) for AK8 jets (boosted category)

#### pileup jet id SF
[TWiki](https://twiki.cern.ch/twiki/bin/view/CMS/PileupJetID), [TWiki for UL](https://twiki.cern.ch/twiki/bin/view/CMS/PileupJetIDUL)

Computed in `CMSSW_12_3_0_pre6/src/Corrections/JME/interface/PUjetID_SFinterface.h`

Systs : only one


#### JEC/JER
[JEC uncertainty sources](https://twiki.cern.ch/twiki/bin/view/CMS/JECUncertaintySources)
[JEC recommendations](https://twiki.cern.ch/twiki/bin/view/CMS/JECAnalysesRecommendations#Uncertainties)
[JEC MC corrections](https://twiki.cern.ch/twiki/bin/view/CMS/JECDataMC)
[JER](https://twiki.cern.ch/twiki/bin/view/CMS/JetResolution)
[NanoAODToolsCode](https://github.com/cms-nanoAOD/nanoAOD-tools/blob/d163c18096fe2c5963ff5a9764bb420b46632178/python/postprocessing/modules/jme/jetmetHelperRun2.py)

[MET Twiki](https://twiki.cern.ch/twiki/bin/view/CMS/MissingET), [MET Run2 recommendations](https://twiki.cern.ch/twiki/bin/viewauth/CMS/MissingETRun2Corrections#MET_Uncertainties),
[MET uncertainty prescription in MiniAOD](https://twiki.cern.ch/twiki/bin/view/CMS/MissingETUncertaintyPrescription)
[JER to MET propagation recommendation](https://cms-talk.web.cern.ch/t/met-uncertainty-due-to-jet-resolution/8589/3)

[JEC grouping in 11](https://docs.google.com/spreadsheets/d/1Feuj1n0MdotcPq19Mht7SUIgvkXkA4hiB0BxEuBShLw/edit?gid=1345121349#gid=1345121349)


Specifically for AK8 jets, see <https://cms-talk.web.cern.ch/t/jecs-for-ak8/36525>

#### AK4 btag Weight reshape
We use reshape scale factors (rather than fixed WP SFs) because HHBtag uses raw score as input I think. btagWeightReshape needs to be recomputed for every JES. Framework needs to take into account shifted btagWeight when computing weight for shifted JES (TODO determine how to do this in framework)

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

See <https://btv-wiki.docs.cern.ch/PerformanceCalibration/shapeCorrectionSFRecommendations/#correlation-across-years-run-2> for correlation recommendations across years

#### FatJet ParticleNet (AK8)
We use the NanoV12 `FatJet_particleNetLegacy_Xbb` &  `FatJet_particleNetLegacy_QCD` ie the legacy particleNet.
Same as KLUB ([ntuplizer](https://github.com/LLRCMS/LLRHiggsTauTau/blob/429fd9eb6b2c6455a7954abeeef883c68c7a0518/NtupleProducer/plugins/HTauTauNtuplizer.cc#L2744), [config](https://github.com/LLRCMS/KLUBAnalysis/blob/8eabf8c5a8edc527f317c8956944d65cd4ea7601/config/selectionCfg_TauTau_UL16.cfg#L11))



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

##### NanoV12 FatJet_particleNet_XbbVsQCD aka ParticleNetFromMiniAODAK8 ie retrained UL18 ParticleNet
[Nano def in CMSSW](https://github.com/cms-sw/cmssw/blame/e503e2d7de40839e0b64ef78c91530f9357a4b6b/PhysicsTools/NanoAOD/python/jetsAK8_cff.py#L118) : `bDiscriminator('pfParticleNetFromMiniAODAK8DiscriminatorsJetTags:HbbvsQCD')`

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

##### Ideas for SFs for background
###### Drell-Yan
Go into mumu

###### ttbar
emu + 1b jet tagged + FatJet




### Electron and muon scale factors
Put in idAndIsoAndFakeSF
HHbbtt anaylsis splits it in barrel/endcap, but we don't (yet?)

Uncertanities : jetTauFakes, etauFR, mutauFR, eleIso, muIso, eleId, muId

### Electrons
(https://twiki.cern.ch/twiki/bin/view/CMS/EgammaUL2016To2018) (https://twiki.cern.ch/twiki/bin/view/CMS/EgammaRunIIRecommendations) (https://twiki.cern.ch/twiki/bin/view/CMS/EgammaSFJSON)
Computed in `CMSSW_12_3_0_pre6/src/Corrections/EGM/python/eleCorrections.py`, not used by HHbbtt (??)
Electron scale factors uncertainties
 - Zvtx : no? (maybe we should)
 - RECO : yes
 - ID/ISO : yes
 - scale/smearing : no (maybe we should ?)

### Muons
(https://twiki.cern.ch/twiki/bin/view/CMS/TopSystematics#Muon_identification_isolation_mo)
(https://twiki.cern.ch/twiki/bin/view/CMS/MuonUL2018#Medium_pT_from_15_to_120_GeV)
see jsonpog

Efficiencies SFs for muons : 
 - tracking : no (recommended not to apply)
 - L1 prefiring : yes (incl in nano)
 - Reco : no (not sure why but other analyses seem to not use them)
 - ID : yes
 - ISO : yes
 - Trigger : yes

[Rochester corrections](https://twiki.cern.ch/twiki/bin/view/CMS/RochcorMuon) : not used (optional, only if we are very sensitive to muon momentum)

### Taus
#### DeepTau SF for hadronic taus
Cmoputed in `CMSSW_12_3_0_pre6/src/Corrections/TAU/python/tauCorrections.py` and then used in `CMSSW_12_3_0_pre6/src/Tools/Tools/python/dauIdIso.py` where it is used to make idAndIsoAndFakeSF

Choice of WPs : vsMu we can choose anyrtging. VsEle we have to pick either VVLoose or Tight as SFs for VsJets for genuine taus depend on choice of VsEle WP

#### Tau energy scale corrections (TES)

#### Jet faking taus
**TODO** We need to compute SFs for Jet faking taus in DeepTau. We should compute them ourselves (using gen info in MC ?) apparently.

### boostedTaus
[CMSSW boostedTau reco config](https://github.com/cms-sw/cmssw/blob/f47281314cbae103289999806846b692264a09a4/RecoTauTag/Configuration/python/boostedHPSPFTaus_cfi.py)
[CMSSW boostedTaus nano config](https://github.com/cms-sw/cmssw/blob/edf3ebde7ff8fa704fd6f6918360b84cf1a795f7/PhysicsTools/NanoAOD/python/boostedTaus_cff.py#L56)

#### anti-electron discriminator
"againstElectronMVA6Raw" / "againstElectronMVA6category" in MiniAODv1 (againstElectronMVA6Raw2018/againstElectronMVA6category2018 in v2)
See [here](https://github.com/cms-sw/cmssw/blob/3be60c77df03988f0c0936911c48eeb6635116be/RecoTauTag/RecoTau/python/tools/runTauIdMVA.py#L1092) for definition
Known as "patTauDiscriminationByElectronRejectionMVA62018"
Uses a PATTauDiscriminantCutMultiplexer as the anti-ele MVA needs to choose what cut to apply on MVA output depending on what the category (DM) is. 
The actual MVA is computed [here](https://github.com/cms-sw/cmssw/blob/3be60c77df03988f0c0936911c48eeb6635116be/RecoTauTag/RecoTau/src/AntiElectronIDMVA6.cc).

## DNNs
### HHbtag
[Computing purity : notebook](https://github.com/elenavernazza/hhbbtt-analysis/blob/main/nicePlots/HHBTag/HHBTag_Purity.ipynb)
[Framework used for HHBtag purity](https://github.com/cms-flaf/Framework/blob/main/Common/BaselineSelection.py#L60C46-L60C63)



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

Using a dataset or feature that does not exist is silently ignored.

Using `--workers 1` in combination with RDataFrame will lead to a memory leak, as every new RDataFrame creation will use some memory that will never be freed.

### Notebooks issues
luigi v2.8.13 wants tornado>=4,<6 but notebook installed in cmssw wants tornado 6 ([issue](https://github.com/jupyter/notebook/issues/5920)). There is also a jinja issue.
In case you get the error ̀`ImportError: cannot import name 'contextfilter' from 'jinja2'`, then run `pip install --upgrade --prefix "$CMT_SOFTWARE" jinja2==3.0.3 `. The issue is due to a too recent version of jinja2 being installed , not compatible with the old jupyter nbconvert that comes with CMSSW.

## Frameweork developments
### Sppeding up PrePlot
PrePlot is CPU-bound from histogram filling (1 histogram for each systematic, incl. weight systsemtaic). Weight computation is redone for every histogram (suboptimal) but not a bottleneck. Probably rdataframe mulitthreading is the way to go.