
# 
rsync -rltv /grid_mnt/data__data.polcms/cms/cuisset/cmt/FeaturePlot tcuisset@lxplus.cern.ch:/eos/user/t/tcuisset/www/zzbbtt/ --delete --delete-excluded \
 --filter '- /*_v10' --filter '- **_bugged/' --filter '- **_pilot/' --filter '- **_v1/' --filter '- root/'  --filter '- yields/' --filter '+ */' \
 --filter '- **/*_datacard_*'  --filter '+ **_os_iso_*.png' --filter '+ **_os_iso_*.pdf' --filter '- *' 