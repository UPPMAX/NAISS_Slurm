#!/bin/bash

# first job - no dependencies
jid1=$(sbatch --parsable matrix-gen.sh)

# Next job depend on first job 
sbatch --dependency=afterany:${jid1} mmmult-v2.sh

