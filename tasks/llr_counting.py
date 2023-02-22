from cmt.base_tasks.preprocessing import (
    PreCounter, PreCounterWrapper, MergeCategorizationStats, MergeCategorizationStatsWrapper
)
from analysis_tools.utils import import_root, create_file_dir
import json

class CounterLLR(PreCounter):
    def run(self):
        """
        Extracts normalization factor from histogram inside root file
        """
        ROOT = import_root()
        inp = self.get_input()

        # This could miss if the merging utility is considered,
        # to be checked
        in_file = ROOT.TFile.Open(inp)
        histo = in_file.Get("h_eff")

        evt_den = histo.GetBinContent(1)

        d = {
            "evt_den": evt_den,
            "filenames": [inp]
        }
        with open(create_file_dir(self.output().path), "w+") as f:
            json.dump(d, f, indent=4)


class CounterLLRWrapper(PreCounterWrapper):
    def atomic_requires(self, dataset):
        return CounterLLR.req(self, dataset_name=dataset.name)


class MergeCounterLLR(MergeCategorizationStats):
    def merge_workflow_requires(self):
        return CounterLLR.vreq(self, _prefer_cli=["workflow"])

    def merge_requires(self, start_leaf, end_leaf):
        return CounterLLR.vreq(self, workflow="local", branches=((start_leaf, end_leaf),),
            _exclude={"branch"})

    def merge(self, inputs, output):
        # output content
        stats = dict(evt_den=0, filenames=[])

        # merge
        for inp in inputs:
            try:
                if "json" in inp.path:
                    _stats = inp.load(formatter="json")
                else:
                    raise ValueError
            except:
                print("error leading input target {}".format(inp))
                raise

            # add nevents
            if "json" in inp.path:
                stats["evt_den"] += _stats["evt_den"]
                stats["filenames"] += _stats["filenames"]
            else:
                raise ValueError

        output.parent.touch()
        output.dump(stats, indent=4, formatter="json")


class MergeCounterLLRWrapper(MergeCategorizationStatsWrapper):
    def atomic_requires(self, dataset):
        return MergeCounterLLR.req(self, dataset_name=dataset.name)
