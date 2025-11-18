#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A <proj ID>
#SBATCH -t 00:15:00

# Allocate resources needed. 1 GPU and any CPUs that might be needed at your center
#SBATCH -N <IF ANY WHOLE NODES>
#SBATCH -n <IF ANY CORES>
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
# Asking for 1 GPU
#SBATCH <ANYTHING NEEDED TO LOAD A GPU>

# Load any modules you need for a fairly recent Python 3, MPI, Numpy, CUDA, numba 
module load <MODULES GO HERE>

python integration2d_gpu.py
python integration2d_gpu_shared.py
