#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj-id>
#SBATCH --time=00:12:00 # Asking for 12 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need, here for Python 3.11.7
module purge  > /dev/null 2>&1
module load cray-python/3.11.7 

# Run your Python script
python matrix-gen.py

