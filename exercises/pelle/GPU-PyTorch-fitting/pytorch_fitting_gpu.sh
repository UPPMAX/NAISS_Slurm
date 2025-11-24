#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A uppmaxXXXX-Y-ZZZ
# We are asking for 5 minutes
#SBATCH --time=00:05:00

# The following two lines splits the output in a file for any errors and a file for other output.
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

# Asking for 1 GPU 
#SBATCH -p gpu                                                                  
#SBATCH --gpus=1    

# Activate the PyTorch environment

srun python pytorch_fitting_gpu.py
