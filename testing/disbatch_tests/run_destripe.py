import argparse
from pathlib import Path

from ibllib.dsp.voltage import decompress_destripe_cbin

# Parse input arguments
parser = argparse.ArgumentParser(description='Run destripe')
parser.add_argument('n_cpus')
parser.add_argument('out_dir')
parser.add_argument('in_file')
args = parser.parse_args()

n_cpus = int(args.n_cpus)
in_file = Path(str(args.in_file))
out_dir = Path(str(args.out_dir))

# Construct out_file and create directory
out_file = out_dir.joinpath(in_file.parts[-1])
out_file.parent.mkdir(exist_ok=True, parents=True) 

# Run function
res = decompress_destripe_cbin(sr_file=in_file, output_file=out_file, nprocesses=n_cpus, nthreads=1)
