#!/bin/bash
#SBATCH -A <proj-id>    ###replace with your project ID
#SBATCH -t 00:05:00
#SBATCH -n 1
#SBATCH -p shared

echo $HOSTNAME
