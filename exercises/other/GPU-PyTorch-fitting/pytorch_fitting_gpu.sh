#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A <proj-ID>
# We are asking for 5 minutes
#SBATCH --time=00:05:00

# The following two lines splits the output in a file for any errors and a file for other output.
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

# Asking for one GPU card
#SBATCH <ANYTHING YOU NEED TO LOAD A GPU CARD>

# Load the modules we need to get PyTorch and CUDA
module load <MODULES GO HERE> 

srun python pytorch_fitting_gpu.py

