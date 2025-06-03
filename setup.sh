#!/usr/bin/env bash

action() {
    echo "If you are Jaime, do export CMT_STORE_EOS_PREPROCESSING=/eos/user/g/goylopez/Jaime/cmt"
    #
    # global variables
    #

    # determine the directory of this file
    if [ "$CMT_ON_HTCONDOR" = "1" ]; then
        # echo "We are on condor"
        HOME=/home/llr/cms/$USER /opt/exp_soft/cms/t3/eos-login -username evernazz -wn # [FIXME] we need to make it more general
        cd $CMT_BASE
    else
        # echo "We are in local"
        cd nanoaod_base_analysis
    fi

    #local this_file="$( [ ! -z "$ZSH_VERSION" ] && echo "${(%):-%x}" || echo "${BASH_SOURCE[0]}" )"
    #local this_dir="$( cd "$( dirname "$this_file" )" && pwd )"
    export CMT_BASE="$PWD"

    # check if this setup script is sourced by a remote job
    if [ "$CMT_ON_HTCONDOR" = "1" ]; then
        export CMT_REMOTE_JOB="1"
    else
        export CMT_REMOTE_JOB="0"
    fi

    # check if we're on lxplus
    if [[ "$( hostname )" = lxplus*.cern.ch ]]; then
        export CMT_ON_LXPLUS="1"
    else
        export CMT_ON_LXPLUS="0"
    fi
    
    # check if we're at ciemat
    if [[ "$( hostname -f )" = *.ciemat.es ]]; then
        export CMT_ON_CIEMAT="1"
    else
        export CMT_ON_CIEMAT="0"
    fi

    # check if we're at llr
    if [[ "$( hostname -f )" = *.in2p3.fr ]]; then
        export CMT_ON_LLR="1"
        export EXTRA_CLING_ARGS=" -O2"
    else
        export CMT_ON_LLR="0"
    fi
    
    # default cern name
    if [ -z "$CMT_CERN_USER" ]; then
        if [ "$CMT_ON_LXPLUS" = "1" ]; then
            export CMT_CERN_USER="$( whoami )"
        elif [ "$CMT_ON_CIEMAT" = "0" ] && [ "$CMT_ON_LLR" = "0" ] ; then
            2>&1 echo "please set CMT_CERN_USER to your CERN user name and try again"
            return "1"
        fi
    fi

    # default ciemat name
    if [ -z "$CMT_CIEMAT_USER" ]; then
        if [ "$CMT_ON_CIEMAT" = "1" ]; then
            export CMT_CIEMAT_USER="$( whoami )"
        # elif [ "$CMT_ON_LXPLUS" = "0" ]; then
            # 2>&1 echo "please set CMT_CIEMAT_USER to your CIEMAT user name and try again"
            # return "1"
        fi
    fi

    # default llr name
    if [ -z "$CMT_LLR_USER" ]; then
        if [ "$CMT_ON_LLR" = "1" ]; then
            export CMT_LLR_USER="$( whoami )"
        # elif [ "$CMT_ON_LLR" = "0" ]; then
        #     2>&1 echo "please set CMT_LLR_USER to your CIEMAT user name and try again"
        #     return "1"
        fi
    fi    

    # default data directory
    if [ -z "$CMT_DATA" ]; then
        if [ "$CMT_ON_LXPLUS" = "1" ]; then
            export CMT_DATA="$CMT_BASE/data"
        else
            # TODO: better default when not on lxplus
            export CMT_DATA="$CMT_BASE/data"
        fi
    fi

    # other defaults
    [ -z "$CMT_SOFTWARE" ] && export CMT_SOFTWARE="$CMT_DATA/software"
    [ -z "$CMT_STORE_LOCAL" ] && export CMT_STORE_LOCAL="$CMT_DATA/store"
    if [ -n "$CMT_CIEMAT_USER" ]; then
      [ -z "$CMT_STORE_EOS" ] && export CMT_STORE_EOS="/nfs/cms/$CMT_CIEMAT_USER/cmt"
    elif [ -n "$CMT_CERN_USER" ]; then
      [ -z "$CMT_STORE_EOS" ] && export CMT_STORE_EOS="/eos/user/${CMT_CERN_USER:0:1}/$CMT_CERN_USER/cmt"
    elif [ -n "$CMT_LLR_USER" ]; then
      if [ -z "$CMT_STORE_EOS" ]; then
        if [ "$CMT_LLR_USER" = "evernazza" ]; then
            # At LLR, Elena Vernazza's username is evernazza but her folder on data_CMS is named vernazza for some reason. So drop the first letter
            export CMT_STORE_EOS="/data_CMS/cms/${CMT_LLR_USER:1}/cmt"
        else
            export CMT_STORE_EOS="/data_CMS/cms/${CMT_LLR_USER}/cmt"
        fi
      fi
    fi
    
    [ -z "$CMT_STORE" ] && export CMT_STORE="$CMT_STORE_EOS"
    [ -z "$CMT_JOB_DIR" ] && export CMT_JOB_DIR="$CMT_DATA/jobs"
    [ -z "$CMT_TMP_DIR" ] && export CMT_TMP_DIR="$CMT_DATA/tmp"
    [ -z "$CMT_CMSSW_BASE" ] && export CMT_CMSSW_BASE="$CMT_DATA/cmssw"
    # [ -z "$CMT_SCRAM_ARCH" ] && export CMT_SCRAM_ARCH="slc7_amd64_gcc10"
    # [ -z "$CMT_CMSSW_VERSION" ] && export CMT_CMSSW_VERSION="CMSSW_12_3_0_pre6"
    [ -z "$CMT_SCRAM_ARCH" ] && export CMT_SCRAM_ARCH="el9_amd64_gcc12"
    [ -z "$CMT_CMSSW_VERSION" ] && export CMT_CMSSW_VERSION="CMSSW_15_0_3"
    [ -z "$CMT_PYTHON_VERSION" ] && export CMT_PYTHON_VERSION="3"

    # specific eos dirs
    [ -z "$CMT_STORE_EOS_PREPROCESSING" ] && export CMT_STORE_EOS_PREPROCESSING="$CMT_STORE_EOS"
    [ -z "$CMT_STORE_EOS_CATEGORIZATION" ] && export CMT_STORE_EOS_CATEGORIZATION="$CMT_STORE_EOS"
    [ -z "$CMT_STORE_EOS_MERGECATEGORIZATION" ] && export CMT_STORE_EOS_MERGECATEGORIZATION="$CMT_STORE_EOS"
    [ -z "$CMT_STORE_EOS_SHARDS" ] && export CMT_STORE_EOS_SHARDS="$CMT_STORE_EOS"
    [ -z "$CMT_STORE_EOS_EVALUATION" ] && export CMT_STORE_EOS_EVALUATION="$CMT_STORE_EOS"
    if [ -n "$CMT_CIEMAT_USER" ]; then
       if [ -n "$CMT_TMPDIR" ]; then
         export TMPDIR="$CMT_TMPDIR"
       else
         export TMPDIR="/nfs/scratch_cms/$CMT_CIEMAT_USER/cmt/tmp"
       fi
       mkdir -p "$TMPDIR"
    fi 
    if [ -n "$CMT_LLR_USER" ]; then
        if [[ "$( hostname )" = llruicms01.in2p3.fr ]]; then
         export TMPDIR="/scratch/$CMT_LLR_USER/cmt/tmp"
         export CMT_STORE_EOS_MERGECATEGORIZATION=$CMT_STORE_EOS
         mkdir -p "$CMT_STORE_EOS_MERGECATEGORIZATION"
        elif [[ "$( hostname )" = llrai01.in2p3.fr ]]; then
         if [ "$CMT_LLR_USER" = "evernazza" ]; then
         # At LLR, Mme Elena Vernazza's username is evernazza but her folder on data_CMS is named vernazza for some reason. So drop the first letter
          export TMPDIR="/aissd1/${CMT_LLR_USER:1}/cmt/tmp"
          export CMT_STORE_EOS_MERGECATEGORIZATION=$CMT_STORE_EOS
          echo "CMT_STORE_EOS_MERGECATEGORIZATION = $CMT_STORE_EOS_MERGECATEGORIZATION"
         else
          export TMPDIR="/aissd1/$CMT_LLR_USER/cmt/tmp"
          export CMT_STORE_EOS_MERGECATEGORIZATION="/aissd1/$CMT_LLR_USER/cmt"
         fi
         mkdir -p "$CMT_STORE_EOS_MERGECATEGORIZATION"
       else
        export TMPDIR=$CMT_TMP_DIR
       fi
       mkdir -p "$TMPDIR"
    fi 

    # create some dirs already
    mkdir -p "$CMT_TMP_DIR"


    #
    # helper functions
    #

    cmt_pip_install() {
        if [ "$CMT_PYTHON_VERSION" = "2" ]; then
            env pip install --ignore-installed --no-cache-dir --upgrade --prefix "$CMT_SOFTWARE" "$@"
        else
            env pip3 install --ignore-installed --no-cache-dir --upgrade --prefix "$CMT_SOFTWARE" "$@"
        fi
    }
    export -f cmt_pip_install

    cmt_add_py() {
        export PYTHONPATH="$1:$PYTHONPATH"
    }
    export -f cmt_add_py

    cmt_add_bin() {
        export PATH="$1:$PATH"
    }
    export -f cmt_add_bin

    cmt_add_lib() {
        export LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"
    }
    export -f cmt_add_lib

    cmt_add_root_inc() {
        export ROOT_INCLUDE_PATH="$ROOT_INCLUDE_PATH:$1"
    }
    export -f cmt_add_root_inc



    #
    # minimal software stack
    #

    # add this repo to PATH and PYTHONPATH
    cmt_add_bin "$CMT_BASE/bin"
    cmt_add_py "$CMT_BASE"
    cmt_add_py "$CMT_BASE/../"

    # variables for external software
    export GLOBUS_THREAD_MODEL="none"
    export CMT_GFAL_DIR="$CMT_SOFTWARE/gfal2"
    export GFAL_PLUGIN_DIR="$CMT_GFAL_DIR/lib/gfal2-plugins"

    # certificate proxy handling
    [ "$CMT_REMOTE_JOB" != "1" ] && export X509_USER_PROXY="$CMT_BASE/x509up"

    # software that is used in this project
    cmt_setup_software() {
        local origin="$( pwd )"
        local mode="$1"

        # remove software directories when forced
        if [ "$mode" = "force" ] || [ "$mode" = "force_cmssw" ]; then
            echo "remove CMSSW checkout in $CMT_CMSSW_BASE/$CMT_CMSSW_VERSION"
            rm -rf "$CMT_CMSSW_BASE/$CMT_CMSSW_VERSION"
        fi

        if [ "$mode" = "force" ] || [ "$mode" = "force_py" ]; then
            echo "remove software stack in $CMT_SOFTWARE"
            rm -rf "$CMT_SOFTWARE"
        fi

        if [ "$mode" = "force" ] || [ "$mode" = "force_gfal" ]; then
            echo "remove gfal installation in $CMT_GFAL_DIR"
            rm -rf "$CMT_GFAL_DIR"
        fi

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

        compile="0"
        export NANOTOOLS_PATH="PhysicsTools/NanoAODTools"
        if [ ! -d "$NANOTOOLS_PATH" ]; then
          git clone https://github.com/cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
          compile="1"
        fi

        export BASEMODULES_PATH="Base/Modules"
        if [ ! -d "$BASEMODULES_PATH" ]; then
          #git clone https://gitlab.cern.ch/cms-phys-ciemat/cmt-base-modules.git Base/Modules
          git clone https://gitlab.cern.ch/evernazz/cmt-base-modules.git Base/Modules
          compile="1"
        fi

        export BASEMODULES_PATH="Base/Filters"
        if [ ! -d "$BASEMODULES_PATH" ]; then
          git clone https://gitlab.cern.ch/tcuisset/event-filters.git Base/Filters
          #git clone https://gitlab.cern.ch/evernazz/cmt-base-modules.git Base/Modules
          compile="1"
        fi

        export HHKINFIT_PATH="HHKinFit2"
        if [ ! -d "$HHKINFIT_PATH" ]; then
          #git clone https://github.com/bvormwald/HHKinFit2.git -b CMSSWversion
          git clone https://github.com/elenavernazza/HHKinFit2.git -b CMSSWversion
          rm -r HHKinFit2/HHKinFit2CMSSWPlugins/plugins/
          compile="1"
        fi

        export SVFIT_PATH="TauAnalysis"
        if [ ! -d "$SVFIT_PATH" ]; then
          git clone https://github.com/LLRCMS/ClassicSVfit.git TauAnalysis/ClassicSVfit -b bbtautau_CCLUB
          git clone https://github.com/svfit/SVfitTF TauAnalysis/SVfitTF
          compile="1"
        fi

        export HTT_PATH="HTT-utilities"
        if [ ! -d "$HTT_PATH" ]; then
          git clone https://github.com/elenavernazza/LeptonEff-interface.git HTT-utilities
          cd HTT-utilities/LepEffInterface/
          rm -rf data
          git clone https://github.com/CMS-HTT/LeptonEfficiencies.git data
          cd "$CMT_CMSSW_BASE/$CMT_CMSSW_VERSION/src"
          mkdir TauAnalysisTools
          git clone -b run2_SFs https://github.com/cms-tau-pog/TauTriggerSFs TauAnalysisTools/TauTriggerSFs
          rm TauAnalysisTools/TauTriggerSFs/python/*.py
          cd TauAnalysisTools/TauTriggerSFs/data
          wget https://github.com/camendola/VBFTriggerSFs/raw/master/data/2017_VBFHTauTauTrigger_JetLegs.root
          wget https://github.com/camendola/VBFTriggerSFs/raw/master/data/2018_VBFHTauTauTrigger_JetLegs.root
          cd "$CMT_CMSSW_BASE/$CMT_CMSSW_VERSION/src"
          compile="1"
        fi

        export HHBTAG_PATH="HHTools"
        if [ ! -d "$HHBTAG_PATH" ]; then
          git clone https://github.com/hh-italian-group/HHbtag.git HHTools/HHbtag
          #git clone https://github.com/jaimeleonh/InferenceTools.git Tools/Tools
          git clone https://github.com/tcuisset/InferenceTools.git Tools/Tools
          git clone https://gitlab.cern.ch/hh/bbtautau/MulticlassInference
          #git clone https://github.com/GilesStrong/cms_hh_proc_interface.git
          #git clone https://github.com/elenavernazza/cms_hh_proc_interface.git # not used anymore with ONNX inference
            #   cd cms_hh_proc_interface
            #   git checkout tags/V4.0
            #   cd -
        #   git clone https://github.com/GilesStrong/cms_hh_tf_inference.git
        #   cd cms_hh_tf_inference/inference
        #   echo '<use name="boost_filesystem"/>' | cat - BuildFile.xml > temp && mv temp BuildFile.xml
        #   cd -
          #git clone https://github.com/GilesStrong/cms_runII_dnn_models.git
          git clone https://github.com/elenavernazza/cms_runII_dnn_models.git
          cd cms_runII_dnn_models/models/test/
          mv test.cc test.cc_x
          cd -
          compile="1"
        fi

        export CORRECTIONS_PATH="Corrections"
        cmt_add_root_inc $(correction config --incdir)
        if [ ! -d "$CORRECTIONS_PATH" ]; then
          git clone https://github.com/jaimeleonh/correctionlib-wrapper --branch cmssw_version  Corrections/Wrapper
          #git clone https://gitlab.cern.ch/cms-phys-ciemat/tau-corrections.git Corrections/TAU
          git clone https://gitlab.cern.ch/evernazz/tau-corrections.git Corrections/TAU

          #git clone https://gitlab.cern.ch/cms-phys-ciemat/jme-corrections.git Corrections/JME
          git clone https://gitlab.cern.ch/evernazz/jme-corrections.git Corrections/JME
          cd Corrections/JME/data
          wget https://github.com/cms-jet/JECDatabase/raw/master/tarballs/Summer19UL18_V5_MC.tar.gz
          wget https://github.com/cms-jet/JECDatabase/raw/master/tarballs/Summer19UL17_V5_MC.tar.gz
          wget https://github.com/cms-jet/JECDatabase/raw/master/tarballs/Summer19UL16_V7_MC.tar.gz
          wget https://github.com/cms-jet/JECDatabase/raw/master/tarballs/Summer19UL16APV_V7_MC.tar.gz
          cd -

          #git clone https://gitlab.cern.ch/cms-phys-ciemat/lum-corrections.git Corrections/LUM
          git clone https://gitlab.cern.ch/evernazz/lum-corrections.git Corrections/LUM
          #git clone https://gitlab.cern.ch/cms-phys-ciemat/muo-corrections.git Corrections/MUO
          git clone https://gitlab.cern.ch/evernazz/muo-corrections.git Corrections/MUO
          #git clone https://gitlab.cern.ch/cms-phys-ciemat/egm-corrections.git Corrections/EGM
          git clone https://gitlab.cern.ch/evernazz/egm-corrections.git Corrections/EGM
          # Add the JSON for scale uncertainties (fix for Run2 because egamma made a mess with nanoaod)
          # also for some reason they are not on CVMFS ? (at least I could not find them)
          mkdir Corrections/EGM/data
          git clone --depth=1 https://github.com/cms-egamma/ScaleFactorsJSON.git Corrections/EGM/data/ScaleUncertainties
          
          #git clone https://gitlab.cern.ch/cms-phys-ciemat/btv-corrections.git Corrections/BTV
          git clone https://gitlab.cern.ch/evernazz/btv-corrections.git Corrections/BTV
          compile="1"
        fi

        if [ "$compile" == "1" ]
        then
            scram b
        fi

        #export COMBINE_PATH="HiggsAnalysis/CombinedLimit"
        #if [ ! -d "$COMBINE_PATH" ]; then
        #    git clone https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit.git $COMBINE_PATH
        #    cd $COMBINE_PATH
        #    git checkout v8.0.1
        #    cd -
        #    scram b -j5
        #fi
        eval `scramv1 runtime -sh`
        cd "$origin"

        # get the python version
        if [ "$CMT_PYTHON_VERSION" = "2" ]; then
            local pyv="$( python -c "import sys; print('{0.major}.{0.minor}'.format(sys.version_info))" )"
        else
            local pyv="$( python3 -c "import sys; print('{0.major}.{0.minor}'.format(sys.version_info))" )"
        fi

        # ammend software paths
        cmt_add_bin "$CMT_SOFTWARE/bin"
        # Adding a directory in PYTHON3PATH will lead to the CMSSW sitecustomize.py (located at /cvmfs/cms.cern.ch/slc7_amd64_gcc10/external/python3/3.9.6-67e5cf5b4952101922f1d4c8474baa39/lib/python3.9/sitecustomize.py)
        # to run site.addsitedir($CMT_SOFTWARE), which will add it to sys.path as well as load any .pth file therein
        # this will allow for example pip editable installs to work properly (pip install -e )
        # We need to put our site-packages in front otherwise python will prefer CMSSW-provided packages rather than our own
        export PYTHON3PATH="$CMT_SOFTWARE/lib/python$pyv/site-packages:$CMT_SOFTWARE/lib64/python$pyv/site-packages:$PYTHON3PATH"
        # cmt_add_py "$CMT_SOFTWARE/lib/python$pyv/site-packages:$CMT_SOFTWARE/lib64/python$pyv/site-packages"


        # setup custom software
        if [ ! -d "$CMT_SOFTWARE" ]; then
            echo "installing software stack at $CMT_SOFTWARE"
            mkdir -p "$CMT_SOFTWARE"

            cmt_pip_install pip
            cmt_pip_install flake8
            cmt_pip_install luigi==2.8.13
            cmt_pip_install tabulate
            #cmt_pip_install git+https://gitlab.cern.ch/cms-phys-ciemat/analysis_tools.git
            cmt_pip_install git+https://gitlab.cern.ch/tcuisset/analysis_tools.git
            #cmt_pip_install git+https://gitlab.cern.ch/cms-phys-ciemat/plotting_tools.git
            cmt_pip_install git+https://gitlab.cern.ch/evernazz/plotting_tools.git
            cmt_pip_install --no-deps git+https://github.com/riga/law
            cmt_pip_install --no-deps git+https://github.com/riga/plotlib
            cmt_pip_install --no-deps gast==0.2.2  # https://github.com/tensorflow/autograph/issues/1
            # cmt_pip_install sphinx==5.2.2 # for documentation only 
            # cmt_pip_install sphinx_rtd_theme
            # cmt_pip_install sphinx_design
            cmt_pip_install envyaml
        fi

        # gfal python bindings
        cmt_add_bin "$CMT_GFAL_DIR/bin"
        cmt_add_py "$CMT_GFAL_DIR/lib/python3/site-packages"
        cmt_add_lib "$CMT_GFAL_DIR/lib"

        # if [ ! -d "$CMT_GFAL_DIR" ]; then
        #     no clue what this is supposed to do
        #     local lcg_base="/cvmfs/grid.cern.ch/centos7-ui-4.0.3-1_umd4v3/usr"
        #     if [ ! -d "$lcg_base" ]; then
        #         2>&1 echo "LCG software directory $lcg_base not existing"
        #         return "1"
        #     fi

        #     mkdir -p "$CMT_GFAL_DIR"
        #     (
        #         cd "$CMT_GFAL_DIR"
        #         mkdir -p include bin lib/gfal2-plugins lib/python3/site-packages
        #         ln -s "$lcg_base"/include/gfal2* include
        #         ln -s "$lcg_base"/bin/gfal-* bin
        #         ln -s "$lcg_base"/lib64/libgfal* lib
        #         ln -s "$lcg_base"/lib64/gfal2-plugins/libgfal* lib/gfal2-plugins
        #         ln -s "$lcg_base"/lib64/python3/site-packages/gfal* lib/python3/site-packages
        #         cd lib/gfal2-plugins
        #         rm libgfal_plugin_http.so libgfal_plugin_xrootd.so
        #         curl https://cernbox.cern.ch/index.php/s/qgrogVY4bwcuCXt/download > libgfal_plugin_xrootd.so
        #     )
        # fi
    }
    export -f cmt_setup_software

    # setup the software initially when no explicitly skipped
    if [ "$CMT_SKIP_SOFTWARE" != "1" ]; then
        if [ "$CMT_FORCE_SOFTWARE" = "1" ]; then
            cmt_setup_software force
        else
            if [ "$CMT_FORCE_CMSSW" = "1" ]; then
                cmt_setup_software force_cmssw
            else
                cmt_setup_software silent
            fi
        fi
    fi


    #
    # law setup
    #

    export LAW_HOME="$CMT_DATA/law"
    export LAW_CONFIG_FILE="$CMT_BASE/../law.cfg"
    [ -z "$CMT_SCHEDULER_PORT" ] && export CMT_SCHEDULER_PORT="80"
    if [ -z "$CMT_LOCAL_SCHEDULER" ]; then
        if [ -z "$CMT_SCHEDULER_HOST" ]; then
            export CMT_LOCAL_SCHEDULER="True"
        else
            export CMT_LOCAL_SCHEDULER="False"
        fi
    fi
    if [ -z "$CMT_LUIGI_WORKER_KEEP_ALIVE" ]; then
        if [ "$CMT_REMOTE_JOB" = "0" ]; then
            export CMT_LUIGI_WORKER_KEEP_ALIVE="False"
        else
            export CMT_LUIGI_WORKER_KEEP_ALIVE="False"
        fi
    fi

    # try to source the law completion script when available
    which law &> /dev/null && source "$( law completion )" ""

    # setup python virtual environment if not yet existing
    if [ ! -d "../.venv" ]; then
        (
        set -x
        cd .. # go back to upper folder (not nanoaod_base_analysis)
        python3 -m venv --system-site-packages .venv
        cd .venv/bin
        mv python3 python3_symlink
        cat <<"EOF" >python
#!/bin/bash
# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/../.."
source setup.sh
cd - >/dev/null

exec "$SCRIPT_DIR/python3_symlink" "$@"
EOF
        chmod +x ./python
        )
    fi

}
action "$@"
cd ..
#voms-proxy-init --voms cms -valid 192:0
