# Sample job scripts

## Basic Serial Job

Let's say you have a simple Python script called `mmmult.py` that creates 2
random-valued matrices, multiplies them together, and prints the shape of the
result and the computation time. Let's also say that you want to run this code
in your current working directory. 

Here is how you might run that program once on 1 core and 1 node:

```bash
#!/bin/bash
#SBATCH -A <project ID>      ### replace with your project ID
#SBATCH -t 00:10:00          ### walltime in hh:mm:ss format
#SBATCH -J mmmult            ### sample job name; customize as desired or omit
#SBATCH -o process_%j.out    ### filename for stderr - customise, include %j
#SBATCH -e process_%j.err    ### filename for stderr - customise, include %j
#SBATCH -n 1                 ### number of cores to use

# write this script to stdout-file - useful for scripting errors
cat $0

# Purge any loaded modules
# Some centres recommend this, while at other centres (PDC in particular) this
# should not be done. 
ml purge > /dev/null 2>&1

# Load required modules; customize as needed - this is for LUNARC 
# Can omit module version number if prerequisites only allow one version
ml foss/2023b Python/3.11.5 SciPy-bundle

#run the script
python3 mmmult.py
```

### Examples by centre 

Let us look at the above batch script as it might be written for some other centres. 

=== "Tetralith"

    ```bash
    #!/bin/bash

    # Set account 
    #SBATCH -A <project ID> 

    # Set the time, 
    #SBATCH -t 00:10:00

    # ask for 1 core, serial running 
    #SBATCH -n 1 # Asking for 1 core

    # name output and error file
    #SBATCH -o process_%j.out
    #SBATCH -e process_%j.err

    # write this script to stdout-file - useful for scripting errors
    cat $0

    # load a modern Python distribution and make NumPy available
    module load buildtool-easybuild/4.9.4-hpc71cbb0050 
    module load GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11

    # Run your Python script
    python mmmult.py
    ```

=== "Dardel"

     ```bash
     #!/bin/bash
     #SBATCH -A naiss2025-22-934 # Change to your own
     #SBATCH --time=00:10:00 # Asking for 10 minutes
     #SBATCH -n 1 # Asking for 1 core

     # Load any modules you need, here for cray-python/3.11.7.
     module load cray-python/3.11.7

     # Run your Python script
     python mmmult.py
     ```

=== "HPC2N"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2n2025-151 # Change to your own
    #SBATCH --time=00:10:00 # Asking for 10 minutes
    #SBATCH -n 1 # Asking for 1 core

    # Load any modules you need, here for Python/3.11.3 and compatible SciPy-bundle
    module load GCC/12.3.0 Python/3.11.3 SciPy-bundle/2023.07

    # Run your Python script
    python mmmult.py
    ```

=== "LUNARC"

    ```bash
    #!/bin/bash
    #SBATCH -A luXXXX-Y-ZZ # Change to your own
    #SBATCH --time=00:10:00 # Asking for 10 minutes
    #SBATCH -n 1 # Asking for 1 core

    # Load any modules you need, here for Python/3.11.5 and compatible SciPy-bundle
    module load GCC/13.2.0 Python/3.11.5 SciPy-bundle/2023.11

    # Run your Python script
    python mmmult.py
    ```

=== "UPPMAX"

    ```bash
    #!/bin/bash -l
    #SBATCH -A uppmaxXXXX-Y-ZZZ # Change to your own after the course
    #SBATCH --time=00:10:00 # Asking for 10 minutes
    #SBATCH -n 1 # Asking for 1 core

    # Load any modules you need, here Python 3.11.8.
    module load python/3.11.8

    # Run your Python script
    python mmmult.py
    ```

=== "mmmult.py"

    ```python
    import timeit
    import numpy as np

    starttime = timeit.default_timer()

    np.random.seed(1701)

    A = np.random.randint(-1000, 1000, size=(8,4))
    B = np.random.randint(-1000, 1000, size =(4,4))

    print("This is matrix A:\n", A)
    print("The shape of matrix A is ", A.shape)
    print()
    print("This is matrix B:\n", B)
    print("The shape of matrix B is ", B.shape)
    print()
    print("Doing matrix-matrix multiplication...")
    print()

    C = np.matmul(A, B)

    print("The product of matrices A and B is:\n", C)
    print("The shape of the resulting matrix is ", C.shape)
    print()
    print("Time elapsed for generating matrices and multiplying them is ", timeit.default_timer() - starttime)
    ```

There is no example for Alvis since you should only use that for running GPU jobs. 

## OpenMP 

```bash
#!/bin/bash 
#SBATCH -A <account>
#SBATCH -t HHH:MM:SS 
#SBATCH -c <cores-per-task> 

module load <modules>

# Set OMP_NUM_THREADS to the same value as -c with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

./myopenmpprogram
```

- ``-c`` is used to set cores per task and should be the same as ``OMP_NUM_THREADS``
- Remember, Alvis is only for GPU jobs 

## Applications using MPI

Some form of message passing is required when utilising multiple nodes for a simulation.  One has multiple programs, called tasks, running.  Typically these are multiple copies of the same executable with each getting its own dedicated core.  Each task has its own memory, which is called distributed memory.  Data exchange is facilitated by coping data between the tasks. This can accomplished inside the node if both task are running on the same node or has to utilise the network if the tasks in question are located on different nodes.  The **Message Passing Interface (MPI)** is the most commonly used API in scientific computing, when programming message passing applications.

The illustration shows 5 tasks being executed, with the time running from the top to the bottom.  At the beginning, data (e.g. read from an input file) is distributed from task 0 to the other tasks, indicated by the blue arrows.  Following this, the tasks exchange data at regular intervalls.   In a real application the communication patterns are typically more complex than this.

![mpi illustration](./images/mpi_illustration.png){: style="width: 500px;float: right"}

!!! Important

    When runing an executable that utilises MPI you need to start multiple executables.  Typically you start one executable on each requested core. Most of the time multiple copies of the same excutable are used.  

    To start multiple copies of the same executable a special program, a so called **job launcher** is required.  Depending on the system and libraries used the name of the jobs launcher differs.


=== "Tetralith"

    *Sample scipt to come*

=== "Dardel"
        
    *Sample scritp to come*

```bash
#!/bin/bash 
#SBATCH -A <account>
#SBATCH -t HHH:MM:SS 
#SBATCH -n <tasks> 

module load <modules>

srun ./mympiprogram
```

- Asking for whole nodes (``- N``) and possibly ``--tasks-per-node``
- ``srun`` and ``mpirun`` should be interchangeable at many centres. Tetralith uses ``mpprun`` and Dardel uses ``srun``
- Remember, you need to load modules with MPI
- At some centres ``mpirun --bind-to-core`` or ``srun --cpu-bind=cores`` is recommended for MPI jobs 
- NOTE: Alvis is **only** used for GPU jobs

## Memory-intensive jobs 

- Running out of memory ("OOM"):
    - usually the job stops ("crashes")
    - check the Slurm error/log files
    - check with sacct/seff/jobstats/job-usage depending on cluster
- Fixes:
    - use "fat" nodes
    - allocate more cores just for memory
    - tweak mem usage in app, if possible

### Increasing memory per task

A way to increase memory per task that works generally is to simply ask for more cores per task, where some are just giving memory.

!!! note "Example"

    In this case, we are asking for 16 tasks, with 2 cores per task. This means we are asking for 32 cores in total. We do this by adding this to our batch script: 

    ```bash
    #SBATCH --ntasks=16 --cpus-per-task=2
    ```

    **NOTE** You can also write 

    - ``--cpus-per-task=#num`` in short form as ``-c #num``
    - ``--ntasks=#numtasks`` in short form as ``-n #numtasks``  

**Example script template**

Here asking for 8 tasks, 2 cores per task. 

```bash 
#!/bin/bash
#SBATCH -A <account>
#SBATCH -t HHH:MM:SS
#SBATCH -n 8
#SBATCH -c 2

module load <modules>

srun ./myprogram
```

**Example script template**

Here we have a non-threaded code which needs more memory (up to twice the amount we have on two cores). 

```bash 
#!/bin/bash
#SBATCH -A <account>
#SBATCH -t HHH:MM:SS
#SBATCH -c 2

module load <modules>

./myprogram
```

**Remember**: if you are on Dardel, you also need to add a partition. 


!!! note 

    At some centres, you can also use ``#SBATCH --mem-per-cpu=<MEMORY>``. If you ask for more memory than is on one core, some cores will have to remain idle while only providing memory. You will also be charged for these cores, of course.

    To see the amount of available memory per core, see the next section. 

### Memory availability 

Another way of getting extra memory is to use nodes that have more memory. Here is an overview of some of the available nodes at the Swedish HPC centres: 

=== "Tetralith"

    | Type | RAM/node | RAM/core | cores/node | Requesting flag | 
    | Intel Xeon Gold 6130 thin | 96 GB | 3 GB | 32 | ``-C thin --exclusive`` | 
    | Intel Xeon Gold 6130 fat | 384 GB | 12 GB | 32 | ``-C fat --exclusive`` | 

=== "Dardel"

    | Type | RAM/node | RAM/core | cores/node | Partition | Available | Requesting flag |
    | ---- | -------- | -------- | ---------- | --------- | --------- | ------------ |
    | AMD EPYC™ Zen2 Thin | 256 GB | 2 GB | 128 | main, shared, long | 227328 MB | |
    | AMD EPYC™ Zen2 Large | 512 GB | 4 GB | 128 | main, memory | 456704 MB | ``--mem=440GB`` |
    | AMD EPYC™ Zen2 Huge | 1 TB | 7.8 GB | 128 | main, memory | 915456 MB | ``--mem=880GB`` |
    | AMD EPYC™ Zen2 Giant | 2 TB | 15.6 GB | 128 | memory | 1832960 MB | ``--mem=1760GB`` |
    | 4 x AMD Instinct™ MI250X dual GPUs | 512 GB | gpu | 8 GB | 64 | 456704 MB | ``--mem=440GB`` |

    On shared partitions you need to give number of cores and will get RAM equivalent for that

=== "Alvis" 

    | RAM | GPUs | Requesting flag | 
    | --- | ---- | ------------ | 
    | 768 | V100 (2) <br> V100 (4) <br> and a no GPU skylake | ``#SBATCH -C MEM768`` <br> ``#SBATCH --gpus-per-node=V100:[1-4]`` |
    | 576 | T4 (8) | ``#SBATCH -C MEM576`` <br> ``#SBATCH --gpus-per-node=T4:[1-8]`` |
    | **1536** | T4 (8) | ``#SBATCH -C MEM1536`` <br> ``#SBATCH --gpus-per-node=A40:[1-4]`` |
    | **512** | A100 (4) <br> and a no GPU icelake | ``#SBATCH -C mem512`` <br> ``#SBATCH --gpus-per-node=A100:[1-4]`` |
    | 256 | A40 (4, no IB) <br> A100 (4) | ``#SBATCH -C mem256`` and either <br> ``#SBATCH --gpus-per-node=A40[1-4]`` <br> or ``#SBATCH --gpus-per-node=A100[1-4]`` |
    | 1024 | A100fat (4) | ``#SBATCH -C mem1024`` <br> ``#SBATCH --gpus-per-node=A100fat:[1-4]`` |

    - **Note** be aware, though that you also need to ask for a GPU, as usual, unless you need the pre/post processing CPU nodes (``-C NOGPU``).
    - You only really need to give the mem constraint for those bolded as the others follow from the GPU choice
    - ``sinfo -o "%20N  %9P %4c  %24f  %50G"`` will give you a full list of all nodes and features 

=== "Kebnekaise" 

    | Type | RAM/core | cores/node | requesting flag |
    | ---- | -------- | ---------- | --------------- |
    | Intel Skylake | 6785 MB | 28 | ``-C skylake`` |
    | AMD Zen3 | 8020 MB | 128 | ``-C zen3`` |
    | AMD Zen4 | 2516 MB | 256 | ``-C zen4`` |
    | V100 | 6785 MB | 28 | ``--gpus=<#num> -C v100`` |
    | A100 | 10600 MB | 48 | ``--gpus=<#num> -C a100`` |
    | MI100 | 10600 MB | 48 | ``--gpus=<#num> -C mi100`` |
    | A6000 | 6630 MB | 48 | ``--gpus=<#num> -C a6000`` |
    | H100 | 6630 MB | 96 | ``--gpus=<#num> -C h100`` |
    | L40s | 11968 MB | 64 | ``--gpus=<#num> -C l40s`` |
    | A40 | 11968 MB | 64 | ``--gpus=<#num> -C a40`` |
    | Largemem | 41666 MB | 72 | ``-C largemem`` |

=== "Cosmos" 

    | Type | RAM/core | cores/node | requesting flag | 
    | ---- | -------- | ---------- | --------------- |
    | AMD 7413 | 5.3 GB | 48 | |  
    | Intel / A100 | 12 GB | 32 | ``-p gpua100i``
    | AMD / A100 | 10.7 GB | 48 | ``-p gpua100`` | 


=== "Pelle" 

    | Type | RAM/node | RAM/core | cores/node | requesting flag | 
    | ---- | -------- | -------- | ---------- | --------------- | 
    | AMD EPYC 9454P (Zen4) | 768 GB | 16 GB | 48 | ``-p pelle``
    | AMD EPYC 9454P (Zen4) | 2 or 3 TB | 41.67 or 62.5 GB | 48 | ``-p fat`` | 
    | 2xAMD EPYC 9124 (Zen4), 10xL40s | 384 GB | 12 GB | 32 | ``-p gpu --gpus=l40s:[1-10]`` | 
    | 2xAMD EPYC 9124 (Zen4), 2xH100 | 384 GB | 12 GB | 32 | ``-p gpu --gpus=h100:[1-2]`` | 

    In addition you can use all the Slurm options for memory: 

    - ``--mem``
    - ``--mem-per-cpu``
    - ``--mem-per-gpu`` 

    to specify memory requirements.


!!! note "Pelle at UPPMAX" 

    The compute node CPUs have Simultaneous multithreading (SMT) enabled. Each CPU core runs two Threads. In Slurm the Threads are referred to as CPUs. 

    If you suspect SMT degrades the performance of your jobs, you can you can specify ``--threads-per-core=1`` in your job.

    More information here: <a href="https://docs.uppmax.uu.se/cluster_guides/slurm_on_pelle/#smt" target="_blank">Simultaneous multi-threading</a>. 

## I/O intensive jobs 

!!! NOTE

    This section comes with many caveats; it depends a lot on the type of job and the system. Often, if you are in the situation where you have an I/O intensive job, you need to talk to support as it will be very individualized. 

- In most cases, you should use the project storage
- Centre-dependent. If needed you can use node-local disk for **single-node** jobs
    - Remember you need to copy data to/from the node-local scratch (``$SNIC_TMP``)! 
    - On some systems ``$TMPDIR`` also points to the node local disk
    - The environment variable ``$SLURM_SUBMIT_DIR`` is the directory you submitted from
- On Tetralith, the data access between /home or /proj and GPU/CPU compute nodes are **not** suitable for I/O intensive jobs => use /scratch/local (``$SNIC_TMP``)

### Example 

```bash
#!/bin/bash 
#SBATCH -A <account>
#SBATCH -t HHH:MM:SS 
#SBATCH -n <cores>

module load <modules>

# Copy your data etc. to node local scratch disk
cp -p mydata.dat $SNIC_TMP
cp -p myprogram $SNIC_TMP

# Change to that directory
cd $SNIC_TMP

# Run your program
./myprogram

# Copy the results back to the submission directory 
cp -p mynewdata.dat $SLURM_SUBMIT_DIR
```

!!! warning "NOTE"

    When using node local disk it is important to remember to copy the output data back, since it will go away when the job ends!

## Job arrays 

- Job arrays: a mechanism for submitting and managing collections of similar jobs.
- All jobs must have the same initial options (e.g. size, time limit, etc.)
- the execution times can vary depending on input data
- You create multiple jobs from one script, using the ``-- array`` directive.
- This requires very little BASH scripting abilities
- max number of jobs is restricted by max number of jobs/user - centre specific

- [More information here on the official Slurm documentation pages.](https://slurm.schedmd.com/job_array.html)

!!! note "Example"

    This shows how to run a small Python script ``hello-world-array.py`` as an array. 

    ```py
    # import sys library (we need this for the command line args)
    import sys

    # print task number
    print('Hello world! from task number: ', sys.argv[1])
    ```

    You could then make a batch script like this, ``hello-world-array.sh``: 

    ```bash
    #!/bin/bash
    # A very simple example of how to run a Python script with a job array
    #SBATCH -A <account>
    #SBATCH --time=00:05:00 # Asking for 5 minutes
    #SBATCH --array=1-10   # how many tasks in the array
    #SBATCH -c 1 # Asking for 1 core    # one core per task
    # Create specific output files for each task with the environment variable %j
    # which contains the job id and %a for each step
    #SBATCH -o hello-world-%j-%a.out

    # Load any modules you need
    module load <module> <python-module> 

    # Run your Python script
    srun python hello-world-array.py $SLURM_ARRAY_TASK_ID
    ```

    You can find the above script under one of the cluster resources folders in the exercise tarball. 

### Some array comments 

- Default step of 1
    - Example: ``#SBATCH --array=4-80``
- Give an index (here steps of 4)
    - Example: ``#SBATCH --array=1-100:4``
- Give a list instead of a range
    - Example: ``#SBATCH --array=5,8,33,38``
- Throttle jobs, so only a smaller number of jobs run at a time
    - Example: ``#SBATCH --array1-400%4``
- Name output/error files so each job (``%j`` or ``%A``) and step (``%a``) gets  own file
    - ``#SBATCH -o process_%j_%a.out``
    - ``#SBATCH -e process_%j_%a.err``
- There is an environment variable ``$SLURM_ARRAY_TASK_ID`` which can be used to check/query with

## GPU jobs 

There are some differences between the centres in Sweden what type of GPUs they have. 

| Resource | cores/node | RAM/node | GPUs, type (per node) | 
| -------- | ---------- | -------- | ---- |
| Tetralith | 32 | 96-384 GB | Nvidia T4 GPUs (1) | 
| Dardel | 128 | 256-2048 GB | 4 AMD Instinct™ MI250X (2) | 
| Alvis | 16 (skylake 2xV100), <br>32 (skylake 4xV100, 8xT4), <br>64 (icelake 4xA40, <br>4xA100) | 256-1024 GB | Nvidia v100 (2), <br>v100 (4), <br>T4 (8), <br>A40 (4), <br>A100 (4) |
| Kebnekaise | 28 (skylake), <br>72 (largemem), <br>128/256 (Zen3/Zen4) | 128-3072 GB | NVidia v100 (2), <br>NVidia a100 (2), <br>NVidia a6000 (2), <br>NVidia l40s (2 or 6), <br>NVidia H100 (4), <br>NVidia A40 (8), <br>AMD MI100 (2) |
| Cosmos | 32 (Intel) or 48 (AMD) | 256-512 GB | A100 |
| Pelle | 32 | 384 GB | L40s (10), H100 (2) | 

- Alvis also has a small number of nodes without GPUs, for heavy-duty pre- and post-processing that does not require a GPU. To use, specify the constraint ``-C NOGPU`` in your Slurm script.

### Allocating a GPU 

This is the most different of the Slurm settings, between centers.

| Resource | batch settings | Comments |
| -------- | -------------- | -------- |
| Tetralith | ``#SBATCH -n 1``  <br>``#SBATCH -c 32`` <br>``#SBATCH --gpus-per-task=1`` | |
| Dardel    | ``#SBATCH -N 1``  <br>``#SBATCH --ntasks-per-node=1``  <br>``#SBATCH -p gpu`` | |
| Alvis | ``#SBATCH -p alvis``  <br>``#SBATCH -N <nodes>``  <br>``#SBATCH --gpus-per-node=<type>:x`` | - no node-sharing on multi-node jobs  <br> (``--exclusive`` is automatic)  <br>- Requesting -N 1 does not mean 1 full node | 
| Cosmos | ``#SBATCH -p gpua100`` <br>``#SBATCH --gres=gpu:1`` | |
| Kebnekaise | ``#SBATCH --gpus=x``  <br>``#SBATCH -C <type>`` | | 
| Pelle | | | 

### Example GPU scripts 

This shows a simple GPU script, asking for 1 or 2 cards on a single node. 

=== "NSC"

## Miscellaneous  
