#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A uppmaxXXXX-Y-ZZZ
# We are asking for 5 minutes
#SBATCH --time=00:05:00
# The following two lines splits the output in a file for any errors and a file for other output.
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
# Asking for 1 GPU, on Snowy 
#SBATCH --exclusive
#SBATCH -n 1
#SBATCH -M snowy
#SBATCH --gres=gpu=1

# Load the modules we need
module load uppmax
module load python/3.11.8 
module load python_ML_packages/3.11.8-gpu

srun python pytorch_fitting_gpu.py

