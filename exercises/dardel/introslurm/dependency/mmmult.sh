#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj-id>
#SBATCH --time=00:25:00 # Asking for 25 minutes
#SBATCH -n 1 # Asking for 1 core
#SBATCH -p shared

# Load any modules you need, here for Python 3.11.7 
module load cray-python/3.11.7 

# Run your Python script
python mmmult.py

