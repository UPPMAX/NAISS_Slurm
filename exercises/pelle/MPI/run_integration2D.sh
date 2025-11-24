#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

# ask for 16 core here, modify for your needs.
#SBATCH -n 16

# name output and error file
#SBATCH -o mpi_process_%j.out
#SBATCH -e mpi_process_%j.err

# write this script to stdout-file - useful for scripting errors
cat $0

# Run your mpi_executable
mpirun ./integration2D_f90 10000
