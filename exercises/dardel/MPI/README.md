# Exercise for MPI running

## Setup

We have two MPI-applications.  One is an MPI hello world code, demonstrating running on a number of cores, the other one is performing a 2-dimensional integration.  The applications are written in FORTRAN and you need to build an executable.  To assist you there is a shell script called `build.sh` which does that for you.  Please run

```bash
./build.sh
```

on the commandline.  You should obtain an executable named `integration2D_f90` and a second executable `mpi_hello`.

## Running on the system

For the `mpi_hello` executable we provide two sample scripts.   On of them `run_mpi_hello.sh` requests part of a node, which is what you would do for a code that can't reasonably utilise a large number of cores.  On Dardel you have to explicitly ask to be places on a single node.  This is best done using the `-N` and the `--tasks-per-node` options of sbatch.  MPI codes utilising part of a node on Dardel need to run in the **shared partition**. Confirm from the output that all tasks run on the same node.  On Dardel you have to specify the modules providing the shared libraries required by your code.   This is done with a `module load` command inside the script.

The next script `run_mpi_hello_multinode.sh` utilises two full nodes.  Requesting multiple nodes is what you would do when running a code with problem size that can efficiently utilise a large number of cores.  Unless there are special memory needs, such scripts should run in the **main partition** or the **long partion** depending on the required run time.   Confirm that you have been allocated on exactly two nodes and half of the tasks have been placed on each node.

We also provide a sample submission script `run_integration2D.sh` for Tetralith.   This is setup to use 16 cores (1/2 of a Tetralith node).   You need to update the script with your project ID and can submit it to the queue using the `squeue` command.  In your output file your should find a copy of the submission script and the output from the program.   The program output should look similar to:

```
   Integral value is   2.5967184132114074E-015 Error is   2.5967184132114074E-015
   Time for loop and MPI_REDUCE   9.8573137000000005E-002 seconds
```

Modify the script to ask for 8 cores and submit again.  What happens to the time used by the program?