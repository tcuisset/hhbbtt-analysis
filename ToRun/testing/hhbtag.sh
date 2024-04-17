
# law run PreprocessRDFWrapper --version prod_240305 --category-names base_selection --config-name ul_2017_ZbbHtt_v12 \
#  --skip-dataset-tags secondary \
#  --PreprocessRDF-modules-file modulesrdf \
#  --PreprocessRDF-keep-and-drop-file keep_and_drop_file

CMT_STORE_EOS_PREPROCESSING=/scratch/cuisset/cmt/test_hhbtag
law run PreprocessRDF --version prod_240416_hhbtagv2 --category-name base_selection --config-name ul_2018_ZbbHtt_v12 \
 --dataset-name tt_sl \
 --PreprocessRDF-keep-and-drop-file keep_and_drop_file --PreprocessRDF-modules-file modulesrdf_HHbtag_v2_only --workers 20 --print-status 1
