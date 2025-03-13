# Job arrays - Slurm 

Job arrays in Slurm lets you run many jobs with the same job script. If you have many data files that you would normally have processed in multiple jobs, job arrays could be an alternative way to instead generate many job scripts for each run and submit it one by one. 

!!! Example

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -j my_array_job
    #SBATCH -n 1
    #SBATCH -t 01:00:00
    # Submit a job array with index values between 1 and 10 
    #SBATCH --array=1-10

    ./myapplication $SLURM_ARRAY_TASK_ID
    ```

Job arrays are only supported for batch jobs and the array index values are specified using the <code>\--array</code> or <code>-a</code> option of the <code>sbatch</code> command. The option argument can be specific array index values, a range of index values, and an optional step size (see next examples). 

!!! Note
  
    The minimum index value is zero and the maximum value is a Slurm configuration parameter (<code>MaxArraySize</code> minus one). Jobs which are part of a job array will have the environment variable <code>SLURM_ARRAY_TASK_ID</code> set to its array index value.

!!! Example 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -j my_array_job
    #SBATCH -n 1
    #SBATCH -t 01:00:00
    # Submit a job array with index values of 1, 3, 5 and 7
    #SBATCH --array=1,3,5,7 

    ./myapplication $SLURM_ARRAY_TASK_ID 
    ```

!!! Example 

    ```bash 
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -j my_array_job
    #SBATCH -n 1
    #SBATCH -t 01:00:00
    # Submit a job array with index values between 1 and 7
    # with a step size of 2 (i.e. 1, 3, 5 and 7)
    #SBATCH --array=1-7:2  

    ./myapplication $SLURM_ARRAY_TASK_ID 
    ```

