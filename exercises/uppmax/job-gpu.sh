#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A uppmaxXXXX-Y-ZZZ 
#SBATCH -t 00:15:00
#SBATCH -p gpu                                                                  
#SBATCH --gpus:l40s:1
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages

module load Python/3.12.3-GCCcore-13.3.0 
module load SciPy-bundle/2024.05-gfbf-2024a 
module load CUDA/12.9.0 
module load numba/0.60.0-foss-2024a 

python integration2d_gpu.py
python integration2d_gpu_shared.py
