# BoostedTaus 6th prod (fix e-tau trigger)
# TODO list for nthis prod
# - fixed DeepTau SFs WPs
# - add Muon vertex cuts for boostedTau (see slide 7 https://indico.cern.ch/event/1501816/contributions/6327020/attachments/2999272/5284907/BoostedTauIDSF_Jan20_2.pdf)
# - mutau : consider deltaR>0.1 instead 0.05 (SFs were derived at 0.1 & significant QCD at low deltaR)

cd /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/frameworkJobs && source setup.sh
YEAR=2018

