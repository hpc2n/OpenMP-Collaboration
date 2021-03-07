#!/bin/bash
#SBATCH -A SNIC2021-22-37
#Asking for 3 min.
#SBATCH -t 00:03:00
#SBATCH -c 2
#SBATCH -J data_process         # name of job
#SBATCH -o process_omp_%j.out   # output file
#SBATCH -e process_omp_%j.err   # error messages
#SBATCH --reservation=snic2021-22-37-dayX

cat $0

ml purge  > /dev/null 2>&1 
#module load foss/2020b
module load intel/2020a

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./code_exe

