# Make symbolic links specific to Théo : link ZH specific datasets back to ZZ folder in Elena's dir

# # To copy PreprocessRDF from Théo: /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_2018_ZZ_v12/dy/cat_base_selection/prod_241213c
# step="PreprocessRDF"
# cat="cat_base_selection"
# prd="prod_241213c"

# To copy MergeCategorizationStats from Théo: /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/bul_2018_ZZ_v12/dy/prod_241024
step="MergeCategorizationStats"
cat=""
prd="prod_241024"

for year in 2018; do
    for process in `ls /data_CMS/cms/cuisset/cmt/${step}/bul_${year}_ZZ_v12` ; do

        mkdir -p /data_CMS/cms/vernazza/cmt/${step}/bul_${year}_ZZ_v12/
        mkdir -p /data_CMS/cms/vernazza/cmt/${step}/bul_${year}_ZZ_v12/${process}/
        mkdir -p /data_CMS/cms/vernazza/cmt/${step}/bul_${year}_ZZ_v12/${process}/${cat}/

        source_dir="/data_CMS/cms/cuisset/cmt/${step}/bul_${year}_ZZ_v12/${process}/${cat}/${prd}/"
        target_link="/data_CMS/cms/vernazza/cmt/${step}/bul_${year}_ZZ_v12/${process}/${cat}/${prd}"

        if [ -d "${source_dir}" ] && [ ! -L "${target_link}" ]; then
            ln -s "${source_dir}" "${target_link}"
            echo "Symbolic link created: ${target_link}"
        elif [ -L "${target_link}" ]; then
            echo "Symbolic link already exists: ${target_link}. Skipping link creation."
        else
            echo "Warning: Directory ${source_dir} does not exist. Skipping symbolic link creation."
        fi

    done
done


# for year in 2018; do
#     for process in `ls /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_${year}_ZZ_v12` ; do

#         mkdir -p /data_CMS/cms/vernazza/cmt/PreprocessRDF/bul_${year}_ZZ_v12/$process/
#         mkdir -p /data_CMS/cms/vernazza/cmt/PreprocessRDF/bul_${year}_ZZ_v12/$process/cat_base_selection/

#         source_dir="/data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_${year}_ZZ_v12/$process/cat_base_selection/prod_241213c/"
#         target_link="/data_CMS/cms/vernazza/cmt/PreprocessRDF/bul_${year}_ZZ_v12/$process/cat_base_selection/prod_241213c"

#         echo $source_dir
#         echo $target_link

#         if [ -d "$source_dir" ]; then
#             ln -s "$source_dir" "$target_link"
#         else
#             echo "Warning: Directory $source_dir does not exist. Skipping symbolic link creation."
#         fi
#     done
# done

# for year in 2018; do
#     for process in `ls /data_CMS/cms/cuisset/cmt/PreprocessRDF/bul_$year\_ZZ_v12` ; do
#         unlink /data_CMS/cms/vernazza/cmt/PreprocessRDF/bul_$year\_ZZ_v12/$process/cat_base_selection/prod_241213c
#     done
# done

# 2018 2017 2016 2016_HIPM

# for year in 2016; do
#     cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12
#     for process in zh_zbb_htt_signal zh_zbb_htt_background zz_sl; do
#         ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12/$process/ $process
#     done 
#     # symbolic link for zh_zbb_htt (Z->bb,H->tautau as bkg of resonant ZbbHtt analysis) which is the same dataset as zh_zbb_htt_signal (but process.isSignal=False)
#     ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZbbHtt_v12/zh_zbb_htt_signal/ zh_zbb_htt

#     cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12
#     for process in zh_ztt_hbb_signal zh_ztt_hbb_background zz_sl; do
#         ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12/$process/ $process
#     done 
#     # symbolic link for zh_ztt_hbb (Z->tautau,H->bb as bkg of resonant ZttHbb analysis) which is the same dataset as zh_ztt_hbb_signal (but process.isSignal=False)
#     ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12/zh_ztt_hbb_signal/ zh_ztt_hbb

#     cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12
#     for process in zh_zbb_htt_signal zh_zbb_htt_background zz_sl; do
#         ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/$process\_aux/ $process\_aux
#     done 
#     ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZbbHtt_v12/zh_zbb_htt_signal_aux/ zh_zbb_htt_aux

#     cd /data_CMS/cms/cuisset/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12
#     for process in zh_ztt_hbb_signal zh_ztt_hbb_background zz_sl; do
#         ln -s /data_CMS/cms/vernazza/cmt/MergeCategorizationStats/ul_$year\_ZttHbb_v12/$process\_aux/ $process\_aux
#     done 

# done

# for year in 2018 2017 2016 2016_HIPM; do
# cd /data_CMS/cms/cuisset/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12
# rm zh_ztt_hbb
# ln -s /data_CMS/cms/vernazza/cmt/PreprocessRDF/ul_$year\_ZttHbb_v12/zh_ztt_hbb_signal/ zh_ztt_hbb
# done


# cd /scratch/cuisset/cmt/MergeCategorization

# for path_base in ul_*_v12/*/cat_*_elliptical_cut_*; do
#     # mv $path_base/prod_240329_resDNN $path_base/prod_240329
# done
