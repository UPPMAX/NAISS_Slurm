#!/bin/bash
# Change to your own project ID! 
#SBATCH -A <proj-ID>
#SBATCH --time=00:12:00 # Asking for 12 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need, here for Python 3.11.3 and compatible SciPy-bundle
module purge  > /dev/null 2>&1
module load buildtool-easybuild/4.8.0-hpce082752a2 GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11 JupyterLab/4.2.0

# Run your Python script
python matrix-gen.py

