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
#SBATCH -n 1                 ### number of cores to use; same as --ntasks-per-node

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
    #SBATCH -A naiss2025-22-934 # Change to your own
    #SBATCH --time=00:10:00 # Asking for 10 minutes
    #SBATCH -n 1 # Asking for 1 core

    # Load any modules you need, here GCC 11.3.0 and Python 3.10.4
    module load buildtool-easybuild/4.8.0-hpce082752a2 GCC/11.3.0 OpenMPI/4.1.4 Python/3.10.4 SciPy-bundle/2022.05

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

## MPI 

## Memory-intensive jobs 

## I/O intensive jobs 

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
