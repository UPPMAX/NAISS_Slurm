# Interactive jobs

There are more than one way to start an interactive job. It can be done either from the command line or inside ThinLinc (GfxLauncher) or from a portal (OpenOnDemand portal). 

## salloc and interactive

The Slurm commands ``salloc`` and ``interactive`` are for requesting an interactive allocation. This is done differently depending on the centre. Some centres recommend using GfxLauncher or Open OnDemand for interactive jobs. 

| Cluster | interactive | salloc | srun | GfxLauncher or OpenOnDemand |  
| ------- | ----------- | ------ | ---- | --------------------------- |  
| Tetralith (NSC) | Recommended | N/A | N/A | N/A |  
| Dardel (PDC) | N/A | Recommended | N/A | Possible (GfxLauncher) |  
| Alvis (C3SE) | N/A | N/A | Works | Recommended (OOD) |  
| Kebnekaise (HPC2N) | N/A | Recommended | N/A | Recommended (OOD)      |  
| Pelle (UPPMAX)  | Recommended | Works | N/A | N/A |  
| Cosmos (LUNARC) | Works | N/A | N/A | Recommended (GfxLauncher) |  

### Examples

=== "Tetralith"

    **The command "interactive" is recommended at NSC.** 

    Usage: ``interactive -A [project_name] -t HHH:MM:SS``

    If you need more CPUs/GPUs, etc. you need to ask for that as well. The default which gives 1 CPU.

    ```bash
    [x_birbr@tetralith3 ~]$ interactive -A naiss2026-4-66
    salloc: Pending job allocation 44252533
    salloc: job 44252533 queued and waiting for resources
    salloc: job 44252533 has been allocated resources
    salloc: Granted job allocation 44252533
    salloc: Waiting for resource configuration
    salloc: Nodes n340 are ready for job
    [x_birbr@n340 ~]$ 
    ```

=== "Dardel"

    **The command `salloc` (or OpenOnDemand through Gfx launcher) is recommended at PDC.**

    ```bash
    bbrydsoe@login1:~> salloc --time=00:10:00 -A naiss2026-4-66 -p main
    salloc: Pending job allocation 9722449
    salloc: job 9722449 queued and waiting for resources
    salloc: job 9722449 has been allocated resources
    salloc: Granted job allocation 9722449
    salloc: Waiting for resource configuration
    salloc: Nodes nid001134 are ready for job
    bbrydsoe@login1:~>
    ```

    Again, you are on the login node, and anything you want to run in the allocation must be preface with ``srun``.

    However, you have another option; you can ``ssh`` to the allocated compute node and then it will be true interactivity:

    ```bash
    bbrydsoe@login1:~> ssh nid001134
    bbrydsoe@nid001134:~
    ```    

    **It is also possible to use OpenOnDemand through Gfx launcher.**

    To do this, login with ThinLinc and start the Gfxlauncher application. There is some documentation here: <a href="https://support.pdc.kth.se/doc/login/interactive_hpc/" target="_blank">Interactive HPC at PDC</a>.

    Please be aware that the number of ThinLinc licenses are limited. 

=== "Alvis" 

    **The command "srun" from command line works at C3Se**. It is not recommended as when the login node is restarted the interactive job is also terminated.

    ```bash
    [brydso@alvis2 ~]$ srun --account=naiss2026-4-66 --gpus-per-node=T4:1 --time=01:00:00 --pty=/bin/bash
    [brydso@alvis2-12 ~]$
    ```

    **The recommended way to do interactive jobs at Alvis is with OpenOnDemand.**

    You access the Open OnDemand service through <a href="https://alvis.c3se.chalmers.se" target="_blank">https://alvis.c3se.chalmers.se</a>.

    NOTE that you need to connect from a network on SUNET.

    More information about C3SE's Open OnDemand service can be found here: <a href="https://www.c3se.chalmers.se/documentation/connecting/ondemand/" target="_blank">https://www.c3se.chalmers.se/documentation/connecting/ondemand/</a>. 

=== "Kebnekaise"

    **The command `salloc` (or OpenOnDemand) is recommended at HPC2N.**

    Usage: ``salloc -A [project_name] -t HHH:MM:SS``

    You have to give project ID and walltime. If you need more CPUs (1 is default) or GPUs, you have to ask for that as well.

    ```bash
    b-an01 [~]$ salloc -A hpc2n2025-151 -t 00:10:00
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


    **OpenOnDemand**

    This is the recommended way to do interactive jobs at HPC2N. 

    - Go to <a href="https://portal.hpc2n.umu.se/" target="_blank">https://portal.hpc2n.umu.se/</a> and login.
    - Documentation here: <a href="https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand" target="_blank">https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand</a>

=== "Pelle"

    **At UPPMAX, "interactive" is recommended.**

    Usage: ``interactive -A [project_name] -t HHH:MM:SS``

    If you need more CPUs/GPUs, etc. you need to ask for that as well. The default which gives 1 CPU.

    ```bash
    [bbrydsoe@pelle1 ~]$ interactive -A uppmax2025-2-393 -t 00:15:00
    This is a temporary version of interactive-script for Pelle
    Most interactive-script functionality is removed
    salloc: Pending job allocation 205612
    salloc: job 205612 queued and waiting for resources
    salloc: job 205612 has been allocated resources
    salloc: Granted job allocation 205612
    salloc: Waiting for resource configuration
    salloc: Nodes p115 are ready for job
    [bbrydsoe@p115 ~]$ 
    ```

    **salloc also works.** 

    Usage: ``salloc -A [project_name] -t HHH:MM:SS``

    You have to give project ID and walltime. If you need more CPUs (1 is default) or GPUs, you have to ask for that as well.

    ```bash
    [bbrydsoe@pelle1 ~]$ salloc -A uppmax2025-2-393 -t 00:15:00
    salloc: Pending job allocation 205613
    salloc: job 205613 queued and waiting for resources
    salloc: job 205613 has been allocated resources
    salloc: Granted job allocation 205613
    salloc: Nodes p115 are ready for job
    [bbrydsoe@p115 ~]$ 
    ```

=== "Cosmos" 

    **The command `interactive`  works at LUNARC**. It is not the recommended way to do interactive work. 

    Usage: ``interactive -A [project_name] -t HHH:MM:SS``

    If you need more CPUs/GPUs, etc. you need to ask for that as well. The default which gives 1 CPU.

    ```bash
    [bbrydsoe@cosmos2 ~]$ interactive -A lu2025-7-76 -t 00:15:00
    Cluster name: COSMOS
    Waiting for JOBID 1724396 to start
    ```

    After a short wait, you get something like this:

    ```bash
    [bbrydsoe@cn094 ~]$
    ```

    **GfxLauncher**

    This is the recommended wait to work interactively at LUNARC. 

    - Login with ThinLinc: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/</a>
    - Follow the documentation for starting the GfxLauncher for OpenOnDemand: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/</a>

## GfxLauncher and OpenOnDemand

While these are mentioned above, the information is gathered here for ease. 

!!! note "GfxLauncher and OpenOnDemand"

    This is the recommended way to do interactive jobs at HPC2N, LUNARC, and C3SE, and is possible at PDC.

    === "Kebnekaise"

        - Go to <a href="https://portal.hpc2n.umu.se/" target="_blank">https://portal.hpc2n.umu.se/</a> and login.
        - Documentation here: <a href="https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand" target="_blank">https://docs.hpc2n.umu.se/tutorials/connections/#open__ondemand</a>

    === "Cosmos"

        - Login with ThinLinc: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/using_hpc_desktop/</a>
        - Follow the documentation for starting the GfxLauncher for OpenOnDemand: <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/getting_started/gfxlauncher/</a>

    === "Alvis"

        - Go to <a href="https://alvis.c3se.chalmers.se/" target="_blank">https://alvis.c3se.chalmers.se/</a>
        - There is some documentation here: <a href="https://www.c3se.chalmers.se/documentation/connecting/ondemand/" target="_blank">https://www.c3se.chalmers.se/documentation/connecting/ondemand/</a>

    === "Dardel"

        - Login with ThinLinc and follow the documentation for starting the Gfxlauncher for OpenOnDemand: <a href="https://support.pdc.kth.se/doc/login/interactive_hpc/" target="_blank">Interactive HPC at PDC</a>.

        Please be aware that the number of ThinLinc licenses are limited. 

!!! note

    - At centres that have OpenOnDemand installed, you do not have to submit a batch job, but can run directly on the already allocated resources (see interactive jobs).
        - OpenOnDemand is a good option for interactive tasks, graphical applications/visualization, and simpler job submittions. It can also be more user-friendly.
        - Regardless, there are many situations where submitting a batch job is the best option instead, including when you want to run jobs that need many resources (time, memory, multiple cores, multiple GPUs) or when you run multiple jobs concurrently or in a specified succession, without need for manual intervention. Batch jobs are often also preferred for automation (scripts) and reproducibility. Many types of application software fall into this category.
    - At centres that have ThinLinc you can usually submit MATLAB jobs to compute resources from within MATLAB.

