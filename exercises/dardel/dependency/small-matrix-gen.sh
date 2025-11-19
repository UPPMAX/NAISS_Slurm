#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj-id>
#SBATCH --time=00:08:00 # Asking for 8 minutes
#SBATCH -n 1 # Asking for 1 core
#SBATCH -p shared

# Load any modules you need, here for Python 3.11.7
module purge  > /dev/null 2>&1
module load cray-python/3.11.7 

# Run your Python script
python small-matrix-gen.py

