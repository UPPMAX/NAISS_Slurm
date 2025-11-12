#!/bin/bash
# Change to your own project ID! 
#SBATCH -A uppmaxXXXX-Y-ZZZ
#SBATCH --time=00:10:00 # Asking for 10 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need, here for Python 3.11.8
module load uppmax
module load python/3.11.8

# Run your Python script
python matrix-gen.py

