# Slurm commands and information

There are many more commands than the ones we have chosen to look at here, but these are the most commonly used ones. You can find more information on the Slurm homepage: <a href="https://slurm.schedmd.com/documentation.html" target="_blank">Slurm documentation</a>.

You can run programs either by giving all the commands on the command line or by submitting a job script. 

Using a job script is often recommended: 

- If you ask for the resources on the command line, you will wait for the program to run before you can use the window again (unless you can send it to the background with &).
- If you use a job script you have an easy record of the commands you used, to reuse or edit for later use. 

[Go here for description of writing a submit file](./submit_file_design.md).

## salloc - requesting an interactive allocation

Using <code>salloc</code>, you get an interactive shell to run your jobs in, when your resources have been allocated. Note that you cannot use the window while you wait for - perhaps - a long time before the allocation starts.

This example asks to allocate 1 node with 4 processors for 1 hour and 30 minutes. When the resources are available, you will get an interactive shell with those resources available for use.

```bash
$ salloc -A <your project> -N 1 -n 4 --time=1:30:00 
```

Note that you will still be on the login node when the prompt returns and you MUST use <code>srun</code> to run your job on the allocated resources.

```bash
$ srun -n 2 my_program
```

Serial, OpenMP, MPI, hybrid jobs, GPU jobs - all can be submitted either using an interactive shell started with salloc, or through a job submission file.

## sbatch - submitting jobs to the batch system

Submitting a job script avoids having to wait for the job to start before being able to continue working. While it still may take a long time before the job runs (depending on load on the machine and your project's priority), you can use the window in the meantime and you do not have to sit and be ready to use it when the job start. Remember, if you do it as an interactive job, your allocated run time starts when the job starts. 

The commands <code>sbatch</code> and <code>srun</code> can be used to allocate and then start multiple tasks on multiple nodes, where each task is a separate process executing the same program. By default, Slurm allocates one processor per task, but starts tasks on multiple processors as necessary. You can, however, specify these yourself, and does not have to follow the default.

The command <code>sbatch JOBSCRIPT</code> submits your submit file JOBSCRIPT to the batch system and returns directly with the jobid of the job.

More information about parameters and job submission files can be found in the section: [Slurm submit file design](./submit_file_design.md).

 
## squeue - viewing the state of the batch queue

To view the queue one can use the <code>squeue</code> command. The most useful options are:

- <code>--me</code> to look at your own jobs
- <code>-t pd</code> to look at pending jobs, i.e. not yet started ones
- <code>-t r</code> to look at running jobs

these can be combined like <code>--me -t r</code> to look at your running jobs.


## job-usage - get url to see details of your job (not a Slurm command)

We have a command <code>job-usage</code> that will produce an URL to a page with detailed runtime information of a running job.

```bash
job-usage <jobid>
```

The web page will show things like CPU (and GPU when appropriate), memory, and disk-io usage for the duration of the job.

## scancel - cancel a job

To cancel a job, either pending or already running, one uses
<code>scancel</code>. One can cancel either a specific job, all the
users jobs or jobs with a specific name. To see all the possibilities
check out the man page, <code>man scancel</code>.

Usage is simply:
<code>scancel jobid</code>
