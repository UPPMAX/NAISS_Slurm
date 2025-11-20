#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

# Using the Dardel shared partition
#SBATCH -p shared

# ask for 16 core on one node, modify for your needs.
#SBATCH -N 1
#SBATCH --ntasks-per-node=16

# name output and error file
#SBATCH -o mpi_process_%j.out
#SBATCH -e mpi_process_%j.err

# write this script to stdout-file - useful for scripting errors
cat $0

# Loading a suitable module. Here for Cray programming environment etc.
module load PDC/24.11

# Run your mpi_executable
srun ./mpi_hello
