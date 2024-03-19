import os,glob,sys
from collections import deque
from datetime import datetime

main_dir = "/grid_mnt/data__data.polcms/cms/vernazza/FrameworkNanoAOD/hhbbtt-analysis/nanoaod_base_analysis/data/store/Categorization/ul_2018_ZZ_v10"
for proc in glob.glob(main_dir+'/*'):
    print(proc)
    # for cat in glob.glob(proc+'/*'):
    #     print(cat)
    for log in glob.glob(proc+'/cat_base/prod_240128/stdall*'):
        # print(log)
        if "ggXZZbbtt" in log: continue
        if "zz_sl_background" in log: continue
        if "zz_sl_signal" in log: continue
        with open(log, 'r') as f:
            tail = deque(f, 4)
        start = tail[0].split('start time    : ')[1].split(' (CET)\n')[0].split('.')[0]
        end = tail[1].split('end time      : ')[1].split(' (CET)\n')[0].split('.')[0]
        start_time = datetime.strptime(start, '%d/%m/%Y %H:%M:%S')
        end_time = datetime.strptime(end, '%d/%m/%Y %H:%M:%S')
        time_diff = end_time - start_time
        tme_h = time_diff.total_seconds() / 3600
        print(" *** Time = {:.2f}".format(tme_h))

