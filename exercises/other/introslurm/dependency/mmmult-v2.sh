#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <projID>
#SBATCH --time=00:25:00 # Asking for 25 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need for a recently new Python 3 and a compatible numpy
module load <MODULES GO HERE>

# Run your Python script
python mmmult-v2.py

