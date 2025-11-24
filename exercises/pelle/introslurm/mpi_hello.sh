#!/bin/bash
# Remember to change this to your own Project ID! 
#SBATCH -A <project ID>

# Number of tasks - the default is 1 core per task. Here 14
#SBATCH -n 14
# Time in HHH:MM:SS - at most 168 hours. 
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge > /dev/null 2>&1
# Load foss module which includes MPI 
ml add foss/2023b

# Run the program. Remember to use "srun" unless the program handles parallelizarion itself
# Before running you need to compile it
# You would load the above module then do 
# mpicc mpi_hello.c -o mpi_hello 
# However, here we will just compile the code in the batch script. Don't do this normally! 
mpicc mpi_hello.c -o mpi_hello 

# Then run the code 
srun ./mpi_hello
