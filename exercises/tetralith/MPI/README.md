# Exercise for MPI running

## Setup

We have an MPI-application performing a 2-dimensional integration.  The application is written in FORTRAN and you need to build an executable.  To assist you there is a shell script called `build.sh` which does that for you.  Please run

```bash
./build.sh
```

on the commandline.  You should obtain an executable named `integration2D_f90`.

## Running on the system

We provide a sample submission script `run_integration2D.sh` for Tetralith.   This is setup to use 16 cores (1/2 of a Tetralith node).   You need to update the script with your project ID and can submit it to the queue using the `squeue` command.  In your output file your should find a copy of the submission script and the output from the program.   The program output should look similar to:

```
   Integral value is   2.5967184132114074E-015 Error is   2.5967184132114074E-015
   Time for loop and MPI_REDUCE   9.8573137000000005E-002 seconds
```

Modify the script to ask for 8 cores and submit again.  What happens to the time used by the program?