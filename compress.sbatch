#!/bin/bash

# slurm specs
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50G
#SBATCH --partition=gen
#SBATCH -o outfile.log
#SBATCH -e stderr.log

# Load FI modules
module purge
module load disBatch/2.0
module load fftw/3.3.10
module load python/3.8.12

# Source virtualenv with pyfftw and ibllib
source /mnt/home/jhuntenburg/Documents/PYTHON/envs/compressenv/bin/activate
export IN_FILE="/mnt/sdceph/users/jhuntenburg/benchmark/raw/8413c5c6-b42b-4ec6-b751-881a54413628/_spikeglx_ephysData_g0_t0.imec0.ap.bin"

srun python run_destripe.py $SLURM_CPUS_PER_TASK $IN_FILE

