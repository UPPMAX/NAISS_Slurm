#!/bin/bash
# Remember to change this to your own project ID after the course!
#SBATCH -A NAISS2025-22-934
#SBATCH -t 00:15:00
#SBATCH -p alvis
#SBATCH -N 1 --gpus-per-node=T4:4
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages

ml purge > /dev/null 2>&1
ml Python/3.11.3-GCCcore-12.3.0 OpenMPI/4.1.5-GCC-12.3.0 SciPy-bundle/2023.07-gfbf-2023a CUDA/12.1.1 numba/0.58.1-foss-2023a

python compute.py
