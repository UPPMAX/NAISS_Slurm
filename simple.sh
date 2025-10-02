#!/bin/bash
# Project id - change to your own!
#SBATCH -A PROJ-ID
# Asking for 1 core
#SBATCH -n 1
# Asking for a walltime of 1 min
#SBATCH --time=00:01:00

echo "What is the hostname? It is this: "

/bin/hostname
