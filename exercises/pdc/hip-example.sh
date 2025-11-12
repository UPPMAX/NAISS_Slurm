#!/bin/bash
#SBATCH -A <proj-id> # Change to your own
#SBATCH --time=00:10:00  # Asking for 10 minutes
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -p gpu

# Load the modules we need
module load PDC/23.12
module load rocm/5.7.0
module load cray-python/3.11.5
module load craype-accel-amd-gfx90a

# Prepare a virtual environment with hip - do this before
# running the batch script
# python -m venv --system-site-packages myhip
# source myhip/bin/activate
# pip install hip-python

# Later, during the batch job, you would just activate
# the virtual environment
source <path-to>/myhip/bin/activate

# Run your Python script
python hip-example.py
