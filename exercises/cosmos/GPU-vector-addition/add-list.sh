!/bin/bash
Remember to change this to your own project ID!
SBATCH -A luXXXX-Y-ZZ
We are asking for 5 minutes
SBATCH --time=00:05:00
SBATCH --ntasks-per-node=1
Asking for one A100 GPU
SBATCH -p gpua100
SBATCH --gres=gpu:1

Remove any loaded modules and load the ones we need
module purge  > /dev/null 2>&1
module load GCC/12.3.0  Python/3.11.3 OpenMPI/4.1.5 numba/0.58.1 SciPy-bundle/2023.07 CUDA/12.1.1

Run your Python script
python add-list.py

