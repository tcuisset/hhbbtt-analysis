import os, pdb

maindir = os.getcwd()

output = os.popen('git rev-parse HEAD').read()
print(f"hhbbtt-analysis : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis')
output = os.popen('git rev-parse HEAD').read()
print(f"nanoaod_base_analysis : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Tools/Tools/')
output = os.popen('git rev-parse HEAD').read()
print(f"InferenceTools : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Base/Modules/')
output = os.popen('git rev-parse HEAD').read()
print(f"cmt-base-modules : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_hh_proc_interface/')
output = os.popen('git rev-parse HEAD').read()
print(f"cms_hh_proc_interface : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_hh_tf_inference/')
output = os.popen('git rev-parse HEAD').read()
print(f"cms_hh_tf_inference : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/cms_runII_dnn_models/')
output = os.popen('git rev-parse HEAD').read()
print(f"cms_runII_dnn_models : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/BTV/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/BTV : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/EGM/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/EGM : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/JME/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/JME : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/LUM/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/LUM : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/MUO/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/MUO : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/TAU/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/TAU : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/Corrections/Wrapper/')
output = os.popen('git rev-parse HEAD').read()
print(f"Corrections/Wrapper : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HHKinFit2/')
output = os.popen('git rev-parse HEAD').read()
print(f"HHKinFit2 : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HHTools/HHbtag/')
output = os.popen('git rev-parse HEAD').read()
print(f"HHTools/HHbtag : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HTT-utilities/')
output = os.popen('git rev-parse HEAD').read()
print(f"HTT-utilities : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/PhysicsTools/NanoAODTools/')
output = os.popen('git rev-parse HEAD').read()
print(f"PhysicsTools/NanoAODTools : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/TauAnalysis/ClassicSVfit/')
output = os.popen('git rev-parse HEAD').read()
print(f"TauAnalysis/ClassicSVfit : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/TauAnalysis/SVfitTF/')
output = os.popen('git rev-parse HEAD').read()
print(f"TauAnalysis/SVfitTF : commit {output}")

os.chdir(maindir + '/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/TauAnalysisTools/TauTriggerSFs/')
output = os.popen('git rev-parse HEAD').read()
print(f"TauAnalysisTools/TauTriggerSFs : commit {output}")



