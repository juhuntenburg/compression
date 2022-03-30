#!/bin/bash

# slurm specs
#SBATCH --time=00:20:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=gen

# Load FI modules
module purge
module load disBatch/2.0
module load fftw/3.3.10
module load python/3.8.12

# Source virtualenv with pyfftw and ibllib
source /mnt/home/jhuntenburg/Documents/PYTHON/envs/compressenv/bin/activate

# Get input file name from file
task_file=$1
i=$SLURM_ARRAY_TASK_ID
fn=$(sed -n "${i}p" ${task_file})

export IN_FILE="$fn"
export OUT_DIR="/mnt/sdceph/users/jhuntenburg/disbatch_tests/out"

srun python run_destripe.py $SLURM_CPUS_PER_TASK $OUT_DIR $IN_FILE >> logs/task_${i}.log 2>&1

