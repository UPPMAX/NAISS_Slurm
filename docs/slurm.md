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

        ```bash 
        [x_birbr@tetralith3 ~]$ interactive -A naiss2025-22-403
        salloc: Pending job allocation 44252533
        salloc: job 44252533 queued and waiting for resources
        salloc: job 44252533 has been allocated resources
        salloc: Granted job allocation 44252533
        salloc: Waiting for resource configuration
        salloc: Nodes n340 are ready for job
        [x_birbr@n340 ~]$ 
        ```

!!! note "salloc" 

    This is recommended at HPC2N and PDC, and works at UPPMAX. 

    Usage: salloc -A [project_name] -t HHH:MM:SS 

    You have to give project ID and walltime. If you need more CPUs (1 is default) or GPUs, you have to ask for that as well. 

    At PDC, you also have to give the partition: main, shared, gpu 

    === "HPC2N" 

        ```bash 
        b-an01 [~]$ salloc -A hpc2n2025-076 -t 00:10:00 
        salloc: Pending job allocation 34624444
        salloc: job 34624444 queued and waiting for resources
        salloc: job 34624444 has been allocated resources
        salloc: Granted job allocation 34624444
        salloc: Nodes b-cn1403 are ready for job
        b-an01 [~]$ 
        ```
   
        WARNING! This is not true interactivity! Note that we are still on the login node!

        In order to run anything in the allocation, you need to preface with ``srun`` like this: 
 
        ```bash 
        b-an01 [~]$ srun /bin/hostname
        b-cn1403.hpc2n.umu.se
        b-an01 [~]$ 
        ``` 

        Otherwise anything will run on the login node! Also, interactive sessions (for instance a program that asks for input) will not work correctly as that dialogoue happens on the compute node which you do not have real access to! 

    === "PDC" 

        ```bash 
        bbrydsoe@login1:~> salloc --time=00:10:00 -A naiss2025-22-403 -p main
        salloc: Pending job allocation 9722449
        salloc: job 9722449 queued and waiting for resources
        salloc: job 9722449 has been allocated resources
        salloc: Granted job allocation 9722449
        salloc: Waiting for resource configuration
        salloc: Nodes nid001134 are ready for job
        bbrydsoe@login1:~> 
        ``` 

        Again, you are on the login node, and anything you want to run in the allocation must be preface with ``srun``. 

        However, at PDC you have another option; you can ``ssh`` to the allocated compute node and then it will be true interactivity: 

        ```bash 
        bbrydsoe@login1:~> ssh nid001134
        bbrydsoe@nid001134:~
        ``` 

!!! note "srun" 

    This works at C3SE, but is not recommended as when the login node is restarted the interactive job is also terminated.  

    === "C3SE" 

        ```bash
        [brydso@alvis2 ~]$ srun --account=NAISS2025-22-395 --gpus-per-node=T4:1 --time=01:00:00 --pty=/bin/bash
        [brydso@alvis2-12 ~]$
        ```

!!! note "GfxLauncher and OpenOnDemand" 

    This is recommended at HPC2N, LUNARC, and C3SE, and is possible at PDC. 

    === "HPC2N"

        - Go to <a href="https://portal.hpc2n.umu.se/" target="_blank">https://portal.hpc2n.umu.se/</a> and login. 
        - Documentation here: <a href="https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand" target="_blank">https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand</a> 

    === "LUNARC" 

        - Login with ThinLinc: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/</a>
        - Follow the documentation for starting the GfxLauncher for OpenOnDemand: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/</a> 

    === "C3SE" 

        - Go to <ahref="https://alvis.c3se.chalmers.se/" target="_blank">https://alvis.c3se.chalmers.se/</a> 
        - There is some documentation here: <a href="https://uppmax.github.io/HPC-python/common/interactive_ondemand.html#start-an-interactive-session-from-ondemand" target="_blank">https://uppmax.github.io/HPC-python/common/interactive_ondemand.html#start-an-interactive-session-from-ondemand</a> 

### sbatch

The command ``sbatch`` is used to submit jobs to the batch system. 

This is done from the command line in the same way at all the HPC centres in Sweden: 

```bash
sbatch <batchscript.sh>
```

For any <batchscript.sh> named whatever you want to. It is a convention to use the suffix ``.sbatch`` or ``.sh``, but it is not a requirement. You can use any or no suffix. It is merely to make it easier to find the script among the other files. 

!!! note 

    - At centres that have OpenOnDemand installed, you do not have to submit a batch job, but can run directly on the already allocated resources (see interactive jobs). 
    - At centres that have ThinLinc you can usually submit MATLAB jobs to compute resources from within MATLAB. 

### squeue

The command ``squeue`` is for viewing the state of the batch queue. 

If you just give the command, you will get a long list of all jobs in the queue, so it is usually best to constrain it to your own jobs. This can be done in two ways: 

- ``squeue -u <username>``
- ``squeue --me`` 

**Example**: 

```bash
b-an01 [~]$ squeue --me
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          34815904   cpu_sky mpi_gree bbrydsoe  R       0:00      1 b-cn1404
          34815905   cpu_sky mpi_hell bbrydsoe  R       0:00      2 b-cn[1404,1511]
          34815906   cpu_sky mpi_hi.s bbrydsoe  R       0:00      2 b-cn[1511-1512]
          34815907   cpu_sky simple.s bbrydsoe  R       0:00      1 b-cn1512
          34815908   cpu_sky compiler bbrydsoe  R       0:00      2 b-cn[1415,1512]
          34815909   cpu_sky mpi_gree bbrydsoe  R       0:00      1 b-cn1415
          34815910   cpu_sky mpi_hell bbrydsoe  R       0:00      3 b-cn[1415,1421-1422]
          34815911   cpu_sky mpi_hi.s bbrydsoe  R       0:00      1 b-cn1422
          34815912   cpu_sky simple.s bbrydsoe  R       0:00      1 b-cn1422
          34815913   cpu_sky compiler bbrydsoe  R       0:00      2 b-cn[1422,1427]
          34815902  cpu_zen4 simple.s bbrydsoe CG       0:03      1 b-cn1707
          34815903  cpu_zen4 compiler bbrydsoe  R       0:00      1 b-cn1708
          34815898  cpu_zen4 compiler bbrydsoe  R       0:03      2 b-cn[1703,1705]
          34815899  cpu_zen4 mpi_gree bbrydsoe  R       0:03      2 b-cn[1705,1707]
          34815900  cpu_zen4 mpi_hell bbrydsoe  R       0:03      1 b-cn1707
          34815901  cpu_zen4 mpi_hi.s bbrydsoe  R       0:03      1 b-cn1707
          34815922 cpu_zen4, simple.s bbrydsoe PD       0:00      1 (Priority)
          34815921 cpu_zen4, mpi_hi.s bbrydsoe PD       0:00      1 (Priority)
          34815920 cpu_zen4, mpi_hell bbrydsoe PD       0:00      1 (Priority)
          34815919 cpu_zen4, mpi_gree bbrydsoe PD       0:00      1 (Priority)
          34815918 cpu_zen4, compiler bbrydsoe PD       0:00      1 (Priority)
          34815917 cpu_zen4, simple.s bbrydsoe PD       0:00      1 (Priority)
          34815916 cpu_zen4, mpi_hi.s bbrydsoe PD       0:00      1 (Priority)
          34815915 cpu_zen4, mpi_hell bbrydsoe PD       0:00      1 (Priority)
          34815914 cpu_zen4, mpi_gree bbrydsoe PD       0:00      1 (Resources)
```

Here you also see some of the "states" a job can be in. Some of the more common ones are: 

- **CA**: CANCELLED. Job was explicitly cancelled by the user or system administrator. 
- **CF**: CONFIGURING. Job has been allocated resources, but are waiting for them to become ready for use (e.g. booting). 
- **CG**: COMPLETING. Job is in the process of completing. Some processes on some nodes may still be active. 
- **PD**: PENDING. Job is awaiting resource allocation. 
- **R**: RUNNING. Job currently has an allocation. 
- **S**: SUSPENDED. Job has an allocation, but execution has been suspended and resources have been released for other jobs. 

(List above from <a href="https://slurm.schedmd.com/squeue.html" target="_blank">Slurm workload manager page about squeue</a>. 

### scancel

The command to cancel a job is ``scancel``. 

You can either cancel a specific job:

``scancel <job id>``

or cancel all your jobs: 

``scancel -u <username>``

!!! note 

    As before, you get the ``<job id>`` either from when you submitted the job or from ``squeue --me``. 

!!! warning "Note"

    You cannot cancel other people's jobs! 

### scontrol show

The command ``scontrol show`` is used for getting more info on jobs and nodes. 

#### scontrol show job

As usual, you get the ``<job id>`` from either when you submit the job or from ``squeue --me``. 

The command is: 

```bash
scontrol show job <job id>
```

**Example**: 

```bash 
b-an01 [~]$ scontrol show job 34815931
JobId=34815931 JobName=compiler-run
   UserId=bbrydsoe(2897) GroupId=folk(3001) MCS_label=N/A
   Priority=2748684 Nice=0 Account=staff QOS=normal
   JobState=COMPLETED Reason=None Dependency=(null)
   Requeue=0 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
   RunTime=00:00:07 TimeLimit=00:10:00 TimeMin=N/A
   SubmitTime=2025-06-24T11:36:32 EligibleTime=2025-06-24T11:36:32
   AccrueTime=2025-06-24T11:36:32
   StartTime=2025-06-24T11:36:32 EndTime=2025-06-24T11:36:39 Deadline=N/A
   SuspendTime=None SecsPreSuspend=0 LastSchedEval=2025-06-24T11:36:32 Scheduler=Main
   Partition=cpu_zen4 AllocNode:Sid=b-an01:626814
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=b-cn[1703,1705]
   BatchHost=b-cn1703
   NumNodes=2 NumCPUs=12 NumTasks=12 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   ReqTRES=cpu=12,mem=30192M,node=1,billing=12
   AllocTRES=cpu=12,mem=30192M,node=2,billing=12
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryCPU=2516M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:02:00
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/compile-run.sh
   WorkDir=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage
   StdErr=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out
   StdIn=/dev/null
   StdOut=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out
   Power=
``` 

Here you get much interesting information: 

- **JobState=COMPLETED**: the job was completed and was not FAILED. It could also have been PENDING or COMPLETING 
- **RunTime=00:00:07**: the job ran for 7 seconds
- **TimeLimit=00:10:00**: It could have run for up to 10 min (what you asked for)
- **SubmitTime=2025-06-24T11:36:32**: when your job was submitted
- **StartTime=2025-06-24T11:36:32**: when the job started
- **Partition=cpu_zen4**: what partition/type of node it ran on
- **NodeList=b-cn[1703,1705]**: which specific nodes it ran on
- **BatchHost=b-cn1703**: which of the nodes (if several) that was the master 
- **NumNodes=2 NumCPUs=12 NumTasks=12 CPUs/Task=1**: number of nodes, cpus, tasks 
- **WorkDir=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage**: which directory your job was submitted from/was running in 
- **StdOut=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out**: which directory the output files will be placed in 

The command ``scontrol show job <job id>`` can be run also while the job is pending, and can be used to get an estimate of when the job will start. Actual start time depends on the jobs priority, any other (people's) jobs starting and completing and being submitted, etc. 

It is often useful to know which nodes a job ran on if something did not work - perhaps the node was faulty. 

#### scontrol show node

This command is used to get information about a specific node. You can for instance see its features, how many cores per socket, uptime, etc. Specifics will vary and depend on the centre you are running jobs at. 

**Example**: 

This if for one of the AMD Zen4 nodes at Kebnekaise, HPC2N. 

```bash
b-an01 [~]$ scontrol show node b-cn1703
NodeName=b-cn1703 Arch=x86_64 CoresPerSocket=128 
   CPUAlloc=253 CPUEfctv=256 CPUTot=256 CPULoad=253.38
   AvailableFeatures=rack17,amd_cpu,zen4
   ActiveFeatures=rack17,amd_cpu,zen4
   Gres=(null)
   NodeAddr=b-cn1703 NodeHostName=b-cn1703 Version=23.02.7
   OS=Linux 5.15.0-142-generic #152-Ubuntu SMP Mon May 19 10:54:31 UTC 2025 
   RealMemory=644096 AllocMem=636548 FreeMem=749623 Sockets=2 Boards=1
   State=MIXED ThreadsPerCore=1 TmpDisk=0 Weight=100 Owner=N/A MCS_label=N/A
   Partitions=cpu_zen4 
   BootTime=2025-06-24T06:32:25 SlurmdStartTime=2025-06-24T06:37:02
   LastBusyTime=2025-06-24T08:29:45 ResumeAfterTime=None
   CfgTRES=cpu=256,mem=629G,billing=256
   AllocTRES=cpu=253,mem=636548M
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
```

### sinfo

The command ``sinfo`` gives you information about the partitions/queues. 

## Slurm job scripts 

## Information about jobs  

sacct
job-info 

