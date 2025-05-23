# Introduction to Slurm 

The batch system used at UPPMAX, HPC2N, LUNARC, NSC, PDC, C3SE (and most other HPC centres in Sweden) is called Slurm. 

!!! note "Guides and documentation" 

    - HPC2N: <a href="https://docs.hpc2n.umu.se/documentation/batchsystem/intro/" target="_blank">https://docs.hpc2n.umu.se/documentation/batchsystem/intro/</a>
    - UPPMAX: <a href="https://docs.uppmax.uu.se/cluster_guides/slurm/" target="_blank">https://docs.uppmax.uu.se/cluster_guides/slurm/</a>
    - LUNARC: <a href="https://lunarc-documentation.readthedocs.io/en/latest/manual/manual_intro/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/manual/manual_intro/</a> 
    - NSC: <a href="https://www.nsc.liu.se/support/batch-jobs/introduction/" target="_blank">https://www.nsc.liu.se/support/batch-jobs/introduction/</a>
    - PDC: <a href="https://support.pdc.kth.se/doc/run_jobs/job_scheduling/" target="_blank">https://support.pdc.kth.se/doc/run_jobs/job_scheduling/</a>
    - C3SE: <a href="https://www.c3se.chalmers.se/documentation/submitting_jobs/" target="_blank">https://www.c3se.chalmers.se/documentation/submitting_jobs/</a> 

Slurm is an Open Source job scheduler, which provides three key functions

- Keeps track of available system resources - it allocates to users, exclusive or non-exclusive access to resources for some period of time
- Enforces local system resource usage and job scheduling policies - provides a framework for starting, executing, and monitoring work  
- Manages a job queue, distributing work across resources according to policies

Slurm is designed to handle thousands of nodes in a single cluster, and can sustain throughput of 120,000 jobs per hour.

You can run programs either by giving all the commands on the command line or by submitting a job script. 

Using a job script is often recommended:

- If you ask for the resources on the command line, you will wait for the program to run before you can use the window again (unless you can send it to the background with &).
- If you use a job script you have an easy record of the commands you used, to reuse or edit for later use.

In order to run a batch job, you need to create and submit a SLURM submit file (also called a batch submit file, a batch script, or a job script). 

## Slurm commands 

There are many more commands than the ones we have chosen to look at here, but these are the most commonly used ones. You can find more information on the Slurm homepage: <a href="https://slurm.schedmd.com/documentation.html" target="_blank">Slurm documentation</a>. 

- **salloc**: requesting an interactive allocation
- **interactive**: another way of requesting an interactive allocation 
- **sbatch**: submitting jobs to the batch system
- **squeue**: viewing the state of the batch queue
- **scancel**: cancel a job
- **scontrol show**: getting more info on jobs, nodes 
- **sinfo**: information about the partitions/queues  

Let us look at these one at a time. 

### salloc and interactive 

This is for requesting an interactive allocation. This is done differently depending on the centre. 

| Cluster | interactive | salloc | srun | GfxLauncher or OpenOnDemand | 
| ------- | ----------- | ------ | ---- | --------------------------- | 
| HPC2N   | Works       | Recommended | N/A | Recommended (OOD)      | 
| UPPMAX  | Recommended | Works | N/A | N/A | 
| LUNARC | Works | N/A | N/A | Recommended (GfxLauncher) | 
| NSC | Recommended | N/A | N/A | N/A |  
| PDC | N/A | Recommended | N/A | Possible | 
| C3SE | N/A | N/A | Works | Recommended (OOD) 

#### Examples 

!!! note "interactive" 

    This is recommended at UPPMAX and NSC, and works at HPC2N and LUNARC.

    Usage: ``interactive -A [project_name]``

    If you want longer walltime, more CPUs/GPUs, etc. you need to ask for that as well. This is the default which gives 1 CPU for 1 hour. 

    === "UPPMAX"

        ```bash 
        [bbrydsoe@rackham3 ~]$ interactive -A uppmax2025-2-296
        You receive the high interactive priority.
        You may run for at most one hour.
        Your job has been put into the devcore partition and is expected to start at once.
        (Please remember, you may not simultaneously have more than one devel/devcore job, running or queued, in the batch system.)

        Please, use no more than 6.4 GB of RAM.

        salloc: Pending job allocation 55388069
        salloc: job 55388069 queued and waiting for resources
        salloc: job 55388069 has been allocated resources
        salloc: Granted job allocation 55388069
        salloc: Waiting for resource configuration
        salloc: Nodes r483 are ready for job
         _   _ ____  ____  __  __    _    __  __
        | | | |  _ \|  _ \|  \/  |  / \   \ \/ /   | System:    r483
        | | | | |_) | |_) | |\/| | / _ \   \  /    | User:      bbrydsoe
        | |_| |  __/|  __/| |  | |/ ___ \  /  \    | 
         \___/|_|   |_|   |_|  |_/_/   \_\/_/\_\   | 

        ###############################################################################

                User Guides: https://docs.uppmax.uu.se/

                Write to support@uppmax.uu.se, if you have questions or comments.


        [bbrydsoe@r483 ~]$
        ```

    === "NSC" 

!!! note "salloc" 

    This is recommended at HPC2N and PDC, and works at UPPMAX. 

    === "HPC2N" 

    === "PDC" 

!!! note "srun" 

    This works at C3SE.  

    === "C3SE" 

!!! note "GfxLauncher and OpenOnDemand" 

    This is recommended at HPC2N, LUNARC, and C3SE, and is possible at PDC. 

    === "HPC2N"

    === "LUNARC" 

    === "C3SE" 

### sbatch

submitting jobs to the batch system

### squeue

viewing the state of the batch queue

### scancel

cancel a job

### scontrol show

getting more info on jobs, nodes

### sinfo

information about the partitions/queues    

## Slurm job scripts 

## Information about jobs  

sacct
job-info 

