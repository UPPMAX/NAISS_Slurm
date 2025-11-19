#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

#SBATCH -p alvis
# You need to ask for a GPU to run on alvis. 
# This is a CPU job. Do not do things like this normally!
# Only use for GPU jobs! 
#SBATCH -N 1 --gpus-per-node=T4:1
# Number of tasks - default is 1 core per task. Here 4  
# Modify for your needs. 
# Aim to use multiples of 16 of 32 for larger jobs (based on the number of cores per node) 
#SBATCH -n 4


# name output and error file
#SBATCH -o mpi_process_%j.out
#SBATCH -e mpi_process_%j.err

#Load a module with the same compiler and MPI library you used during compilation
module load foss/2023b

# write this script to stdout-file - useful for scripting errors
cat $0

# Run your mpi_executable
mpirun ./integration2D_f90 10000
