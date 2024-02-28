import json
import law
import luigi
import itertools
from collections import OrderedDict
from copy import deepcopy as copy
import os
import numpy as np
import subprocess
from collections import defaultdict

import matplotlib.pyplot as plt
import mplhep

from analysis_tools.utils import import_root, randomize, create_file_dir

from cmt.base_tasks.base import ConfigTaskWithCategory, ConfigTask
from cmt.base_tasks.analysis import CreateDatacards

from plotting_tools import Label

class CombineTaskBase:
    combine_install = luigi.Parameter(significant=False, description="Path to CMSSW release holding combine installation, ex /home/..../CMSSW_11_3_4/")
    feature = luigi.Parameter(description="Feature name to run Combine on (ex : dnn_ZHbbtt_kl_1)")


class RunCombine(ConfigTaskWithCategory, CombineTaskBase):
    """ Run combine on datacards, on the feature given 
    Combine must have been installed (the path has to be given in argument)
    Usage :
    law run RunCombineCombination --version prod_240226 --config-name ul_2018_ZbbHtt_v10 --category-names ZbbHtt_elliptical_cut_90_etau,ZbbHtt_elliptical_cut_90_mutau,ZbbHtt_elliptical_cut_90_tautau  \
        --combine-install /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/CMSSW_11_3_4 --feature dnn_ZHbbtt_kl_1  --region-name os_iso \
        --CreateDatacards-version prod_240226  --CreateDatacards-process-group-name datacard_ZbbHtt \
        --FeaturePlot-version prod_240226_fixSystQcd \
        --CreateDatacards-do-qcd --CreateDatacards-hide-data True --CreateDatacards-process-group-name datacard_ZbbHtt --CreateDatacards-feature-names dnn_ZHbbtt_kl_1 \
    
    It is important to specify the FeaturePlot option as --CreateDatacards-do-qcd, etc (if specifying --FeaturePlot-do-qcd it does not propagate the option)
    """
    def __init__(self, *args, **kwargs):
        super(RunCombine, self).__init__(*args, **kwargs)

    def requires(self):
        return CreateDatacards.vreq(self, feature_names=[self.feature])
    
    def output(self):
        return self.local_target(self.feature, dir=True) # for now we use a full directory as target, we should split that into files
    
    def run(self):
        output_log:list[str] = [] # log of all combine output
        try:
            odir = self.output().path
            os.makedirs(odir, exist_ok=True)
            datafile = self.input()[self.feature]["txt"].path
            channel = self.category_name.split("_")[-1]

            ROOT = import_root()
            def run_c(cmd, wd=odir, output_log=output_log):
                """ Run a command in combine cmsenv, in workding directory wd, logging into output file """
                print(f"########## Command : {cmd}\n")
                ret = subprocess.run(f"cd '{self.combine_install}' && cmsenv && cd '{wd}' && " + cmd, 
                            shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
                output_log.append(f"########## Command : {cmd}\n" + ret.stdout + "\n\n")
                print(ret.stdout)
            
            print(" ### INFO: Create workspace")
            cmd = f'text2workspace.py "{datafile}" -o "{odir}/model.root"'
            run_c(cmd)

            print(" ### INFO: Run Delta Log Likelihood Scan")
            cmd = f'combine -M MultiDimFit {odir}/model.root --algo=grid --points 100 --rMin 0 --rMax 2 --preFitValue 1 --expectSignal 1 -t -1'
            run_c(cmd)

            LS_file = f'{odir}/higgsCombineTest.MultiDimFit.mH120.root'
            f = ROOT.TFile(LS_file)
            limit = f.Get("limit")

            to_draw = ROOT.TString("2*deltaNLL:r")
            n = limit.Draw( to_draw.Data(), "", "l")

            x = np.ndarray((n), 'd', limit.GetV2())[1:]
            y = np.ndarray((n), 'd', limit.GetV1())[1:]

            graphScan = ROOT.TGraph(x.size,x,y)

            graphScan.SetTitle("")
            graphScan.SetLineWidth(3)
            graphScan.SetLineColor(ROOT.kRed)
            graphScan.GetYaxis().SetTitle("-2 #Delta LL")
            graphScan.GetXaxis().SetTitle('#mu')

            x_min = graphScan.GetXaxis().GetXmin()
            x_max = graphScan.GetXaxis().GetXmax()

            o_sigma = ROOT.TLine(x_min, 1, x_max, 1)
            o_sigma.SetLineStyle(7)
            o_sigma.SetLineWidth(2)
            o_sigma.SetLineColor(ROOT.kGray+2)
            t_sigma = ROOT.TLine(x_min, 3.84, x_max, 3.84)
            t_sigma.SetLineStyle(7)
            t_sigma.SetLineWidth(2)
            t_sigma.SetLineColor(ROOT.kGray+2)

            def CanvasCreator(dims, margins=0.11):
                if len(dims) == 2: canvas = ROOT.TCanvas( "c", "c", dims[0], dims[1] )
                elif len(dims) == 4: canvas = ROOT.TCanvas( "c", "c", dims[0], dims[1], dims[2], dims[3] )
                else: raise RuntimeError("[ERROR] dims argument (1) either list of len 2 or 4")

                canvOptions = {"SetTitle": "", "SetGrid": True}
                for opt in canvOptions.keys():
                    getattr(canvas, opt)(canvOptions[opt])

                ROOT.gPad.SetRightMargin(margins)
                ROOT.gPad.SetLeftMargin(margins)
                ROOT.gPad.SetBottomMargin(margins)
                ROOT.gPad.SetTopMargin(margins)
                ROOT.gPad.SetFrameLineWidth(3)

                canvas.Update()
                return canvas

            c = CanvasCreator([800,800], margins=0.11)
            c.cd()
            graphScan.Draw()

            t1 = ROOT.TLatex(0.11, 0.91, "#scale[1.5]{CMS} Private work ("+channel+")")
            t1.SetTextSize(0.03)
            t1.SetNDC(True)
            t1.Draw("SAME")

            t2 = ROOT.TLatex(0.6, 0.91, "2018, (13 TeV) 59.7 fb^{-1}")
            t2.SetTextSize(0.03)
            t2.SetNDC(True)
            t2.Draw("SAME")

            o_sigma.Draw("SAME")
            t_sigma.Draw("SAME")
            c.Update()

            OS = ROOT.TLatex()
            OS.SetTextFont(42)
            OS.SetTextSize(0.03)
            OS.DrawLatex( x[0]*1.1, 1+0.1, '68% C.L.' )
            TS = ROOT.TLatex()
            TS.SetTextFont(42)
            TS.SetTextSize(0.03)
            TS.DrawLatex( x[0]*1.1, 3.84+0.1, '95% C.L.' )

            c.SaveAs(f"{odir}/DeltaNLL.png")
            c.SaveAs(f"{odir}/DeltaNLL.pdf")
            c.Close()

            print(" ### INFO: Run significance extraction")
            cmd = f'combine -M Significance {datafile} -t -1 --expectSignal=1 --pvalue'
            run_c(cmd)
            os.system(f'mv {odir}/higgsCombineTest.Significance.mH120.root {odir}/higgsCombineTest.Significance.mH120.pvalue.root')

            LS_file = f'{odir}/higgsCombineTest.Significance.mH120.pvalue.root'
            f = ROOT.TFile(LS_file)
            limit = f.Get("limit")
            limit.GetEntry(0)
            a = limit.limit

            cmd = f'combine -M Significance {datafile} -t -1 --expectSignal=1'
            run_c(cmd)
            os.system(f'mv {odir}/higgsCombineTest.Significance.mH120.root {odir}/higgsCombineTest.Significance.mH120.significance.root')

            LS_file = f'{odir}/higgsCombineTest.Significance.mH120.significance.root'
            f = ROOT.TFile(LS_file)
            limit = f.Get("limit")
            limit.GetEntry(0)
            b = limit.limit

            output_string = " ### INFO: Results for " + channel + "\n"
            output_string += " ### p-value     = " + str(a) + "\n"
            output_string += " ### significane = " + str(b) + "\n"
            print(output_string)
            with open(odir+"/results.txt", "w") as text_file:
                text_file.write(output_string)

        finally:
            with open(odir+"/log.txt", "w") as text_file:
                text_file.write("\n".join(output_log))
        

class RunCombineCombination(ConfigTask, CombineTaskBase):
    """ Run combine on the combination of channels 
    Usage : 
    law run RunCombineCombination --version prod_240226 --config-name ul_2018_ZttHbb_v10 --category-names ZttHbb_elliptical_cut_90_etau,ZttHbb_elliptical_cut_90_mutau,ZttHbb_elliptical_cut_90_tautau  \
        --combine-install /grid_mnt/data__data.polcms/cms/cuisset/ZHbbtautau/combine/CMSSW_11_3_4 --feature dnn_ZHbbtt_kl_1  --region-name os_iso \
        --CreateDatacards-version prod_240226  --CreateDatacards-process-group-name datacard_ZttHbb \
        --FeaturePlot-version prod_240226_fixSystQcd \
        --CreateDatacards-do-qcd --CreateDatacards-hide-data True --CreateDatacards-process-group-name datacard_ZttHbb --CreateDatacards-feature-names dnn_ZHbbtt_kl_1
    
    It is important to specify the FeaturePlot option as --CreateDatacards-do-qcd, etc (if specifying --FeaturePlot-do-qcd it does not propagate the option)
    """
    region_name = luigi.Parameter(default="os_iso", description="name of region to use. Will be prepended by etau_, mutau_, tautau_ as appropriate")
    # maybe we could use subcategories for this ?
    category_names = law.CSVParameter(description="Names of categories to run combination on, for ex ZbbHtt_elliptical_cut_90_etau,ZbbHtt_elliptical_cut_90_mutau,ZbbHtt_elliptical_cut_90_tautau")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
    
    def store_parts(self):
        parts = super().store_parts()
        parts["category_names"] = "-".join(self.category_names)
        parts["region"] = self.region_name
        return parts

    def requires(self):
        # we need to map rehion name from 
        return {cat : {
            "combine" : RunCombine.vreq(self, category_name=cat, region_name=self.get_channel_from_category(cat)+"_"+self.region_name), 
            "datacard" : CreateDatacards.vreq(self, feature_names=[self.feature], category_name=cat, region_name=self.get_channel_from_category(cat)+"_"+self.region_name)
        } for cat in self.category_names}
    
    def output(self):
        return self.local_target("", dir=True) # for now we use a full directory as target, we should split that into files
    
    def get_channel_from_category(self, category_name):
        return category_name.split("_")[-1]
    
    def run(self):
        output_log:list[str] = [] # log of all combine output
        try:
            ROOT = import_root()
            plt.style.use(mplhep.style.CMS)

            combdir = self.output().path
            os.makedirs(combdir, exist_ok=True)
            print(" ### INFO: Saving combination in ", combdir)

            def run_c(cmd, wd=combdir, output_log=output_log):
                """ Run a command in combine cmsenv, in workding directory wd, logging into output file """
                print(f"########## Command : {cmd}\n")
                ret = subprocess.run(f"cd '{self.combine_install}' && cmsenv && cd '{wd}' && " + cmd, 
                            shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
                output_log.append(f"########## Command : {cmd}\n" + ret.stdout + "\n\n")
                print(ret.stdout)


            cmd = 'combineCards.py'
            n_comb = len(self.input()) # number of categories
            for i_category, category in enumerate(self.input().keys()):
                createDatacards_output = self.input()[category]["datacard"][self.feature]
                subprocess.run(f"cp '" + createDatacards_output["txt"].path + "' '" + createDatacards_output["root"].path + f"' '{combdir}'", check=True, shell=True)
                cmd += f' Name{i_category}={self.feature}_{self.get_channel_from_category(category)}_{self.region_name}.txt'

            cmd += ' > dnn_comb.txt'
            run_c(cmd)

            cmd = 'text2workspace.py dnn_comb.txt -o model.root'
            run_c(cmd)
            cmd = 'combine -M MultiDimFit model.root --algo=singles --rMin 0 --rMax 2 --preFitValue 1 --expectSignal 1 -t -1'
            run_c(cmd)
            cmd = 'combine -M MultiDimFit model.root --algo=grid --points 100 --rMin 0 --rMax 2 --preFitValue 1 --expectSignal 1 -t -1'
            run_c(cmd)
            cmd = 'combine -M Significance dnn_comb.txt -t -1 --expectSignal=1'
            run_c(cmd)

            cmd = 'combine -M MultiDimFit model.root -m 125 -n .bestfit.with_syst --setParameterRanges r=0,2 --saveWorkspace'\
                ' --preFitValue 1 --expectSignal 1 -t -1'
            run_c(cmd)
            cmd = 'combine -M MultiDimFit higgsCombine.bestfit.with_syst.MultiDimFit.mH125.root --setParameterRanges r=0,2 '\
                '--saveWorkspace --preFitValue 1 --expectSignal 1 -t -1 -n .scan.with_syst.statonly_correct --algo grid '\
                '--points 100 --snapshotName MultiDimFit --freezeParameters allConstrainedNuisances'
            run_c(cmd)

            #######################################################################
            #######################################################################
            #######################################################################
            limits_per_category = defaultdict(dict)
            for category in self.input().keys():
                LS_file = os.path.join(self.input()[category]["combine"].path, "higgsCombineTest.MultiDimFit.mH120.root")
                f = ROOT.TFile(LS_file)
                limit = f.Get("limit")
                to_draw = ROOT.TString("2*deltaNLL:r")
                n = limit.Draw( to_draw.Data(), "", "l")

                limits_per_category[category]["x"] = np.array(np.ndarray((n), 'd', limit.GetV2())[30:70])
                limits_per_category[category]["y"] = np.array(np.ndarray((n), 'd', limit.GetV1())[30:70])

                f_significance = ROOT.TFile(os.path.join(self.input()[category]["combine"].path, "higgsCombineTest.Significance.mH120.significance.root"))
                limit_significance = f_significance.Get("limit")
                limit_significance.GetEntry(0)
                limits_per_category[category]["sig"] = limit_significance.limit

            LS_file_comb = combdir + f'/higgsCombineTest.MultiDimFit.mH120.root'
            f_comb= ROOT.TFile(LS_file_comb)
            limit_comb = f_comb.Get("limit")
            to_draw_comb = ROOT.TString("2*deltaNLL:r")
            n_comb = limit_comb.Draw( to_draw_comb.Data(), "", "l")

            x_comb = np.array(np.ndarray((n_comb), 'd', limit_comb.GetV2())[30:70])
            y_comb = np.array(np.ndarray((n_comb), 'd', limit_comb.GetV1())[30:70])

            LS_file_comb_stat = combdir + f'/higgsCombine.scan.with_syst.statonly_correct.MultiDimFit.mH120.root'
            f_comb_stat= ROOT.TFile(LS_file_comb_stat)
            limit_comb_stat = f_comb_stat.Get("limit")
            to_draw_comb_stat = ROOT.TString("2*deltaNLL:r")
            n_comb_stat = limit_comb_stat.Draw( to_draw_comb_stat.Data(), "", "l")

            x_comb_stat = np.array(np.ndarray((n_comb_stat), 'd', limit_comb_stat.GetV2())[30:70])
            y_comb_stat = np.array(np.ndarray((n_comb_stat), 'd', limit_comb_stat.GetV1())[30:70])

            def GetLegend(x, y, x_stat, y_stat, round=3):
                central = x[np.argmin(y)]
                interval_1sigma = x[np.where(y < 1)]
                min_1sigma = np.abs(min(interval_1sigma)-central)
                max_1sigma = np.abs(max(interval_1sigma)-central)
                interval_1sigma_stat = x_stat[np.where(y_stat < 1)]
                min_1sigma_stat = np.abs(min(interval_1sigma_stat)-central)
                max_1sigma_stat = np.abs(max(interval_1sigma_stat)-central)
                r = np.round(central, round)
                up = np.round(max_1sigma, round)
                down = np.round(min_1sigma, round)
                up_stat = np.round(max_1sigma_stat, round)
                down_stat = np.round(min_1sigma_stat, round)
                up_syst = np.round(np.sqrt(max_1sigma**2 - max_1sigma_stat**2), round)
                down_syst = np.round(np.sqrt(min_1sigma**2 - min_1sigma_stat**2), round)
                return r, up, down, up_stat, down_stat, up_syst, down_syst

            f, ax = plt.subplots(figsize = [10,10])
            
            for category, limits_for_category in limits_per_category.items():
                plt.plot(limits_for_category["x"], limits_for_category["y"], linewidth=2, label=category) # TODO label
            plt.plot(x_comb, y_comb, linewidth=2, color='firebrick', label='Combination')
            plt.plot(x_comb_stat, y_comb_stat, linewidth=2, color='firebrick', linestyle='--', label='Stat-only')
            # central = round(x_comb[np.argmin(y_comb)], 3)
            r, up, down, up_stat, down_stat, up_syst, down_syst = GetLegend(x_comb, y_comb, x_comb_stat, y_comb_stat)
            text1 = fr"$\mu = 1.00^{{+{up}}}_{{-{down}}}$"
            plt.text(.02, .98, text1, ha='left', va='top', transform=ax.transAxes, fontsize='small', 
                    bbox=dict(facecolor='white', alpha=0.5, edgecolor='none'))
            text2 = fr"$\mu = 1.00^{{+{up_syst}}}_{{-{down_syst}}}(syst)^{{+{up_stat}}}_{{-{down_stat}}}(stat)$"
            plt.text(.02, .92, text2, ha='left', va='top', transform=ax.transAxes, fontsize='small', 
                    bbox=dict(facecolor='white', alpha=0.6, edgecolor='none'))
            plt.xlabel(r'$\mu$')
            plt.ylabel(r'-2$\Delta$ LL')
            plt.axhline(y=1, color='black', linestyle='--', alpha=0.5)
            plt.axhline(y=3.84, color='black', linestyle='--', alpha=0.5)
            plt.text(x=next(iter(limits_per_category.values()))["x"][0], y=1.1, s="68% C.L.", fontsize="x-small")
            plt.text(x=next(iter(limits_per_category.values()))["x"][0], y=3.94, s="95% C.L.", fontsize="x-small")
            plt.legend(fontsize=20, loc='upper right', frameon=True)
            plt.ylim(-0.05 if self.config.x["AnalysisType"] == "Zbb_Ztautau" else -0.005, 1.1*np.max(y_comb))
            mplhep.cms.label(data=False, rlabel='2018, (13.6 TeV) 59.7 $fb^{-1}$', fontsize=20)
            plt.grid()
            savefile = combdir + '/Combination_Mu'
            plt.savefig(savefile+'.png')
            plt.savefig(savefile+'.pdf')
            print(savefile+'.png')
            plt.close() 

            f, ax = plt.subplots(figsize = [10,10])
            xs=5.52*0.033658*0.1512
            for category, limits_for_category in limits_per_category.items():
                plt.plot(xs*limits_for_category["x"], limits_for_category["y"], linewidth=2, label=category) # TODO label
            plt.plot(xs*x_comb, y_comb, linewidth=2, color='firebrick', label='Combination')
            plt.plot(xs*x_comb_stat, y_comb_stat, linewidth=2, color='firebrick', linestyle='--', label='Stat-only')
            r, up, down, up_stat, down_stat, up_syst, down_syst = GetLegend(xs*x_comb, y_comb, xs*x_comb_stat, y_comb_stat)
            text1 = fr"$\sigma = {{{r}}}^{{+{up}}}_{{-{down}}}$ pb"
            plt.text(.02, .98, text1, ha='left', va='top', transform=ax.transAxes, fontsize='small', 
                    bbox=dict(facecolor='white', alpha=0.5, edgecolor='none'))
            text2 = fr"$\sigma = {{{r}}}^{{+{up_syst}}}_{{-{down_syst}}}(syst)^{{+{up_stat}}}_{{-{down_stat}}}(stat)$ pb"
            plt.text(.02, .92, text2, ha='left', va='top', transform=ax.transAxes, fontsize='small', 
                    bbox=dict(facecolor='white', alpha=0.6, edgecolor='none'))
            plt.xlabel(r'$\sigma\;(ZZ \rightarrow bb\tau\tau)$ [pb]')
            plt.ylabel(r'-2$\Delta$ LL')
            plt.axhline(y=1, color='black', linestyle='--', alpha=0.5)
            plt.axhline(y=3.84, color='black', linestyle='--', alpha=0.5)
            plt.text(x=xs*next(iter(limits_per_category.values()))["x"][0], y=1.1, s="68% C.L.", fontsize="x-small")
            plt.text(x=xs*next(iter(limits_per_category.values()))["x"][0], y=3.94, s="95% C.L.", fontsize="x-small")
            plt.legend(fontsize=20, loc='upper right', frameon=True)
            plt.ylim(-0.05 if self.config.x["AnalysisType"] == "Zbb_Ztautau" else -0.005, 1.1*np.max(y_comb))
            mplhep.cms.label(data=False, rlabel='2018, (13.6 TeV) 59.7 $fb^{-1}$', fontsize=20)
            plt.grid()
            savefile = combdir + '/Combination_Sigma'
            plt.savefig(savefile+'.png')
            plt.savefig(savefile+'.pdf')
            print(savefile+'.png')
            plt.close() 

            LS_file = f'{combdir}/higgsCombineTest.Significance.mH120.root'
            f = ROOT.TFile(LS_file)
            limit = f.Get("limit")
            limit.GetEntry(0)
            b = limit.limit

            print(" ### INFO: Produce impact plots")
            cmd = 'combineTool.py -M Impacts -d model.root -m 125 --expectSignal 1 -t -1 --preFitValue 1 --setParameterRanges r=0,2 --doInitialFit --robustFit 1'
            run_c(cmd)
            cmd = 'combineTool.py -M Impacts -d model.root -m 125 --expectSignal 1 -t -1 --preFitValue 1 --setParameterRanges r=0,2 --doFits --robustFit 1'
            run_c(cmd)
            cmd = 'combineTool.py -M Impacts -d model.root -m 125 -o impacts.json'
            run_c(cmd)
            cmd = 'plotImpacts.py -i impacts.json -o impacts'
            run_c(cmd)
            os.makedirs(os.path.join(combdir, "impacts"))
            os.system(f'cd "{combdir}" && mv higgsCombine_paramFit* higgsCombine_initialFit* impacts')

            print(" ### INFO: Results for combination")
            output_string_significance = ""
            output_string_legend = ""
            for category, limits_for_category in limits_per_category.items():
                output_string_significance += f" ### significance {self.get_channel_from_category(category)} = {limits_for_category['sig']}\n"
                output_string_legend += str(GetLegend(limits_for_category["x"], limits_for_category["y"], limits_for_category["x"], limits_for_category["y"], round=5)) + "\n"
            output_string_significance += f" ### significance combination = {b}"
            
            print(output_string_significance)
            print(output_string_legend)

            with open(combdir+"/results.txt", "w") as text_file:
                text_file.write(output_string_significance + "\n\n")
                text_file.write(output_string_legend)

        finally:
            with open(combdir+"/log.txt", "w") as text_file:
                text_file.write("\n".join(output_log))
    