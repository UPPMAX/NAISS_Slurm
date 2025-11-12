#!/bin/bash
# Remember to change this to your own project ID!
#SBATCH -A uppmaxXXXX-Y-ZZZ 
#SBATCH -t 00:15:00
#SBATCH -n 1
#SBATCH -M snowy
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
#SBATCH --gres=gpu=1
#SBATCH --exclusive

ml uppmax
ml python/3.11.8
module load python_ML_packages/3.11.8-gpu

python integration2d_gpu.py
python integration2d_gpu_shared.py
