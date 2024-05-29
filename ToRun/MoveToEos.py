import os

'''
python3 MoveToEos.py --region CR --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_CR_resolved_1b,cat_ZZ_elliptical_cut_90_CR_resolved_2b,cat_ZZ_elliptical_cut_90_CR_boosted_noPNet,cat_ZZ_elliptical_cut_90_CR_sr \
    --prd prod_240522 --grp zz
python3 MoveToEos.py --region CR --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_base --prd prod_240527 --grp zz
python3 MoveToEos.py --region SR --type NonRes --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_resolved_1b,cat_ZZ_elliptical_cut_90_resolved_2b,cat_ZZ_elliptical_cut_90_boosted_noPNet \
    --prd prod_240522 --grp zz
python3 MoveToEos.py --region SR --type Res --ver ul_2016_ZZ_v12,ul_2016_HIPM_ZZ_v12,ul_2017_ZZ_v12,ul_2018_ZZ_v12 \
    --cat cat_ZZ_elliptical_cut_90_resolved_1b,cat_ZZ_elliptical_cut_90_resolved_2b,cat_ZZ_elliptical_cut_90_boosted_noPNet \
    --prd prod_240528 --grp zz_res
'''

if __name__ == "__main__" :

    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("--region",       dest="region",       default='SR',             choices=["SR", "CR"],       help="Output folder in CRPlots (CR) or SRPlots (SR)")
    parser.add_option("--type",         dest="type",         default='NonRes',         choices=["Res", "NonRes"],  help="Resonant (Res) or NonResonant (NonRes)")
    parser.add_option("--ver",          dest="ver",          default='')
    parser.add_option("--cat",          dest="cat",          default='')
    parser.add_option("--prd",          dest="prd",          default='')
    parser.add_option("--grp",          dest="grp",          default='')
    parser.add_option("--user_eos",     dest="user_eos",     default='evernazz',       help='User Name for lxplus account')
    (options, args) = parser.parse_args()

    if ',' in options.ver:  versions = options.ver.split(',')
    else:                   versions = [options.ver]
    
    if ',' in options.cat:  categories = options.cat.split(',')
    else:                   categories = [options.cat]

    prd = options.prd
    grp = options.grp
    
    if "ZZ" in options.ver:       o_name = 'ZZbbtt'
    elif "ZbbHtt" in options.ver: o_name = 'ZbbHtt'
    elif "ZttHbb" in options.ver: o_name = 'ZttHbb'

    if os.environ["USER"] == 'evernazza':
        cmtdir = '/data_CMS/cms/' + os.environ["USER"][1:] + '/cmt/FeaturePlot/'
    else:
        cmtdir = '/data_CMS/cms/' + os.environ["USER"] + '/cmt/FeaturePlot/'

    if options.region == "SR": eos_dir = f'/eos/user/e/evernazz/www/ZZbbtautau/B2GPlots/2024_06_14/{o_name}/{options.region}Plots/{options.type}'
    else:                      eos_dir = f'/eos/user/e/evernazz/www/ZZbbtautau/B2GPlots/2024_06_14/{o_name}/{options.region}Plots'

    user = options.user_eos
    print(f" ### INFO: Copy results to {user}@lxplus.cern.ch")
    print(f"           Inside directory {eos_dir}\n")

    # [FIXME] Work-around for mkdir on eos
    index = os.path.dirname(os.path.realpath(__file__)) + '/index.php'
    os.system(f'mkdir -p TMP_PLOTS && cp {index} TMP_PLOTS')
    for category in categories:
        os.system(f'mkdir -p TMP_PLOTS/{category} && cp {index} TMP_PLOTS/{category}')
        for version in versions:
            year = version.split("ul_")[1].split("_Z")[0]
            os.system(f'mkdir -p TMP_PLOTS/{category}/{year} && cp {index} TMP_PLOTS/{category}/{year}')
            for ch in ['etau', 'mutau', 'tautau']:
                os.system(f'mkdir -p TMP_PLOTS/{category}/{year}/{ch} && cp {index} TMP_PLOTS/{category}/{year}/{ch}')
                if options.region == "CR":
                    os.system(f'cp ' + cmtdir + f'/{version}/{category}/{prd}/*{ch}_os_iso_*_pg_{grp}__qcd__stack* TMP_PLOTS/{category}/{year}/{ch}') 
                else:
                    os.system(f'cp ' + cmtdir + f'/{version}/{category}/{prd}/*{ch}_os_iso_*_pg_{grp}__* TMP_PLOTS/{category}/{year}/{ch}') 
    os.system(f'rsync -rltv TMP_PLOTS/* {user}@lxplus.cern.ch:{eos_dir}')
    os.system(f'rm -r TMP_PLOTS')


# cern_user = 'evernazz'
# os.system(f"/opt/exp_soft/cms/t3/eos-login -init -username {cern_user}")
# output = '/eos/home-e/evernazz/www/ZZbbtautau/B2GPlots/2024_04_05/DataMC_CR_ZZ'
# index = '/eos/home-e/evernazz/www/ZZbbtautau/B2GPlots/2024_04_05/DataMC_CR_ZZ/index.php'

# input = '/data_CMS/cms/vernazza/cmt/FeaturePlot/'
# # cat_name = 'cat_base'
# cat_name = 'cat_ZZ_elliptical_cut_90_CR'

# for year in ['2016', '2016_HIPM', '2017', '2018']:
#     for ch in ['etau', 'mutau', 'tautau']:
#         input_f = f'{input}/ul_{year}_ZZ_v12/{cat_name}_{ch}/prod_240403/'

#         os.system(f'mkdir -p {output}/{year}/{cat_name}_{ch}')
#         os.system(f'cp {index} {output}/{year}')
#         os.system(f'cp {index} {output}/{year}/{cat_name}_{ch}')

#         print(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')
#         os.system(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')

# cern_user = 'evernazz'
# os.system(f"/opt/exp_soft/cms/t3/eos-login -init -username {cern_user}")
# output = '/eos/home-e/evernazz/www/ZZbbtautau/B2GPlots/2024_04_05/SR_ZZbbtt'
# index = output + '/index.php'

# input = '/data_CMS/cms/vernazza/cmt/FeaturePlot/'
# # cat_name = 'cat_base'
# cat_name = 'cat_ZZ_elliptical_cut_90'

# for year in ['2016', '2016_HIPM', '2017', '2018']:
#     for ch in ['etau', 'mutau', 'tautau']:
#         input_f = f'{input}/ul_{year}_ZZ_v12/{cat_name}_{ch}/prod_240403/'

#         os.system(f'mkdir -p {output}/{year}/{cat_name}_{ch}')
#         os.system(f'cp {index} {output}/{year}')
#         os.system(f'cp {index} {output}/{year}/{cat_name}_{ch}')

#         print(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')
#         os.system(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')
