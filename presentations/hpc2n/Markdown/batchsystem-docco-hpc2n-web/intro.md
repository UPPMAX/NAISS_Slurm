# Batch System introduction

Batch systems keeps track of available system resources and takes care of scheduling jobs of multiple users running their tasks simultaneously. It typically organizes submitted jobs into some sort of prioritized queue. The batch system is also used to enforce local system resource usage and job scheduling policies.

HPC2N currently has one cluster which accepts local batch jobs, Kebnekaise. It is running <a href="http://slurm.schedmd.com/" target="_blank">Slurm</a>. It is an Open Source job scheduler, which provides three key functions.

- First, it allocates to users, exclusive or non-exclusive access to resources for some period of time.
- Second, it provides a framework for starting, executing, and monitoring work on a set of allocated nodes (the cluster).
- Third, it manages a queue of pending jobs, in order to distribute work across resources according to policies. 

Slurm is designed to handle thousands of nodes in a single cluster, and can sustain throughput of 120,000 jobs per hour.

You can find more general information about what a cluster and a batch system is in the tutorial ["Beginners's intro to clusters"](../../tutorials/clusterguide/). 

