#!/bin/bash
# Change to your own project ID! 
#SBATCH -A uppmaxXXXX-Y-ZZZ
#SBATCH --time=00:12:00 # Asking for 12 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need, here for Python 3.12.3 and a compatible SciPy-bundle for numpy
module load Python/3.12.3-GCCcore-13.3.0 
module load SciPy-bundle/2024.05-gfbf-2024a

# Run your Python script
python matrix-gen.py

