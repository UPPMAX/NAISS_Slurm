#!/bin/bash

# Project id - change to your own!
#SBATCH -A <proj-id>

# Number of cores per tasks
#SBATCH -c 8 

# Asking for a walltime of 5 min
#SBATCH --time=00:05:00
#SBATCH -p shared 


#SBATCH -o process_omp_%j.out  
#SBATCH -e process_omp_%j.err 

cat $0

# Load a compiler toolchain so we can run an OpenMP program
module load gcc-native/13.2


# process binding is typically recommended.  Try what works best spread or close
#export OMP_PROC_BIND=spread
export OMP_PROC_BIND=close

# we bind to cores
export OMP_PLACES=cores

# if we want to have a single thread per core and ignor hyperthreading, un-comment the below
# export OMP_NUM_THREADS=$(($SLURM_CPUS_PER_TASK/2))

./omp_hello
