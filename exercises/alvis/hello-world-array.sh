#!/bin/bash
# This is a very simple example of how to run a Python script with a job array
# Project id - change to your own!
#SBATCH -A <proj ID>
#SBATCH --time=00:05:00 # Asking for 5 minutes
#SBATCH -p alvis
#SBATCH --array=1-10   # how many tasks in the array 
# You need to ask for a GPU to run on alvis. 
# This is a CPU job. Do not do things like this normally!
# Only use for GPU jobs! 
#SBATCH --gpus-per-node=T4:1
#SBATCH -n 1 -c 1 # Asking for 1 core    # one core per task 
# Setting the name of the output file 
#SBATCH -o hello-world-%j-%a.out

# Load any modules you need, here for Python 3.11.3
ml Python/3.11.3-GCCcore-12.3.0

# Run your Python script
srun python hello-world-array.py $SLURM_ARRAY_TASK_ID
