#!/bin/bash
# This is a very simple example of how to run a Python script with a job array
# Project id - change to your own!
#SBATCH -A <proj-ID>
#SBATCH --time=00:05:00 # Asking for 5 minutes
#SBATCH --array=1-10   # how many tasks in the array 
#SBATCH -c 1 # Asking for 1 core    # one core per task 
# Setting the name of the output file 
#SBATCH -o hello-world-%j-%a.out

# Load any modules you need, here for Python 3.11.3
ml buildtool-easybuild/4.8.0-hpce082752a2 GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11 JupyterLab/4.2.0

# Run your Python script
srun python hello-world-array.py $SLURM_ARRAY_TASK_ID
