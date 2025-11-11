#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A <proj-ID>
# We are asking for 15 minutes
#SBATCH --time=00:05:00
# The following two lines splits the output in a file for any errors and a file for other output.
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --gpus-per-task=1

# Remove any loaded modules and load the ones we need
module purge  > /dev/null 2>&1
module load buildtool-easybuild/4.8.0-hpce082752a2 GCCcore/13.2.0 
module load Python/3.11.5

# This code needs numba which is not installed as a module on Tetralith.
# Thus it needs to be installed in a virtual environment (or using conda).
# Here I am installing it to a virtual environment a subdirectory in this directory
python -m venv mynumba
source mynumba/bin/activate
pip install numba
pip install tensorflow

# Then run the code 
srun python pytorch_fitting_gpu.py

