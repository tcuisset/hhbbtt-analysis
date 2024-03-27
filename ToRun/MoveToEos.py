import os

cern_user = 'evernazz'
os.system(f"/opt/exp_soft/cms/t3/eos-login -init -username {cern_user}")
output = '/eos/home-e/evernazz/www/ZZbbtautau/DataMC_ZZ'
index = '/eos/home-e/evernazz/www/ZZbbtautau/DataMC_ZZ/index.php'

input = '/data_CMS/cms/vernazza/cmt/FeaturePlot/'

for year in ['2016', '2016_HIPM', '2017', '2018']:
    for ch in ['etau', 'mutau', 'tautau']:
        input_f = f'{input}/ul_{year}_ZZ_v12/cat_ZZ_elliptical_cut_90_CR_{ch}/prod_240318/'

        os.system(f'mkdir -p {output}/{year}/cat_ZZ_elliptical_cut_90_CR_{ch}')
        os.system(f'cp {index} {output}/{year}')
        os.system(f'cp {index} {output}/{year}/cat_ZZ_elliptical_cut_90_CR_{ch}')

        print(f'cp {input}/ul_{year}_ZZ_v12/cat_ZZ_elliptical_cut_90_CR_{ch}/prod_240318/*_os_iso_* {output}/{year}/cat_ZZ_elliptical_cut_90_CR_{ch}')
        os.system(f'cp {input}/ul_{year}_ZZ_v12/cat_ZZ_elliptical_cut_90_CR_{ch}/prod_240318/*_os_iso_* {output}/{year}/cat_ZZ_elliptical_cut_90_CR_{ch}')
