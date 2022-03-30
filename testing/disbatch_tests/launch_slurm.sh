#!/bin/bash

# Locations
in_dir="/mnt/sdceph/users/jhuntenburg/disbatch_tests/in"
out_dir="/mnt/sdceph/users/jhuntenburg/disbatch_tests/out"
working_dir="/mnt/home/jhuntenburg/compression/disbatch_tests"
task_file="$working_dir/infiles.array"

# Create task file with common prefix (functions, cpus, out_dir) but different in_files and logs
find $in_dir/*cbin -type f | sort > $task_file

# Submit the slurm job, run ntasks at a time, each with n_pus cores
sbatch --array=1-12 job.slurm $task_file
