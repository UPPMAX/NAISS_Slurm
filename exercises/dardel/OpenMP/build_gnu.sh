#!/bin/bash

# load a modern gnu compiler with OpenMP library
module load PDC/24.11
module load gcc-native/13.2

# build the executable
make -f Makefile_gnu

