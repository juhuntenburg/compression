
#!/bin/bash

# Number of cpus to request, needs to match nprocesses in python scripts
n_cpus=4
n_tasks=4

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

# Create task file with common prefix (functions, cpus, out_dir) but different in_files and logs
echo "#DISBATCH PREFIX /usr/bin/time -f '%M' python run_destripe.py $n_cpus $out_dir " > $task_file
in_files=$(find $in_dir/*/*ap.bin -type f | sort)

i=0
for f in $in_files
do
    echo "$f >> logs/task_${i}.log 2>&1" >> $task_file
    i=$((i+1))
done

#find $in_dir/*/*ap.bin -type f | sort >> $task_file 

# Submit the slurm job, run ntasks at a time, each with n_pus cores
sbatch --partition=gen --ntasks=$n_tasks --cpus-per-task=$n_cpus --mem-per-cpu=2.5G disBatch $task_file
