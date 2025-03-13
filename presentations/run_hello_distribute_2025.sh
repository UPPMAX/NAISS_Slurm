#!/bin/bash

# specify jobtime
#SBATCH -t 00:05:00

# specify the project to be charged<
#SBATCH -A naiss2025-xx-xxxx

#SBATCH -J hello_10

#SBATCH -o result_hello_10_%j.out
#SBATCH -e result_hello_10_%j.err

#SBATCH --mail-user=xxx123@yyy.zzzzzzz.se
#SBATCH --mail-type=END

cat $0

sleep 10

echo "hello form:" $HOSTNAME

