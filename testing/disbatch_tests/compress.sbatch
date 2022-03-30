#!/bin/bash

# slurm specs
#SBATCH --time=01:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
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
export IN_FILE="/mnt/sdceph/users/jhuntenburg/disbatch_tests/in/data_01.cbin"
export OUT_DIR="/mnt/sdceph/users/jhuntenburg/disbatch_tests/out"

srun python run_destripe.py $SLURM_CPUS_PER_TASK $OUT_DIR $IN_FILE

