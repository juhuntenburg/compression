#!/bin/bash

# Number of cpus to request, needs to match nprocesses in python scripts
n_cpus=4

# Locations
in_dir="/mnt/sdceph/users/jhuntenburg/benchmark/raw"
out_dir="/mnt/sdceph/users/jhuntenburg/benchmark/compress_out"
working_dir="/mnt/home/jhuntenburg/compression"
task_file="$working_dir/tasks.disbatch"

# Load FI modules
module purge
module load disBatch/2.0
module load fftw/3.3.10
module load python/3.8.12

# Source virtualenv with pyfftw and ibllib
source /mnt/home/jhuntenburg/Documents/PYTHON/envs/compressenv/bin/activate

# Create task file with common prefix (functions, cpus, out_dir) and different in_files 
echo "#DISBATCH PREFIX python run_destripe.py $n_cpus $out_dir " > $task_file
find $in_dir/*/*ap.bin -type f | sort >> $task_file 

# Submit the slurm job, run ntasks at a time, each with n_pus cores
sbatch --partition=gen --ntasks=4 --cpus-per-task=$n_cpus --mem-per-cpu=5G disBatch $task_file
