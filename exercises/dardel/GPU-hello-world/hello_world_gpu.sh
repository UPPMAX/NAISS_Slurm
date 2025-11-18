#!/bin/bash -l
# Remember to change this to your own project ID!
#SBATCH -A naissiXXXX-YY-ZZZ 
# Asking for runtime: hours, minutes, seconds. At most 1 week
#SBATCH --time=00:10:00
# Ask for resources, including GPU resources
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -p gpu
# Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

# Load any needed GPU modules and any prerequisites
ml rocm/6.3.3
ml craype-accel-amd-gfx90a

hipcc --offload-arch=gfx90a hello_world_gpu.cpp -o hello_world_gpu.x

./hello_world_gpu.x
