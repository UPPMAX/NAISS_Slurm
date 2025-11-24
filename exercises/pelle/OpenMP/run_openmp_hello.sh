#!/bin/bash

# Set account 
#SBATCH -A <project ID> 

# Set the time, 
#SBATCH -t 00:10:00

# ask for 8 core here, modify for your needs.
# When running OpenMP code on Tetralith one can ask up to 32 cores
#SBATCH -c 8

# name output and error file
#SBATCH -o omp_process_%j.out
#SBATCH -e omp_process_%j.err

# write this script to stdout-file - useful for scripting errors
cat $0

# process binding is typically recommended.  Try what works best spread or close
#export OMP_PROC_BIND=spread
export OMP_PROC_BIND=close

# we bind to cores
export OMP_PLACES=cores

# Run your OpenMP executable
./omp_hello
