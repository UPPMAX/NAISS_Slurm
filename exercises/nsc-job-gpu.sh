#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A <proj-ID>
#SBATCH -t 00:20:00
#SBATCH -n 24
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
#SBATCH --gpus-per-task=1
#SBATCH --exclusive

ml purge > /dev/null 2>&1
ml buildtool-easybuild/4.8.0-hpce082752a2 GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11 JupyterLab/4.2.0

# This code needs numba which is not installed as a module on Tetralith. 
# Thus it needs to be installed in a virtual environment (or using conda). 
# Here I am installing it to a virtual environment a subdirectory in this directory
python -m venv mynumba
source mynumba/bin/activate
pip install numba
pip install tensorflow

# Now we can run the code 
python integration2d_gpu.py
python integration2d_gpu_shared.py
