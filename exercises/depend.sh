#!/bin/bash

# Note - these versions listed below are for HPC2N - you need to make changes
# in them for them to work at other centres
# first job - no dependencies
jid1=$(sbatch --parsable run_matrix-gen.sh)

# Next job depend on first job 
sbatch --dependency=afterany:${jid1} run_mmmult-v2.sh

