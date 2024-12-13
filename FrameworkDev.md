# Framwork development README
## Editable installs of Python packages
I replaced these lines in `setup.sh`:
~~~bash
# Adding a directory in PYTHON3PATH will lead to the CMSSW sitecustomize.py (located at /cvmfs/cms.cern.ch/slc7_amd64_gcc10/external/python3/3.9.6-67e5cf5b4952101922f1d4c8474baa39/lib/python3.9/sitecustomize.py)
# to run site.addsitedir($CMT_SOFTWARE), which will add it to sys.path as well as load any .pth file therein
# this will allow for example pip editable installs to work properly (pip install -e )
export PYTHON3PATH="$PYTHON3PATH:$CMT_SOFTWARE/lib/python$pyv/site-packages:$CMT_SOFTWARE/lib64/python$pyv/site-packages"
# cmt_add_py "$CMT_SOFTWARE/lib/python$pyv/site-packages:$CMT_SOFTWARE/lib64/python$pyv/site-packages"
~~~

Then you can run (replacing then path to your local clone) : 
~~~bash
env pip3 install --ignore-installed --no-cache-dir --upgrade --prefix "$CMT_SOFTWARE" -e /grid_mnt/vol_home/llr/cms/cuisset/bbtautau/ZHbbtautau/frameworkDev/analysis_tools
~~~

## Python profiling
~~~

python3 -m cProfile -o preplot.prof $(which law) run PrePlot --version prod_240725_test --MergeCategorization-version prod_240725  --config-name ul_2018_ZZ_v12 \
 --category-name ZZ_elliptical_cut_90_resolved_1b  --dataset-name tt_sl --feature-tags base,cat  \
  --branch 0
~~~

## C++ profiling
Use `--instr-atstart=no`to avoid profiling on startup
~~~bash
scram b clean
USER_CXXFLAGS="-g -O0" scram b 
valgrind --tool=callgrind --instr-atstart=no law run Categorization --version prod_240430_callgrind --category-name ZbbHtt_elliptical_cut_90 --config-name ul_2018_ZbbHtt_v12 \
 --dataset-name tt_sl \
 --PreprocessRDF-version prod_240305 \
 --Categorization-base-category-name base_selection \
 --Categorization-feature-modules-file modulesrdf_ZHresonant_syst --workers 1 --branch 0


callgrind_control -i on
~~~

## Performance bottlnecks
### PrePlot
Main bottleneck is task creation time. Comes from `fnmatch` calls from "exclude_params" checks on `Task.vreq` calls, and from luigi config parser.

## Proper error handling
It is important to properly handle errors that can happen in a task, so that an output is **not** created when a task crashes. If an output is created, it will likely be corrupted but law/luigi will not notice and consider the task as done.
In a `Task.run`method wrapped in `localize` decorator, raising any subclass of `Exception` (or ̀ KeyboardInterrupt`) will correctly recognize the failure and not move the tmp file to the final location (see `localize_file_targets` in `law.target.file`).
Doing `sys.exit(1)` will not work as it raises `SystemExit` which only derives from `BaseException`.
