# Exercises for Running OpenMP code

We have two OpenMP codes.  One is a C-version of **hello world** the other one calculates a **double sum**.  The former code is suitable to test that your can run threads, while the second code can be used to explore performance differences when e.g. modifying the number of cores utilised. 

## Setup

For Tetralith we provide a build script to generate executables for the GNU compiler.  On the commandline, type

```bash
./build.sh
```
If you want to requild you have to clean up:

```bash
make clean
```

After doing so, you can run the build script again.

## Running 

We provide 2 batch scrips (aka SLURM scripts).   We have a script to run the **hello** code or the **double sum** code.  The scripts are set up to use thread binding, which for pure OpenMP codes (no MPI) is typically beneficial for application performance.

On Tetralith **Hyperthreading** is not active. When requesting cpus per task with the `--cpus-per-task` or the `-c` option one gets a physical cpu allocatate for each task  Each threads will be allocated its own physical core. 


To engage thread binding, one needs to set the environment variable **OMP_PROC_BIND**.  Codes that spend a limited in their performance by communication costs, often benefit from a **close** binding, while codes whose performance is limited by the memory bandwidth can often benefit from a **spread** binding.  Experimenting is with these options is recommended.
Threads can be bound to the physical cores by setting the  environment variable **OMP_PLACES** to **cores**.

Confirm with the hello code that you can start multiple threads.   Following this you can explore how the calculation of the double sum reponds to changing the thread count and whether or when using a **spread** or a **closed** binding.