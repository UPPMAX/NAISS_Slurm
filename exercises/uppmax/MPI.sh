#!/bin/bash
# Project id - change to your own!
#SBATCH -A uppmaxXXXX-Y-ZZZ
# Number of tasks, here 8 - default is 1 core per task
#SBATCH -n 8
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain with MPI included or something compiled for MPI 
# This example does not actually need it, though
module load OpenMPI/4.1.6-GCC-13.2.0

# Remember to use "srun" (or "mpirun") unless the program handles parallelizarion itself
srun /usr/bin/hostname


