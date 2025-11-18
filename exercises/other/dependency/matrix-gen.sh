#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj ID>
#SBATCH --time=00:12:00 # Asking for 12 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need for a fairly recent Python 3 and numpy
module load <MODULES GO HERE> 

# Run your Python script
python matrix-gen.py

