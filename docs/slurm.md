# Introduction to Slurm 

The batch system used at UPPMAX, HPC2N, LUNARC, NSC, PDC, C3SE (and most other HPC centres in Sweden) is called Slurm. 

!!! note "Guides and documentation" 

    - HPC2N: https://docs.hpc2n.umu.se/documentation/batchsystem/intro/ 
    - UPPMAX: https://docs.uppmax.uu.se/cluster_guides/slurm/ 
    - LUNARC: https://lunarc-documentation.readthedocs.io/en/latest/manual/manual_intro/ 
    - NSC: https://www.nsc.liu.se/support/batch-jobs/introduction/ 
    - PDC: https://support.pdc.kth.se/doc/run_jobs/job_scheduling/
    - C3SE: https://www.c3se.chalmers.se/documentation/submitting_jobs/ 

Slurm is an Open Source job scheduler, which provides three key functions

- Keeps track of available system resources
- Enforces local system resource usage and job scheduling policies
- Manages a job queue, distributing work across resources according to policies

In order to run a batch job, you need to create and submit a SLURM submit file (also called a batch submit file, a batch script, or a job script). 



