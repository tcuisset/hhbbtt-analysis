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
env pip3 install --ignore-installed --no-cache-dir --upgrade --prefix "$CMT_SOFTWARE" -e /home/llr/cms/cuisset/bbtautau/ZHbbtautau/frameworkDev/analysis_tools
~~~