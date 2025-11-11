#!/bin/bash
# Project id - change to your own after the workshop!
#SBATCH -A NAISS2025-22-934
#SBATCH -p alvis
# You need to ask for a GPU to run on alvis. 
# This is a CPU job. Do not do things like this normally!
# Only use for GPU jobs! 
#SBATCH -N 1 --gpus-per-node=T4:1
# Number of tasks - default is 1 core per task
#SBATCH -n 4
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain with MPI included 
# Here we are not using any and just reporting hostnames
#module load foss/2023b

srun /usr/bin/hostname


