## Basic examples of job submission files 

The examples below generally assume you are submitting the job from the same directory your program is located in - otherwise you need to give the full path. 

!!! Note 

    Submit with: <code>sbatch MYJOB.sh</code>, where MYJOB.sh is whatever name you gave your submit script. 

    Remember - the submission files/scripts and all programs called by them, must be executable!

The project ID <code>hpc2nXXXX-YYY</code> is used in the examples. Please replace it with your own project ID. 


### Serial jobs

!!! Example "Serial job on Kebnekaise, compiler toolchain ’foss/2021b’"

    ```bash
    #!/bin/bash
    # Project id - change to your own!
    #SBATCH -A hpc2nXXXX-YYY
    # Asking for 1 core
    #SBATCH -n 1
    # Asking for a walltime of 5 min
    #SBATCH --time=00:05:00
    # Purge modules before loading new ones in a script.
    ml purge > /dev/null 2>&1 
    ml foss/2021b

    ./my_serial_program
    ```

!!! Example "Running two executables per node (two serial jobs)"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -n 2
    #SBATCH --time=00:30:00 

    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b
    module load foss/2021b

    # Use '&' to start the first job in the background
    srun -n 1 ./job1 &
    srun -n 1 ./job2 

    # Use 'wait' as a barrier to collect both executables when they are done. If not the batch job will finish when the job2.batch program finishes and kill job1.batch if it is still running.
    wait
    ```

    The scripts job1 and job2 could be any script or executable that is a serial code. The drawback with this examnple is that any output from job1 or job2 will get mixed up in the batch jobs output file. You can handle this by naming the output for each of the jobs or by job1 and job2 being programs that create output to file directly. 


!!! Example "Running two executables per node (two serial jobs) - separate output files"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -n 2
    #SBATCH --time=00:30:00

    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b
    module load foss/2021b

    # Use '&' to start the first job in the background
    srun -n 1 ./job1 > myoutput1 2>&1 &
    srun -n 1 ./job2 > myoutput2 2>&1

    # Use 'wait' as a barrier to collect both executables when they are done. If not the batch job will finish when the job2.batch program finishes and kill job1.batch if it is still running.
    wait
    ```

!!! Example "Naming output/error files. Serial program" 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -n 1
    #SBATCH --time=00:05:00 
    #SBATCH --error=job.%J.err 
    #SBATCH --output=job.%J.out

    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b
    module load foss/2021b

    # And finally run the job
    ./my_program
    ```

    Normally, Slurm produces one output file called slurm-JOBID.out containing the combined standard output and errors from the run (though files created by the program itself will of course also be created). If you wish to rename the output and error files, and get them in separate files, you can do something similar to this example. 

    Using the environment variable <code>%J</code> (contains the JOBID) in your output/error files will ensure you get unique files with each run and so avoids getting the files overwritten. 


### OpenMP jobs 

!!! Example "This example shows a 28 core OpenMP Job (maximum size for a regular Skylake node on Kebnekaise)." 

    ```bash 
    #!/bin/bash
    # Example with 28 cores for OpenMP
    #
    # Project/Account - change to your own 
    #SBATCH -A hpc2nXXXX-YYY
    #
    # Number of cores
    #SBATCH -c 28
    #
    # Runtime of this jobs is less then 12 hours.
    #SBATCH --time=12:00:00
    #
    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b 
    module load foss/2021b 
    
    # Set OMP_NUM_THREADS to the same value as -c
    # with a fallback in case it isn't set.
    # SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
    if [ -n "$SLURM_CPUS_PER_TASK" ]; then
       omp_threads=$SLURM_CPUS_PER_TASK
    else
    omp_threads=1
    fi
    export OMP_NUM_THREADS=$omp_threads

    ./openmp_program
    ```

If you wanted to run the above job, but only use some of the cores for running on (to perhaps use more memory than what is available on 1 core), you can submit with 

```bash
sbatch -c 14 MYJOB.sh 
```


### MPI jobs

!!! Example "MPI job on Kebnekaise, compiler toolchain ’foss/2021b’"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -n 14
    #SBATCH --time=00:05:00
    ##SBATCH --exclusive

    module purge > /dev/null 2>&1
    ml foss/2021b

    srun ./my parallel program
    ```

    The <code>\--exclusive</code> flag means your job will not share the node with any other job (including your own). It is commented out in the above example, but you can remove one of the <code>#</code>'s to activate it if you, for instance, need the entire bandwidth of the node. 

**Note** that this will mean 1) it will likely take longer for the job to start as you need to wait until a full node is available 2) your project will be accounted (time) for the entire node. 


!!! Example "Output from the above MPI job on Kebnekaise, run on 14 cores"

    Note: 14 cores is one NUMA island

    ```bash
    b-an01 [~/slurm]$ cat slurm-15952.out
    The following modules were not unloaded:
    (Use "module --force purge" to unload all):
    1) systemdefault 2) snicenvironment
    Processor 12 of 14: Hello World!
    Processor 5 of 14: Hello World!
    Processor 9 of 14: Hello World!
    Processor 4 of 14: Hello World!
    Processor 11 of 14: Hello World!
    Processor 13 of 14: Hello World!
    Processor 0 of 14: Hello World!
    Processor 1 of 14: Hello World!
    Processor 2 of 14: Hello World!
    Processor 3 of 14: Hello World!
    Processor 6 of 14: Hello World!
    Processor 7 of 14: Hello World!
    Processor 8 of 14: Hello World!
    Processor 10 of 14: Hello World!
    ```

!!! Example "MPI job on Kebnekaise, compiler toolchain ’foss/2021b’ and more memory"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -N 2
    #SBATCH --time=00:05:00
    #SBATCH --exclusive
    # This job example needs 8GB of memory per mpi-task (=mpi ranks, =cores)
    # and since the amount of memory on the regular Skylak nodes is 
    # 6750MB per core, when using all 28 cores we have to use 2 nodes and 
    # only half the cores
    #SBATCH -c 2
    # Make sure we run on a Skylake node 
    #SBATCH --constraint=skylake

    module purge > /dev/null 2>&1
    ml foss/2021b

    srun ./my parallel program
    ```

    The <code>\--exclusive</code> flag means your job will not share the node with any other job (including your own). It is commented out in the above example, but you can remove one of the <code>#</code>'s to activate it if you, for instance, need the entire bandwidth of the node. Using <code>\--exclusive</code> also ensures that all the cores on the node will be available to the job so you could use the memory from all of them for instance. 

    Note that using this flag will mean 1) it will likely take longer for the job to start as you need to wait until a full node is available 2) your project will be accounted (time) for the entire node.


!!! Example "Running fewer MPI tasks than the cores you have available"

    ```bash 
    #!/bin/bash 
    # Account name to run under 
    #SBATCH -A hpc2nXXXX-YYY
    # Give a sensible name for the job
    #SBATCH -J my_job_name
    # ask for 4 full nodes
    #SBATCH -N 4
    #SBATCH --exclusive       
    # ask for 1 day and 3 hours of run time
    #SBATCH -t 1-03:00:00

    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b 
    module load foss/2021b

    # run only 1 MPI task/process on a node, regardless of how many cores the nodes have.
    srun -n 4 --ntasks-per-node=1 ./my_mpi_program
    ```

### Hybrid MPI/OpenMP jobs 

!!! Example "This example shows a hybrid MPI/OpenMP job with 4 tasks and 28 cores per task." 

    ```bash
    #!/bin/bash
    # Example with 4 tasks and 28 cores per task for MPI+OpenMP
    #
    # Project/Account - change to your own 
    #SBATCH -A hpc2nXXXX-YYY
    #
    # Number of MPI tasks
    #SBATCH -n 4
    #
    # Number of cores per task (regular Skylake nodes have 28 cores) 
    #SBATCH -c 28
    #
    # Runtime of this job example is less then 12 hours.
    #SBATCH --time=12:00:00
    #
    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b
    module load foss/2019a

    # Set OMP_NUM_THREADS to the same value as -c
    # with a fallback in case it isn't set.
    # SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
    if [ -n "$SLURM_CPUS_PER_TASK" ]; then
       omp_threads=$SLURM_CPUS_PER_TASK
    else
       omp_threads=1
    fi
    export OMP_NUM_THREADS=$omp_threads

    # Running the program
    srun --cpu_bind=cores ./mpi_openmp_program
    ```

### Multiple jobs  

This section show examples of starting multiple jobs within the same submit file. 

!!! Example "Starting more than one serial job in the same submit file" 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -n 5
    #SBATCH --time=00:15:00

    module purge > /dev/null 2>&1 
    ml foss/2021b

    srun -n 1 ./job1.batch &
    srun -n 1 ./job2.batch &
    srun -n 1 ./job3.batch &
    srun -n 1 ./job4.batch &
    srun -n 1 ./job5.batch
    wait
    ```

    All the jobs are serial jobs, and as they are started at the same time, you need to make sure each has a core to run on. The time you ask for must be long enough that even the longest of the jobs have time to finish. Remember the <code>wait</code> at the end. If you do not include this, then the batch job will finish when the first of the jobs finishes instead of waiting for all to finish. Alsi notice the <code>&</code> at the end of each command to run a job. 


!!! Example "Multiple Parallel Jobs Sequentially"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -c 28
    # Remember to ask for enough time for all jobs to complete
    #SBATCH --time=02:00:00

    module purge > /dev/null 2>&1
    ml foss/2021b

    srun -n 14 ./a.out
    srun -n 14 -c 2 ./b.out
    srun -n 28 ./c.out
    ```
 
    Here the jobs are parallel, but they run sequentially which means that you only need enough cores that you have enough for the job that uses the most cores. In this example, the first uses 14, the second 28 (because each task uses 2 cores), the third uses 28. So you need 28 here. 

    We assume the programs <code>a.out</code>, <code>b.out</code>, and <code>c.out</code> all generate their own output files. Otherwise the output will go to the <code>slurm-JOBID.out</code> file. 

    Note: -n tasks per default uses 1 core per task, unless you use -c to say you want more cores per task.     


!!! Example "Multiple Parallel Jobs Sequentially with named output copied elsewhere"

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    #SBATCH -c 28
    # Remember to ask for enough time for all jobs to complete
    #SBATCH --time=02:00:00

    module purge > /dev/null 2>&1
    ml foss/2021b

    srun -n 14 ./a.out > myoutput1 2>&1
    cp myoutput1 /proj/nobackup/MYSTORAGE/mydatadir
    srun -n 14 -c 2 ./b.out > myoutput2 2>&1
    cp myoutput2 /proj/nobackup/MYSTORAGE/mydatadir
    srun -n 28 ./c.out > myoutput3 2>&1
    cp myoutput3 /proj/nobackup/MYSTORAGE/mydatadir
    ```

    Here the jobs we run and the needed cores and tasks are the same as in the example above, but the output of each one is handled in the script, sending it to a specific output file.

    In addition, this example also shows how you can copy the output to somewhere else (the directory <code>mydatadir</code> located under your project storage which here is called <code>MYSTORAGE</code>). 


!!! Example "Multiple Parallel Jobs Simultaneously" 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    # Total number of cores the jobs need
    #SBATCH -n 56
    #SBATCH --time=02:00:00
 
    module purge > /dev/null 2>&1
    ml foss/2021b

    srun -n 14 --cpu bind=cores --exclusive ./a.out &
    srun -n 28 --cpu bind=cores --exclusive ./b.out &
    srun -n 14 --cpu bind=cores --exclusive ./c.out &
    wait
    ```

    In this example I am starting 3 jobs within the same jobs. You can put as many as you want, of course. Make sure you ask for enough cores that all jobs can run at the same time, and have enough memory. Of course, this will also work for serial jobs - just remove the srun from the command line. 

    Remember to ask for enough time for all of the jobs to complete, even the longest. 

!!! Example "Job arrays" 

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

!!! Example "Job arrays for a Python job"

    === "hello-world-array.py"
        ```python
        # import sys library (we need this for the command line args)
        import sys

        # print task number
        print('Hello world! from task number: ', sys.argv[1])
        ```

    === "Batch script"
        ```bash
        #!/bin/bash
        # This is a very simple example of how to run a Python script with a job array
        #SBATCH -A hpc2nXXXX-YYY # Change to your own!
        #SBATCH --time=00:05:00 # Asking for 5 minutes
        #SBATCH --array=1-10   # how many tasks in the array
        #SBATCH -c 1 # Asking for 1 core    # one core per task
        #SBATCH -o hello-world-%j-%a.out

        # Set a path where the example programs are installed, if they are not in the 
        # same path as the batch script.
        # Change the below to your own path 
        MYPATH=/proj/nobackup/<mystoragedir>/<rest-of-path>/

        # Load any modules you need, here for Python 3.11.3
        ml GCC/12.3.0 Python/3.11.3

        # Run your Python script
        srun python $MYPATH/hello-world-array.py $SLURM_ARRAY_TASK_ID
        ```


### GPU Jobs 

!!! Example "GPU job on Kebnekaise, asking for 2 V100 cards" 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2nXXXX-YYY
    # Expected time for job to complete
    #SBATCH --time=00:10:00
    # Number of GPU cards needed. Here asking for 2 V100 cards
    #SBATCH --gpus-per-node=v100:2

    module purge > /dev/null 2>&1
    ml foss/2023b CUDA/12.4.0

    ./my-program
    ```




