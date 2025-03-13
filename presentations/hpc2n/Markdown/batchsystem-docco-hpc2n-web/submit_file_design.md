# Slurm Submit File Design

To best use the resources with Slurm you need to have some basic information about the application you want to run.

Slurm will do its best to fit your job into the cluster, but you have to give it some hints of what you want it to do.

The parameters described below can be given directly as arguments to <code>srun</code> and <code>sbatch</code>.

If you don't give Slurm enough information, it will try to fit your job for best throughput (lowest possible queue time). This approach will not always give the best performance for your job (or, indeed, allow the job to run, in some cases).

To get the best performance, you will need to know the following:

- [Your account](#your__account__-a)
- [The number of tasks](#the__number__of__tasks__-n)
- [The number of cores per task](#the__number__of__cores__per__task__-c)
- [The number of tasks per node](#the__number__of__tasks__per__node__--ntasks-per-node)
- [Memory usage](#memory__usage)
- [The run/wallclock time](#the__runwallclock__time__--time__--time-min)
- [The number of nodes](#the__number__of__nodes__-n)
- [Number of GPUs needed](#number__of__gpus__needed)

Some extra parameters that might be usefull:

- [Sending output to files](#sending__output__to__files__--output--error)
- [Send mail on job changes](#send__mail__on__job__changes__--mail-type)
- [Exclusive](#exclusive__--exclusive)
- [Constraints](#constraints)

For basic examples for different types, see the [example section](./basic_examples.md):

- Basic serial job
- Basic MPI job
- Basic OpenMP job
- Basic MPI + OpenMP job
- Accessing the GPU resources (Kebnekaise)
- Multiple jobs
- Job arrays 


Some applications may have special needs, in order to get them running at full speed.

Look at the application specific pages (under [software](../software) for more information about any such special requirements.

Some commonly used programs [are listed below](#common__programs__which__have__special__requirements).

!!! Important

    If you do not use constraints to ask only for specific types of nodes, you may get any available node types that match your job's requirement. 

    Not all modules/versions exist on all node architectures! Make sure you check that the module you load in a batch script actually exist on the node(s) your job end up on (see [Different parts of the batch system](../batchsystem/resources/)). If you are not contraining the node types, pick module(s) and versions that exist on all node types. 

    The regular login node (``kebnekaise.hpc2n.umu.se``) can be used to see the modules available on broadwell and skylake nodes.

    The AMD login node (``kebnekaise-amd.hpc2n.umu.se``) can be used to see the modules available on the Zen3/Zen4 nodes.

<h3>First line in submit file</h3>

The submit file must start with:

```bash
#!/bin/bash
```

This is required for the module system to work. There are other possibilities, but this is the only one we fully support.


## Your account (-A)

The account is your project id, this is mandatory.

Example (HPC2N):

```bash
#SBATCH -A hpc2nXXXX-YYY
```

Example (NAISS):

```bash
#SBATCH -A naissXXXX-YY-ZZZ
```

You can find your project id by running:

```bash
$ projinfo
```

## The number of tasks (-n)

The number of tasks is for most usecases the number of processes you want to start. The default value is one (1).

An example could be the number of MPI tasks or the number of serial programs you want to start.

Example:

```bash
#SBATCH -n 28
```

## The number of cores per task (-c)

If your application is multi threaded (OpenMP/...) this number indicates the number of cores each task can use.

The default value is one (1).

Example:

```bash
#SBATCH -c 14
```

## The number of tasks per node (--ntasks-per-node)

If your application requires more than the maximum number of available cores in one node (for instance 28 on the skylake nodes on Kebnekaise) it might be wise to set the number of tasks per node, depending on your job. This is the (minimum) number of tasks allocated per node.

!!! Remember 

    (The total number of cores) = (the number of tasks) x (the number of cores per task).

There are 28 cores per node on the Skylake nodes on Kebnekaise, so this is the maximum number of tasks per node for those nodes. The largemem nodes have 72 cores. 
On Kebnekaise the number of cores depend on which type of nodes you are running. For more information, see the <a href="https://www.hpc2n.umu.se/resources/hardware/kebnekaise" target="_blank">Kebnekaise hardware page</a>.

!!! Note

    If you don't set this option, Slurm will try to spread the task(s) over as few available nodes as possible. 

    As an example, on a Skylake node (28 cores), this can result in a job with 22 tasks on one node, and 6 on another. 

    If you let slurm spread your job it is more likely to start faster, but the performance of the job might be hurting. 

    If you are using more than 28 cores (regular skylake node on kebnekaise) and are unsure of how your application behaves, it is probably a good thing to put an even spread over the number of required nodes.

There is usually no need to tell Slurm how many nodes that your job needs. It will do the math.

Example:

```bash
#SBATCH --ntasks-per-node=24
```

## Memory usage

| RAM per core | |
| ------------ | - | 
| Kebnekaise (broadwell) | 4460 MB | 
| Kebnekaise (skylake) | 6785 MB | 
| Kebnekaise largemem | 41666 MB | 
| Kebnekaise (Zen3, CPU) | 8020 MB |
| Kebnekaise (Zen3, with GPU) | 10600 MB |
| Kebnekaise (Zen3, A100) | 10600 MB |
| Kebnekaise (Zen4, CPU) | 2516 MB |
| Kebnekaise (Zen4, with GPU) | 6630 MB |
| | | 

Each core has a limited amount of memory available. If your job requires more memory than the default, you can allocate more cores for your task with <code>(-c)</code>.

If, for instance, you need 8000MB/task on a Kebnekaise Skylake node, set <code>"-c 2"</code>.

Example:

```bash
# I need 2 x 6785 MB (13570MB) of memory for my job.
#SBATCH -c 2
```

This will allocate two (2) cores with 6785 MB each. If your code is not multi-threaded (using only one core per task) the other one will just add its memory to your job.

If your job requires more memory / node on Kebnekaise, there are a limited number of nodes with 3072000MB memory, which you may be allowed to use (you apply for it as a separate resource when you make your project proposal in SUPR). They are accessed by selecting the largemem feature of the cluster. You do this by setting: <code>-C largemem</code>.

Example:

```bash
#SBATCH -C largemem
```

## The run/wallclock time (\--time, \--time-min)

If you know the runtime (wall clock time) of your job, it is beneficial to set this value as accurately as possible.

!!! Note 

    - Smaller jobs are more likely to fit into slots of unused space faster. Do not ask for (much) too long walltime. 
    - Please add some extra time to account for variances in the system. The job will end when the walltime is done, even if your calculation is not!
    - The maximum allowed runtime of any job is seven (7) days.

The format is:

- D-HH:MM:SS (D=Day(s), HH=Hour(s), MM=Minute(s), SS=Second(s))

Example:

```bash
# Runtime limit 2 days, 12hours
#SBATCH --time 2-12:00:00
```

You can also use the <code>\--time-min</code> option to set a minimum time for your job.
If you use this, Slurm will try to find a slot with more than <code>\--time-min</code> and less than <code>\--time</code>. This is useful if your job does periodic checkpoints of data and can restart from that point. This technique can be used to fill openings in the system, that no big jobs can fill, and so allows for better throughput of your jobs.

Example:

```bash
# Runtime limit 2 days, 12hours
#SBATCH --time 2-12:00:00
#
# Minimum runtime limit 1 days, 12hours
#SBATCH --time-min 1-12:00:00
```

## The number of nodes (-N)

It is possible to set the number of nodes that slurm should allocate for your job.

This should <u>only</u> be used together with <code>\--ntasks-per-node</code> or with <code>\--exclusive</code>.

But in almost every case it is better to let slurm calculate the number of nodes required for your job, from the number of tasks, the number of cores per task, and the number of tasks per node.

## Number of GPUs needed

!!! NOTE 

    - Your project need to have time on the GPU nodes to use them, as they are considered a separate resource. 
    - To request GPU resources one has to include a gpu request in the submit file. The general format is:
    ```bash
    #SBATCH --gpu=TYPE-OF-CARD:x
    ```
    where TYPE-OF-CARD is one of the available GPU types, v100, a40, a6000, l40s, h100, or not used at all to just get any free GPU.

## Sending output to files (\--output/\--error)

The output (<code>stdout</code>) and error (<code>stderr</code>) output from your program can be collected with the help of the <code>\--output</code> and <code>\--error</code> options to <code>sbatch</code>.

Example:

<div>
```bash 
# Send stderr of my program into <jobid>.error
#SBATCH --error=%J.error

# Send stdout of my program into <jobid>.output
#SBATCH --output=%J.output
```
</div>

The files in the example will end up in the working directory of you job.

In the above example, we use the Slurm environment variable <code>%J</code>, which contains the JOB-ID. This is very useful since that means we will always get a new output file or error file, and we do not risk overwriting a previous output. 

## Send mail on job changes (\--mail-type)

Slurm can send mail to you when certain event types occur.  Valid type values are: BEGIN, END, FAIL, REQUEUE, and ALL (any state change).

Example:

```bash
# Send mail when job ends
#SBATCH --mail-type=END
```

!!! Warning

    We recommend that you do NOT include a command for the batch system to send an email when the job has finished, particularly if you are running large amounts of jobs. The reason for this is that many mail servers have a limit and may block accounts (or domains) temporarily if they send too many mails. 

    Instead use 
    ```bash
    scontrol show job <jobid>
    ```
    or
    ```bash
    squeue -l -u <username>
    ```
    to see the status of your job(s).

## Exclusive (\--exclusive)

In some use-cases it is usefull to ask for the complete node (not allowing any other jobs, including your own, to share).

**<code>\--exclusive</code>** can be used with **<code>-N</code>** (number of nodes) to get all the cores, and memory, on the node(s) exclusively for your job.

Example:

```bash
# Request complete nodes
#SBATCH --exclusive
```

## Constraints 

If you need to run only on a specific type of nodes, then you can do this with the <code>\--constraint</code> flag: 

- <code>#SBATCH \--constraint=skylake</code>
- <code>#SBATCH \--constraint=GPU_DP</code>

## Common programs which have special requirements

- [AMBER](../software/apps/amber)
- [COMSOL](../software/apps/comsol)
- [Gaussian](../software/apps/gaussian)
- [MATLAB](../software/apps/matlab)
- [VASP](../software/apps/vasp)
