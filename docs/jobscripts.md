# Sample job scripts

## The Simplest Job

The simplest possible batch script would look something like this:

```bash
#!/bin/bash
#SBATCH -A lu20yy-x-xx    ###replace with your project ID
#SBATCH -t 00:05:00

echo $HOSTNAME
```

The first line is called the "shebang" and it indicates that the script is
written in the bash shell language.

The second and third lines are resource statements. The second line above is a
template resembling typical project IDs at LUNARC. While not technically required
if you only have one project to your name, we recommend that you make a habit of
including it. The third line in the example above provides the walltime, the
maximum amount of time that the program would be allowed to run (5 minutes in
this example). If a job does not finish within the specified walltime, the
resource management system terminates it and any data that were not already
written to a file before time ran out are lost.

The last line in the above sample is the code to be executed by the batch script.
In this case, it just prints the name of the server on which the code ran.

All of the parameters that Slurm needs to determine which resources to allocate,
under whose account, and for how long, must be given as a series of resource
statements of the form `#SBATCH -<option> <value>` or `#SBATCH --<key-words>=<value>`
(*note: `<` and `>` are not typically used in real arguments; they're just used*
*here to indicate placeholder text*). For most compute nodes, unless otherwise
specified, a batch script will run on 1 core of 1 node by default. However, the
default settings may vary between HPC centers or between partitions at the same
HPC center.

## Basic Serial Job

Let's say you have a simple Python script called `mmmult.py` that creates 2
random-valued matrices, multiplies them together, and prints the shape of the
result and the computation time. Let's also say that you want to run this code
in your current working directory. Here is how you might run that program once
on 1 core and 1 node:

```bash
#!/bin/bash
#SBATCH -A lu20yy-x-xx       ### replace with your project ID
#SBATCH -t 00:10:00          ### walltime in hh:mm:ss format
#SBATCH -J mmmult            ### sample job name; customize as desired or omit
#SBATCH -o process_%j.out    ### filename for stderr - customise, include %j
#SBATCH -e process_%j.err    ### filename for stderr - customise, include %j
#SBATCH -n 1                 ### number of cores to use; same as --ntasks-per-node

# write this script to stdout-file - useful for scripting errors
cat $0

# Purge any loaded modules
ml purge > /dev/null 2>&1

# Load required modules; customize as needed
# Can omit module version number if prerequisites only allow one version
ml foss/2023b Python/3.11.5 SciPy-bundle

#run the script
python3 mmmult.py
```

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

- More information here on the official Slurm documentation pages: <a href="https://slurm.schedmd.com/job_array.html" target="_blank">https://slurm.schedmd.com/job_array.html</a>.

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
