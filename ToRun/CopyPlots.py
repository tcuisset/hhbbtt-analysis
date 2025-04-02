import sys,os

def GetYear(year):
    if '2016_HIPM' in year: return '2016_HIPM'
    elif '2016' in year: return '2016'
    elif '2017' in year: return '2017'
    elif '2018' in year: return '2018'
    else: sys.exit(f'Year {year} not valid')

def GetCat(cat):
    if 'resolved_1b' in cat: return 'resolved_1b'
    elif 'resolved_2b' in cat: return 'resolved_2b'
    elif 'boosted_bb_HPSTau' in cat: return 'boosted_bb'
    elif 'boosted_bb_boostedTau' in cat: return 'boosted_bb_boostedTau'

def GetProc(proc):
    if proc == 'ZZ': return 'ZZbbtt'
    else: return proc

'''
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_500bv_M250 --prod prod_250117b_datacards_v18/M250 --res
dnn_ZZbbtt_500bv_M250__etau_os_iso__pg_datacard_zz_res_reduced__qcd__blinded__stack__norm_sig__merge_bins__equalBinWidth
dnn_ZHbbtt_500bv_M800__etau_os_iso__pg_datacard_res_reduced__qcd__blinded__stack__norm_sig__merge_bins__equalBinWidth.png

python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_500bv_M800 --prod prod_250117b_datacards_v22/M800 --res

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500 --prod prod_240808
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500 --prod prod_240822
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500 --prod prod_240822

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_250 --prod prod_240808 --res
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_600 --prod prod_240808 --res
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_2000 --prod prod_240808 --res

python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_600 --prod prod_240822 --res
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_1000 --prod prod_240822 --res
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_2000 --prod prod_240822 --res

python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_600 --prod prod_240822 --res
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_1000 --prod prod_240822 --res
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_2000 --prod prod_240822 --res

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500 --prod prod_240824
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500 --prod prod_240824
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500 --prod prod_240824

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_600 --prod prod_240824 --res
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_1000 --prod prod_240824 --res
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_2000 --prod prod_240824 --res

python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_600 --prod prod_240824 --res
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_1000 --prod prod_240824 --res
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_2000 --prod prod_240824 --res

python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_600 --prod prod_240824 --res
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_1000 --prod prod_240824 --res
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_2000 --prod prod_240824 --res

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500 --prod prod_241018
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500 --prod prod_241018
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500 --prod prod_241018

# final version of the thesis

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500 --prod prod_241216 --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500 --prod prod_241216 --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500 --prod prod_241216 --nodata False

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_600 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_1000 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_2000 --prod prod_241216 --res --nodata False

python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_600 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_1000 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_2000 --prod prod_241216 --res --nodata False

python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_600 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_1000 --prod prod_241216 --res --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_2000 --prod prod_241216 --res --nodata False

# final version of the thesis + adjusted y axis range

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500 --prod prod_250106 --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500 --prod prod_250106 --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500 --prod prod_250106 --nodata False

python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_600 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_1000 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZZ --var dnn_ZZbbtt_kl_500_2000 --prod prod_250106 --res --nodata False

python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_600 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_1000 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZbbHtt --var dnn_ZHbbtt_kl_500_2000 --prod prod_250106 --res --nodata False

python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_600 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_1000 --prod prod_250106 --res --nodata False
python3 CopyPlots.py --proc ZttHbb --var dnn_ZHbbtt_kl_500_2000 --prod prod_250106 --res --nodata False

'''

if __name__ == "__main__" :

    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("--proc",         dest="proc",         default='ZZ',                  choices=["ZZ", "ZbbHtt", "ZttHbb"]                )
    parser.add_option("--var",          dest="var",          default='dnn_ZZbbtt_kl_500',                                                     )
    parser.add_option("--year",         dest="years",          default='2018,2017,2016,2016_HIPM',                                                     )
    parser.add_option("--prod",         dest="prod",         default='prod_240808',                                                           )
    parser.add_option("--res",          dest="res",          default=False,                 action='store_true'                               )
    parser.add_option("--nodata",       dest="nodata",       default=True,                  action='store_false'                              )
    (options, args) = parser.parse_args()

    proc = options.proc
    prod = options.prod
    var = options.var
    VAR = 'dnn'
    if options.res:
        mass = options.var.split('_')[-1]
        VAR = f'dnn_{mass}'

    if proc == 'ZZ':  
        prefix = 'EC90'
        pg = 'pg_zz'
        if options.res: pg = 'pg_datacard_zz_res_reduced'
    else:             
        prefix = 'OC90'
        pg = 'pg_plot'
        if options.res: pg = 'pg_datacard_res_reduced'

    if options.nodata:
        nodata = '__nodata'
    else:
        nodata = ''

    maindir = '/data_CMS/cms/cuisset/cmt/FeaturePlot'
    # years = [f'ul_2016_HIPM_{proc}_v12', f'ul_2016_{proc}_v12', f'ul_2017_{proc}_v12', f'ul_2018_{proc}_v12']
    years = [f'bul_{year}_{proc}_v12' for year in options.years.split(",")]
    categories = [f'cat_{proc}_{prefix}_resolved_1b_HPSTau', f'cat_{proc}_{prefix}_resolved_2b_HPSTau', f'cat_{proc}_{prefix}_boosted_bb_HPSTau', f'cat_{proc}_{prefix}_boosted_bb_boostedTau']
    channels = ['etau', 'mutau', 'tautau']

    dn = os.path.dirname(os.path.realpath(__file__))
    outdir = f'{dn}/TMP_PLOTS'
    os.system(f'mkdir -p {outdir}')

    # '/data_CMS/cms/vernazza/cmt/FeaturePlot/ul_2018_ZZ_v12/cat_ZZ_elliptical_cut_90_resolved_1b/prod_240808/dnn_ZZbbtt_kl_500_200__etau_os_iso__pg_zz_res__qcd__nodata__stack__logY__equalBinWidth.pdf'

    for year in years:
        for cat in categories:
            for ch in channels: 
                # dnn_ZZbbtt_500bv_M250__etau_os_iso__pg_datacard_zz_res_reduced__qcd__blinded__stack__norm_sig__merge_bins__equalBinWidth
                logY = not "boosted" in cat
                pdf = f'{maindir}/{year}/{cat}/{prod}/{var}__{ch}_os_iso__{pg}__qcd__blinded__stack{"__logY" if logY else ""}__norm_sig__merge_bins__equalBinWidth.pdf'
                # print(pdf)
                if not os.path.isfile(pdf):
                    print(" ### MISSING:", pdf)
                else:
                    PROC = GetProc(proc)
                    YEAR = GetYear(year)
                    CAT = GetCat(cat)
                    CH = ch
                    outname = f'{VAR}_{PROC}_{CH}_{CAT}_{YEAR}.pdf'
                    os.system(f'cp {pdf} {outdir}/{outname}')