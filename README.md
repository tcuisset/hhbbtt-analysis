# hhbbtt-analysis
This is a user code for the configuration of a hhbbtt analysis used with the [main code](https://gitlab.cern.ch/cms-phys-ciemat/nanoaod_base_analysis.git) of the NanoAOD-base-analysis, which aims to process NanoAOD datasets, allowing to generate different root files, histograms and plots with the desired selection of events, variables and branches.

Make a fork of this repository, so you can use it as an example for your own analysis.

## User guide:

Information about the code, how to install it, setting a configuration to use it and more useful information about this framework cand be found [here](https://nanoaod-base-analysis.readthedocs.io).


To setup at LLR, you should *not* set CMT_CERN_USER. Just run `source setup.sh`. Output will go into `/data_CMS/cms/$USER/cmt` (except for Elena, in which case the setup.sh script will replace $USER will $USER:1)
