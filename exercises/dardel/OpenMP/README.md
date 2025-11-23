# Exercises for Running OpenMP code

We have two OpenMP codes.  One is a C-version of **hello world** the other one calculates a **double sum**.  The former code is suitable to test that your can run threads, while the second code can be used to explore performance differences when e.g. modifying the number of cores utilised. 

## Setup

For Dardel we provide build to generate executables for the CRAY Clang compiler and the GNU compiler.  On the commandline, type

```bash
./build.sh
```

to build for the CRAY clang compiler and 

```bash
./build_gnu.sh
```

to build for the GNU compiler.  If you want to switch between compilers you need to type

```bash
make clean
```

to enable a rebuild of the executables.  After doing so, you can run the other build script.

## Running 

We provide 4 batch scrips (aka SLURM scripts).   For each of the compilers we have a script to run the **hello** code or the **double sum** code.  The scripts are set up to use thread binging which for pure OpenMP codes (no MPI) is typically beneficial for application performance.

On Dardel **Hyperthreading** is active. By default two threads will be placed on a CPU.  E.g. when requesting eight cpus per task with the `--cpus-per-task` or the `-c` option one gets allocated for cores.  Two threads will be run on each core.  For some applications hyperthreading is beneficial, for others it is actually deterimental.  It is always recommended to test this for you applicaion.  

When using the CRAY compiler, hyperthreading can be disengaged by choosing a **core** binding using the environment variable **OMP_PLACES**.   When using a chosing a **thread** binding hyperthreading will be used.

The GNU compiler on Dardel does not respond in that way.  When hyperthreading is deterimental to the performance one should use the environment variable **OMP_NUM_THREADS** to start only half the threads as cpus per task requested.

Select a compiler and confirm with the hello code that you can start multiple threads.   Following this you can explore how the calculation of the double sum reponds to changing the thread count and whether or not is benefits from hyperthreading.