import os

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

cern_user = 'evernazz'
os.system(f"/opt/exp_soft/cms/t3/eos-login -init -username {cern_user}")
output = '/eos/home-e/evernazz/www/ZZbbtautau/B2GPlots/2024_04_05/SR_ZZbbtt'
index = output + '/index.php'

input = '/data_CMS/cms/vernazza/cmt/FeaturePlot/'
# cat_name = 'cat_base'
cat_name = 'cat_ZZ_elliptical_cut_90'

for year in ['2016', '2016_HIPM', '2017', '2018']:
    for ch in ['etau', 'mutau', 'tautau']:
        input_f = f'{input}/ul_{year}_ZZ_v12/{cat_name}_{ch}/prod_240403/'

        os.system(f'mkdir -p {output}/{year}/{cat_name}_{ch}')
        os.system(f'cp {index} {output}/{year}')
        os.system(f'cp {index} {output}/{year}/{cat_name}_{ch}')

        print(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')
        os.system(f'cp {input_f}/*_{ch}_os_iso_* {output}/{year}/{cat_name}_{ch}')
