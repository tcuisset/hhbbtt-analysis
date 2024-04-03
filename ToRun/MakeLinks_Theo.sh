# Make symbolic links specific to Théo : link ZH specific datasets back to ZZ folder in Elena's dir

# 2018 2017 2016 2016_HIPM

for year in 2016; do
    cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12
    for process in zh_zbb_htt_signal zh_zbb_htt_background zz_sl; do
        ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12/$process/ $process
    done 
    # symbolic link for zh_zbb_htt (Z->bb,H->tautau as bkg of resonant ZbbHtt analysis) which is the same dataset as zh_zbb_htt_signal (but process.isSignal=False)
    ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12/zh_zbb_htt_signal/ zh_zbb_htt

    cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12
    for process in zh_ztt_hbb_signal zh_ztt_hbb_background zz_sl; do
        ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12/$process/ $process
    done 
    # symbolic link for zh_ztt_hbb (Z->tautau,H->bb as bkg of resonant ZttHbb analysis) which is the same dataset as zh_ztt_hbb_signal (but process.isSignal=False)
    ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12/zh_ztt_hbb_signal/ zh_ztt_hbb

    cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12
    for process in zh_zbb_htt_signal zh_zbb_htt_background zz_sl; do
        ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/$process\_aux/ $process\_aux
    done 
    ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/zh_zbb_htt_signal_aux/ zh_zbb_htt_aux

    cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12
    for process in zh_ztt_hbb_signal zh_ztt_hbb_background zz_sl; do
        ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12/$process\_aux/ $process\_aux
    done 

done

# for year in 2018 2017 2016 2016_HIPM; do
# cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12
# ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12/zh_ztt_hbb_signal/ zh_ztt_hbb
# done


