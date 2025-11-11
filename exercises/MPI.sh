#!/bin/bash
# Project id - change to your own after the workshop!
#SBATCH -A hpc2n2025-151
# Number of tasks, here 14 - default is 1 core per task
#SBATCH -n 14
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain with MPI included or something compiled for MPI 
# This example does not actually need it, though
module load foss/2023b

# Remember to use "srun" unless the program handles parallelizarion itself
srun /usr/bin/hostname


