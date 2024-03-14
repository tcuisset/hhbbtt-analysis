#!/bin/bash
export CMT_BASE="$PWD"
export CMT_DATA="$CMT_BASE/data"

[ -z "$CMT_CMSSW_BASE" ] && export CMT_CMSSW_BASE="$CMT_DATA/cmssw"
[ -z "$CMT_SCRAM_ARCH" ] && export CMT_SCRAM_ARCH="slc7_amd64_gcc10"
[ -z "$CMT_CMSSW_VERSION" ] && export CMT_CMSSW_VERSION="CMSSW_12_3_0_pre6"
[ -z "$CMT_PYTHON_VERSION" ] && export CMT_PYTHON_VERSION="3"

# setup cmssw
export SCRAM_ARCH="$CMT_SCRAM_ARCH"
source "/cvmfs/cms.cern.ch/cmsset_default.sh" ""
if [ ! -d "$CMT_CMSSW_BASE/$CMT_CMSSW_VERSION" ]; then
    echo "setting up $CMT_CMSSW_VERSION at $CMT_CMSSW_BASE"
    mkdir -p "$CMT_CMSSW_BASE"
    cd "$CMT_CMSSW_BASE"
    scramv1 project CMSSW "$CMT_CMSSW_VERSION"
fi
cd "$CMT_CMSSW_BASE/$CMT_CMSSW_VERSION/src"

eval `scramv1 runtime -sh`

# run scram-venv to create a Python virtual environment on top of CMSSW
# https://cms-sw.github.io/venv.html
scram-venv

eval `scramv1 runtime -sh`




# Setting up symbolic links for CMSSW C++ packages
# todo make all of them
mkdir Tools
ln -s ../../../../../cmssw_pkgs/InferenceTools/ Tools/Tools


# Installing python packages
pip3 install -e python_pkgs/analysis_tools

