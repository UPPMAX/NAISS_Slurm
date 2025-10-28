# Introduction to "Running jobs on HPC systems"

- Welcome page and syllabus: <a href="https://uppmax.github.io/NAISS_Slurm/index.html">https://uppmax.github.io/NAISS_Slurm/index.html</a>
    - Link also in the House symbol at the top of the page.

!!! note "Learning outcomes"

    - Cluster architecture
        - Login/compute nodes
        - cores, nodes, GPUs
        - memory
        - local disk?
    - sbatch with options for CPU job scripts
    - sample job scripts
        - I/O intensive jobs
        - OpenMP and MPI jobs
        - job arrays
        - simple example for task farming
    - increasing the memory per task / memory hungry jobs
    - Running on GPUs
    - job monitoring, job efficiency
    - how to find optimal sbatch options

## Login info, project number, project directory

### Project number and project directory

!!! warning 

    This part is only relevant for people attending the course. It should be ignored if you are doing it as self-study later. 

=== "Tetralith" 
   
    **Tetralith at NSC**

    - Project ID: ``naiss2025-22-934``
    - Project storage: ``/proj/courses-fall-2025/users``    

=== "Dardel"

    **Dardel at PDC**

    - Project ID: ``naiss2025-22-934``
    - Project storage: ``/cfs/klemming/projects/supr/courses-fall-2025``

=== "Alvis"

    **Alvis at C3SE**

    - Project ID: ``naiss2025-22-934``
    - Project storage: ``/mimer/NOBACKUP/groups/courses-fall-2025`` 

=== "Kebnekaise" 

    **Kebnekaise at HPC2N**

    - Project ID: ``hpc2n2025-151``
    - Project storage: ``/proj/nobackup/fall-courses``

=== "Cosmos" 

    **Cosmos at LUNARC**

    - Project ID: 

=== "Pelle" 

    **Pelle at UPPMAX**

    - Project ID: 
    - Project storage:  

### Login info 

- You will not need a graphical user interface for this course.
- Even so, if you do not have a preferred SSH client, we recomment using <a href="https://www.cendio.com/thinlinc/download/" target="_blank">ThinLinc</a>

!!! important "Connection info" 

    - Login to the system you are using (Tetralith/Dardel, other Swedish HPC system)
    - Connection info for some Swedish HPC systems - use the one you have access to: 

    === "Tetralith"

        - SSH: ``ssh <user>@tetralith.nsc.liu.se``
        - ThinLinc:
            - Server: ``tetralith.nsc.liu.se``
            - Username: ``<your-nsc-username>``
            - Password: ``<your-nsc-password>``
        - Note that you need to setup <a href="https://www.nsc.liu.se/support/2fa/" target="_blank">TFA</a> to use NSC!

    === "Dardel"

        - SSH: ``ssh <user>@dardel.pdc.kth.se``
        - ThinLinc:
            - Server: ``dardel-vnc.pdc.kth.se``
            - Username: ``<your-pdc-username>``
            - Password: ``<your-pdc-password>``
        - Note that you need to setup <a href="https://support.pdc.kth.se/doc/login/ssh_login/" target="_blank">SSH keys</a> or kerberos in order to login to PDC!

    === "Alvis"

        - SSH: ``ssh <user>@alvis1.c3se.chalmers.se``
               or
               ``ssh <user>@alvis2.c3se.chalmers.se``
        - ThinLinc:
            - Server: ``alvis1.c3se.chalmers.se``
                      or
                      ``alvis2.c3se.chalmers.se``
            - Username: ``<your-c3se-username>``
            - Password: ``<your-c3se-username>``
        - OpenOndemand portal:
            - Put ``https://alvis.c3se.chalmers.se`` in browser address bar
            - Put ``<your-c3se-username>`` and ``<your-c3se-password>`` in the login box
        - Note that Alvis is accessible via SUNET networks (i.e. most Swedish university networks). If you are not on one of those networks you need to use a VPN - preferrably your own Swedish university VPN. If this is not possible, contact ``support@chalmers.se`` and ask to be added to the Chalmers's eduVPN.

    === "Kebnekaise"

        - SSH: ``ssh <user>@kebnekaise.hpc2n.umu.se``
        - ThinLinc:
            - Server: ``kebnekaise-tl.hpc2n.umu.se``
            - Username: ``<your-hpc2n-username>``
            - Password: ``<yout-hpc2n-password>``
        - ThinLinc Webaccess:
            - Put ``https://kebnekaise-tl.hpc2n.umu.se:300/`` in browser address bar
            - Put ``<your-hpc2n-username>`` and ``<your-hpc2n-password>`` in th e login box that opens and click ``Login``
        - Open OnDemand: ``https://portal.hpc2n.umu.se`` 

    === "Pelle"

        - SSH: ``ssh <user>@rackham.uppmax.uu.se``
        - ThinLinc:
            - Server: ``rackham-gui.uppmax.uu.se``
            - Username: ``<your-uppmax-username>``
            - Password: ``<your-uppmax-password>``
        - ThinLinc Webaccess:
            - Put ``https://rackham-gui.uppmax.uu.se`` in browser address bar
            - Put ``<your-uppmax-username>`` and ``<your-uppmax-password>`` in the login box that opens and click ``Login``
        - Note that you may have to setup <a href="https://docs.uppmax.uu.se/getting_started/get_uppmax_2fa/" target="_blank">TFA for Uppmax</a> when using either of the ThinLinc connections.

    === "Cosmos"

        - SSH: ``ssh <user>@cosmos.lunarc.lu.se``
        - ThinLinc:
            - Server: ``cosmos-dt.lunarc.lu.se``
            - Username: ``<your-lunarc-username>``
            - Password: ``<your-lunarc-password>``
        - Note that you need to setup <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/login_howto/" target="_blank">TFA (PocketPass)</a> to use LUNARC's systems!

## Schedule

| Time | Topic | Activity | Teacher | 
| ---- | ----- | -------- | ------- |
| 9:00 - 9:05 | Intro to course | Lecture | |
| 9:05 - 9.25 | Intro to clusters | Lecture | | 
| 9:25 - 9:40 | Batch system concepts / job scheduling | Lecture | | 
| 9:40 - | Parallelism | Lecture+type along | | 
| | Intro to Slurm (sbatch, squeue, scontrol, …) | Lecture+type along | |
| | BREAK | | |
| | Additional sample scripts, including job arrays, task farms??? | | |
| | Job monitoring and efficiency | | |
| | Summary | | |
