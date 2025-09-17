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

## Login info, project number, project storage

### Project number and storage 

=== NSC (Tetralith) 

=== PDC (Dardel)

=== C3SE (Alvis)

=== HPC2N (Kebnekaise)

=== LUNARC (Cosmos)

=== UPPMAX (Rackham or Pelle) 

### Login info 

- You will not need a graphical user interface for this course.
- Even so, if you do not have a favourite SSH client, we recomment using <a href="https://www.cendio.com/thinlinc/download/" target="_blank">ThinLinc</a>

!!! note "Connection info" 

    - Login to the system you are using (Tetralith/Dardel, other Swedish HPC system)
    - Connection info for some Swedish HPC systems - use the one you have access to: 

    === "NSC"

        - SSH: ``ssh <user>@tetralith.nsc.liu.se``
        - ThinLinc:
            - Server: ``tetralith.nsc.liu.se``
            - Username: ``<your-nsc-username>``
            - Password: ``<your-nsc-password>``
        - Note that you need to setup <a href="https://www.nsc.liu.se/support/2fa/" target="_blank">TFA</a> to use NSC!

    === "HPC2N"

        - SSH: ``ssh <user>@kebnekaise.hpc2n.umu.se``
        - ThinLinc:
            - Server: ``kebnekaise-tl.hpc2n.umu.se``
            - Username: ``<your-hpc2n-username>``
            - Password: ``<yout-hpc2n-password>``
        - ThinLinc Webaccess:
            - Put ``https://kebnekaise-tl.hpc2n.umu.se:300/`` in browser address bar
            - Put ``<your-hpc2n-username>`` and ``<your-hpc2n-password>`` in th e login box that opens and click ``Login``
        Open OnDemand: ``https://portal.hpc2n.umu.se`` 

    === "UPPMAX"

        - SSH: ``ssh <user>@rackham.uppmax.uu.se``
        - ThinLinc:
            - Server: ``rackham-gui.uppmax.uu.se``
            - Username: ``<your-uppmax-username>``
            - Password: ``<your-uppmax-password>``
        - ThinLinc Webaccess:
            - Put ``https://rackham-gui.uppmax.uu.se`` in browser address bar
            - Put ``<your-uppmax-username>`` and ``<your-uppmax-password>`` in the login box that opens and click ``Login``
        - Note that you may have to setup <a href="https://docs.uppmax.uu.se/getting_started/get_uppmax_2fa/" target="_blank">TFA for Uppmax</a> when using either of the ThinLinc connections.

    === "LUNARC"

        - SSH: ``ssh <user>@cosmos.lunarc.lu.se``
        - ThinLinc:
            - Server: ``cosmos-dt.lunarc.lu.se``
            - Username: ``<your-lunarc-username>``
            - Password: ``<your-lunarc-password>``
        - Note that you need to setup <a href="https://lunarc-documentation.readthedocs.io/en/latest/getting_started/login_howto/" target="_blank">TFA (PocketPass)</a> to use LUNARC!

    === "PDC"

        - SSH: ``ssh <user>@dardel.pdc.kth.se``
        - ThinLinc:
            - Server: ``dardel-vnc.pdc.kth.se``
            - Username: ``<your-pdc-username>``
            - Password: ``<your-pdc-password>``
        - Note that you need to setup <a href="https://support.pdc.kth.se/doc/login/ssh_login/" target="_blank">SSH keys</a> or kerberos in order to login to PDC!

    === "C3SE"

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

## Schedule

TBA
