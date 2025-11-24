#!/bin/bash
# Project id - change to your own!
#SBATCH -A <proj ID>
# Number of tasks, here 14 - default is 1 core per task
#SBATCH -n 14
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain with MPI included or something compiled for MPI 
# This example does not actually need it, though
module load MODULES

# Remember to use "srun" unless the program handles parallelizarion itself
srun /usr/bin/hostname


