# Interactive jobs

There are more than one way to start an interactive job. It can be done either from the command line or inside ThinLinc (GfxLauncher) or from a portal (OpenOnDemand portal). 

## salloc and interactive

The Slurm commands ``salloc`` and ``interactive`` are for requesting an interactive allocation. This is done differently depending on the centre. Some centres recommend using GfxLauncher or Open OnDemand for interactive jobs. 

| Cluster | interactive | salloc | srun | GfxLauncher or OpenOnDemand |  
| ------- | ----------- | ------ | ---- | --------------------------- |  
| HPC2N   | Works       | Recommended | N/A | Recommended (OOD)      |  
| UPPMAX  | Recommended | Works | N/A | N/A |  
| LUNARC | Works | N/A | N/A | Recommended (GfxLauncher) |  
| NSC | Recommended | N/A | N/A | N/A |  
| PDC | N/A | Recommended | N/A | Possible |  
| C3SE | N/A | N/A | Works | Recommended (OOD) |  

### Examples

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

    Usage: ``salloc -A [project_name] -t HHH:MM:SS``

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

## GfxLauncher and OpenOnDemand

!!! note "GfxLauncher and OpenOnDemand"

    This is the recommended way to do interactive jobs at HPC2N, LUNARC, and C3SE, and is possible at PDC.

    === "HPC2N"

        - Go to <a href="https://portal.hpc2n.umu.se/" target="_blank">https://portal.hpc2n.umu.se/</a> and login.
        - Documentation here: <a href="https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand" target="_blank">https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand</a>

    === "LUNARC"

        - Login with ThinLinc: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/</a>
        - Follow the documentation for starting the GfxLauncher for OpenOnDemand: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/</a>

    === "C3SE"

        - Go to <a href="https://alvis.c3se.chalmers.se/" target="_blank">https://alvis.c3se.chalmers.se/</a>
        - There is some documentation here: <a href="https://uppmax.github.io/HPC-python/common/interactive_ondemand.html#start-an-interactive-session-from-ondemand" target="_blank">https://uppmax.github.io/HPC-python/common/interactive_ondemand.html#start-an-interactive-session-from-ondemand</a>

!!! note

    - At centres that have OpenOnDemand installed, you do not have to submit a batch job, but can run directly on the already allocated resources (see interactive jobs).
        - OpenOnDemand is a good option for interactive tasks, graphical applications/visualization, and simpler job submittions. It can also be more user-friendly.
        - Regardless, there are many situations where submitting a batch job is the best option instead, including when you want to run jobs that need many resources (time, memory, multiple cores, multiple GPUs) or when you run multiple jobs concurrently or in a specified succession, without need for manual intervention. Batch jobs are often also preferred for automation (scripts) and reproducibility. Many types of application software fall into this category.
    - At centres that have ThinLinc you can usually submit MATLAB jobs to compute resources from within MATLAB.

