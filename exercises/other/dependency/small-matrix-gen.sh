#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj ID>
#SBATCH --time=00:08:00 # Asking for 8 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need for a fairly recent Python 3 and numpy
module load <MODULES GO HERE> 

# Run your Python script
python small-matrix-gen.py

