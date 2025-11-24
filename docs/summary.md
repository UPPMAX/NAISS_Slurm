# Summary

Today we have discussed:

- Basic architecture of a typical HPC cluster
    - Nodes as building blocks
    - Login nodes - don't do heavy lifting here
    - Compute node
    - GPU nodes

- Job scheduler concepts
    - You interact with the scheduler on the front end
    - The scheduler moves your "run" to the compute nodes
    - Waiting queue

- Job script
    - Description and requirements of your job
    - Request resources, e.g.: 
        - Job time
        - Number of nodes/cores
        - Amount of memory
        - Number of GPUs
    - Includes UNIX script to describe your job to the system
        - Program(s) to execute
        - Location of input data
        - Where to put the output data 
        - Disks to be utilised
        - You can be creative here ;)
