// Fixing the SFs in a specific region by copying the results from symmetric eta region

TFile f("/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HTT-utilities/trigSFs_UL_eleMu/sf_el_2016post_HLTEle25.root");
TH1* eff_mc = f.Get<TH1>("eff_mc");
eff_mc->SetDirectory(nullptr);
TH1* eff_data = f.Get<TH1>("eff_data");
eff_data->SetDirectory(nullptr);
TH1* SF2D = f.Get<TH1>("SF2D");
SF2D->SetDirectory(nullptr);
f.Close()

TFile fout("/grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/framework/nanoaod_base_analysis/data/cmssw/CMSSW_12_3_0_pre6/src/HTT-utilities/trigSFs_UL_eleMu/sf_el_2016post_HLTEle25_fix2.root", "recreate");
eff_mc->SetBinContent(14, eff_mc->GetBinContent(70))
eff_mc->SetBinError(14, eff_mc->GetBinError(70))
eff_mc->Write()

eff_data->Write();

SF2D->SetBinContent(14, SF2D->GetBinContent(70))
SF2D->SetBinError(14, SF2D->GetBinError(70))
SF2D->Write();
fout.Close();
