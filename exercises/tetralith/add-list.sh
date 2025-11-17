#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A naissXXXX-YY-ZZZ
# We are asking for 5 minutes
#SBATCH --time=00:05:00
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --gpus-per-task=1

# Remove any loaded modules and load the ones we need
module purge  > /dev/null 2>&1
module load buildtool-easybuild/4.8.0-hpce082752a2 GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11 JupyterLab/4.2.0

# Load a virtual environment where numba is installed
# Use the one you created previously under "Install packages"
# or you can create it with the following steps:
# ml buildtool-easybuild/4.8.0-hpce082752a2 GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11 JupyterLab/4.2.0
# python -m venv mynumba
# source mynumba/bin/activate
# pip install numba
#
source <path-to>/mynumba/bin/activate

# Run your Python script
python add-list.py
