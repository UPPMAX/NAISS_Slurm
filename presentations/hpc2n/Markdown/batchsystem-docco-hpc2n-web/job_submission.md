# Job Submission

There are three ways to run a job with Slurm: command line, job submission file, and interactively.

## Command line

A job can simply be submitted from the command line with <code>srun</code>.

!!! Example

    ```bash
    $ srun -A hpc2nXXXX-YYY -N 2 --exclusive --time=00:30:00 my_program
    ```

    - This example asks for exclusive use of two nodes to run the program <code>my_program</code>
    - It also asks for a time limit of 30 minutes. 
    - Since the number of tasks has not been specified, it assumes the default of one task per node. 
    - Note that the <code>\--exclusive</code> parameter guarantees no other jobs will run on the allocated nodes. Without the <code>\--exclusive</code> parameter, Slurm would only allocate the minimum assignable resources for each node. 
    - The job is run in the project hpc2nXXXX-YYY (change to your own project).

When submitting the job this way, you give all the commands on the command line, and then you wait for the job to pass through the job queue, run, and complete before the shell prompt returns, allowing you to continue typing commands.

This is a good way to run quick jobs and get accustomed to how Slurm works, but it is not the recommended way of running longer programs, or MPI programs; these types of jobs should run as a batch job with a Job Submission File. This also has the advantage of letting you easily see what you did last time you submitted a job.

## Job Submission File

Instead of submitting the program directly to Slurm with srun from the command line, you can submit a batch job with sbatch. This has the advantage of you not having to wait for the job to start before you can use your shell prompt.

Before submitting a batch job, you first write a **job submission file**, which is an executable shell script. It contains all the environment setup, commands and arguments to run your job (other programs, MPI applications, srun commands, shell commands, etc). When your job submission file is ready, you submit it to the job queue with **<code>sbatch</code>**. <code>sbatch</code> will add your job to the queue, returning immediately so you can continue to use your shell prompt. The job will run when resources become available.

When the job is complete, you will, if not specified otherwise with directives, get a file named <code>slurm-JOBID.out</code> containing the output from your job. This file will be placed in the same directory that you submitted your job from. <code>JOBID</code> is the id of the job, which is returned when you submitted the job (or found from <code>squeue -u USERNAME</code>. 

The following example submits a job to the default batch partition:

<div>
```bash
$ sbatch jobXsubmit.sh
```
</div>

## Interactive

If you would like to allocate resources on the cluster and then have the flexibility of using those resources in an interactive manner, you can use the command **<code>salloc</code>** to allow interactive use of resources allocated to your job. This can be useful for debugging, in addition to debugging tools like DDT (which uses normal batch jobs and not interactive allocations).

First, you make a request for resources with <code>salloc</code>, like in this example:

<div>
```bash
$ salloc -A hpc2nXXXX-YYY -n 4 --time=1:30:00 
```
</div>

The example above will allocate resources for up to 4 simultaneous tasks for 1 hour and 30 minutes. You need to give your project id as well (change hpc2nXXXX-YYY to your own project id).

Your request enters the job queue just like any other job, and <code>salloc</code> will tell you that it is waiting for the requested resources. When <code>salloc</code> tells you that your job has been allocated resources, you can interactively run programs on those resources with <code>srun</code> for as long as the time you asked for. The commands you run with <code>srun</code> will then be executed on the resources your job has been allocated.

!!! NOTE 

    After <code>salloc</code> tells you that your job resources have been granted, you are still using a shell on the login node. You must submit <u>all</u> commands with <code>srun</code> to have them run on your job's allocated resources. Commands run <u>without</u> srun will be executed on the login node. 

This is demonstrated in the examples below.

!!! Example 1 "1 node, resources for 4 parallel tasks, on a Kebnekaise compute node"
    Here we run without prefacing with <code>srun</code> and as you can see we run on the login node: 

    ```bash
    b-an01 [~]$ salloc -n 4 --time=1:00:00 -A hpc2nXXXX-YYY
    salloc: Pending job allocation 10248860
    salloc: job 10248860 queued and waiting for resources
    salloc: job 10248860 has been allocated resources
    salloc: Granted job allocation 10248860
    b-an01 [~]$  echo $SLURM_NODELIST
    b-cn0206
    b-an01 [~]$ srun hostname
    b-cn0206.hpc2n.umu.se
    b-cn0206.hpc2n.umu.se
    b-cn0206.hpc2n.umu.se
    b-cn0206.hpc2n.umu.se
    b-an01 [~]$ hostname
    b-an01.hpc2n.umu.se
    ```

!!! Example 2 "2 nodes, resources for 4 parallel tasks, on Kebnekaise"

    Here we run with <code>srun</code> and that means we run on the allocated compute node: 

    ```bash
    b-an01 [~]$ salloc -N 2 -n 4 --time=00:10:00 hpc2nXXXX-YYY
    salloc: Pending job allocation 10248865
    salloc: job 10248865 queued and waiting for resources
    salloc: job 10248865 has been allocated resources
    salloc: Granted job allocation 10248865
    b-an01 [~]$ echo $SLURM_NODELIST
    b-cn[0205,0105]
    b-an01 [~]$ srun hostname
    b-cn0205.hpc2n.umu.se
    b-cn0205.hpc2n.umu.se
    b-cn0205.hpc2n.umu.se
    b-cn0105.hpc2n.umu.se
    b-an01 [~]$ 
    ```

    Slurm determined where to allocate resources for the 4 tasks on the 2 nodes. In this case, three tasks were run on b-cn0205, and one on b-cn0105. If needed, you can control how many tasks you want to run on each node with <code>\--ntask-per-node=NUMBER</code>.

!!! Note 

    Another type of interactive runs is to run through Jupyter. You can read more about that in the [Jupyter on Kebnekaise](../../tutorials/jupyter) tutorial. 
