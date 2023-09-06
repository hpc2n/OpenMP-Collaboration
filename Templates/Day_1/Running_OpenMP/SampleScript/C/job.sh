#!/bin/bash
#SBATCH -A lu2023-7-61

#SBATCH -t 00:02:00             # Asking for 3 min.
#SBATCH -c 2
#SBATCH -J data_process         # name of job
#SBATCH -o process_omp_%j.out   # output file
#SBATCH -e process_omp_%j.err           # error messages
#SBATCH --reservation=lu2023-7-61_day1  # reservation change X for the day

cat $0

ml purge  > /dev/null 2>&1 
module load GCC/11.3.0
#module load intel-compilers/2022.1.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./code_exe

