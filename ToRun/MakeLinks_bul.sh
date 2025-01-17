# Making symbolic links for ZH
# Several things to do : 
# - link all ZZ/ZH common backgrounds ; ZbbHtt->ZZ & ZttHbb->ZZ
# - link all ZttHbb signal datasets (& ZZ bkg) to ZbbHtt datasets : ZttHbb->ZbbHtt 

set -e

# username to look for ZZ datasets
ZZ_USER=cuisset
YEAR=2017


# Link common backgrounds from ZbbHtt to ZZ
mkdir -p /data_CMS/cms/$USER/cmt/PreprocessRDF/bul_${YEAR}_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/bul_${YEAR}_ZbbHtt_v12
for process_dir in /data_CMS/cms/$ZZ_USER/cmt/PreprocessRDF/bul_${YEAR}_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == GluGluToXToZZ* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
    if [[ ! $(basename $process_dir) == zh_* ]]; then
         ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
    fi
done 

# we could make symbolic link for zh_zbb_htt (Z->bb,H->tautau as bkg of resonant ZbbHtt analysis) which is the same dataset as zh_zbb_htt_signal (but process.isSignal=False)
# but it is easier to just run preprocess twice


# Link everything in ZttHbb to ZbbHtt
mkdir -p /data_CMS/cms/$USER/cmt/PreprocessRDF/bul_${YEAR}_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/PreprocessRDF/bul_${YEAR}_ZttHbb_v12
for process_dir in /data_CMS/cms/$USER/cmt/PreprocessRDF/bul_${YEAR}_ZbbHtt_v12/*; do
    if [ ! -f $(basename $process_dir) ]; then
    ln -s $process_dir $(basename $process_dir)
    fi
done

#### MergeCategorizationStats linking
# Link common backgrounds from ZbbHtt to ZZ
mkdir -p /data_CMS/cms/$USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZbbHtt_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZbbHtt_v12
for process_dir in /data_CMS/cms/$ZZ_USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZZ_v12/*; do
    if [[ ! $(basename $process_dir) == GluGluToXToZZ* ]]; then
    if [[ ! $(basename $process_dir) == zz_bbtt* ]]; then
    if [[ ! $(basename $process_dir) == zz_sl_* ]]; then # exluce zz_sl_signal and zz_sl_background
    if [[ ! $(basename $process_dir) == zh_* ]]; then
         ln -s $process_dir $(basename $process_dir)
    fi
    fi
    fi
    fi
done 


# Link everything in ZttHbb to ZbbHtt
mkdir -p /data_CMS/cms/$USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZttHbb_v12
cd /data_CMS/cms/$USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZttHbb_v12
for process_dir in /data_CMS/cms/$USER/cmt/MergeCategorizationStats/bul_${YEAR}_ZbbHtt_v12/*; do
    if [ ! -f $(basename $process_dir) ]; then
    ln -s $process_dir $(basename $process_dir)
    fi
done



    # cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12
    # for process in zh_zbb_htt_signal zh_zbb_htt_background zz_sl; do
    #     ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/$process\_aux/ $process\_aux
    # done 
    # ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/zh_zbb_htt_signal_aux/ zh_zbb_htt_aux

    # cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12
    # for process in zh_ztt_hbb_signal zh_ztt_hbb_background zz_sl; do
    #     ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12/$process\_aux/ $process\_aux
    # done 
