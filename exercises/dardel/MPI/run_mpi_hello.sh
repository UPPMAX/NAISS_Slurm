#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

# Using the Dardel shared partition
#SBATCH -p shared

# ask for 16 core here, modify for your needs.
# Aim to use multiples of 128 cores for larger jobs
#SBATCH -n 16

# name output and error file
#SBATCH -o mpi_process_%j.out
#SBATCH -e mpi_process_%j.err

# write this script to stdout-file - useful for scripting errors
cat $0

# Loading a suitable module. Here for Cray programming environment etc.
module load PDC/24.11

# Run your mpi_executable
srun ./mpi_hello
