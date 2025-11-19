#!/bin/bash
# Remember to change this to your own Project ID! 
#SBATCH -A naissXXXX-YY-ZZZ

#SBATCH -p alvis
# You need to ask for a GPU to run on alvis.
# This is a CPU job. Do not do things like this normally!
# Only use for GPU jobs!
#SBATCH -N 1 --gpus-per-node=T4:1
# Number of tasks - default is 1 core per task. Here 4 
#SBATCH -n 4

# Time in HHH:MM:SS - at most 168 hours. 
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge > /dev/null 2>&1
# Load foss module which includes MPI 
ml add foss/2023b

# Run the program. Remember to use "srun" unless the program handles parallelizarion itself
# Before running you need to compile it
# Load the above module then do 
# mpicc mpi_hello.c -o mpi_hello 
srun ./mpi_hello
