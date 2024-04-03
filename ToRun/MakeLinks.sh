####################################################################################
# ZbbHtt
####################################################################################

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2018_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2018_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2018_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2017_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2017_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2017_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_HIPM_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_HIPM_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2016_HIPM_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done
mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2016_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2018_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2018_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2018_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2017_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2017_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2017_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_HIPM_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_HIPM_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2016_HIPM_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_ZbbHtt_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2016_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

####################################################################################
# ZttHbb
####################################################################################

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2018_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2018_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2018_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2017_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2017_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2017_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_HIPM_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_HIPM_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2016_HIPM_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/ul_2016_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_2016_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2018_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2018_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2018_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2017_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2017_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2017_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_HIPM_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_HIPM_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2016_HIPM_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

mkdir /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/ul_2016_ZttHbb_v12
for process_dir in /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_2016_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == ggXZZbbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
        ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
done 

####################################################################################
# Testing resonant samples
####################################################################################

mkdir 
cp /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/jobs/Zprime_v3/Zprime_Zh_Zbbhtautau_M500/Step_5
local:root://eos.grif.fr///eos/grif/cms/llr/store/user/evernazz/MiniAOD/Zprime/Step_5
gfal-mkdir https://eos.grif.fr:11000//eos/grif/cms/llr/store/user/evernazz/MiniAOD/Zprime

law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZZ_v12 \
 --dataset-names zz_sl_signal,zz_sl_background,zh_htt,zh_hbb_zll,zz_bbtt,wjets_ht1,wjets_ht2,wjets_ht3,wjets_ht4,wjets_ht5,wjets_ht6,wjets_ht7,wjets_ht8,dy,dy_ptz1,dy_ptz2,dy_ptz3,dy_ptz4,dy_ptz5,dy_ptz6,dy_0j,dy_1j,dy_2j \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 10 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=long,WNTag=el7'

law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2018_ZbbHtt_v12 \
 --skip-dataset-tags secondary,res  \
 --PreprocessRDF-modules-file modulesrdf \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --workers 50 \
 --PreprocessRDF-workflow htcondor --PreprocessRDF-htcondor-scheduler llrt3condor.in2p3.fr --PreprocessRDF-transfer-logs \
 --PreprocessRDF-custom-condor-tag 'include : /opt/exp_soft/cms/t3/t3queue |,T3queue=short,WNTag=el7'

