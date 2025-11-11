#!/bin/bash
# Project id - change to your own!
#SBATCH -A <proj-ID>
# Number of tasks, here 8 - default is 1 core per task
#SBATCH -n 8
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain with MPI included or something compiled for MPI 
# This example does not actually need it, though
module load buildtool-easybuild/4.8.0-hpce082752a2 GCC/11.3.0 OpenMPI/4.1.4

# Remember to use "srun" unless the program handles parallelizarion itself
srun /usr/bin/hostname


