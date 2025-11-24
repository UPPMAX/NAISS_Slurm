#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

# ask for 64 core here, modify for your needs.
# Aim to use multiples of 32 for larger jobs
#SBATCH -n 64

# name output and error file
#SBATCH -o mpi_process_%j.out
#SBATCH -e mpi_process_%j.err

# write this script to stdout-file - useful for scripting errors
cat $0

# Run your mpi_executable
mpirun ./mpi_hello
