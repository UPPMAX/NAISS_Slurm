# Batch scripts (Job Submission Files)

The official name for batch scripts in Slurm is Job Submission Files, but here we will use both names interchangeably. If you search the internet, you will find several other names used, including Slurm submit file, batch submit file, batch script, job script. 

A job submission file can contain any of the commands that you would otherwise issue yourself from the command line. It is, for example, possible to both compile and run a program and also to set any necessary environment values (though remember that Slurm exports the environment variables in your shell per default, so you can also just set them all there before submitting the job).

The results from compiling or running your programs can generally be seen after the job has completed, though as Slurm will write to the output file during the run, some results will be available quicker.

Outputs and any errors will per default be placed in the directory you are running from, though this can be changed. 

**Note** that this directory should preferrably be placed under your project storage, since your home directory only has 25 GB of space. 

!!! Note "Changing the output and error file"

    Both output and errors will, by default, be combined into a file named <code>slurm-JOBID.out</code>. You can send them to other/separate files with these commands:

    ```bash
    #SBATCH --error=job.%J.err 
    #SBATCH --output=job.%J.out
    ```

    In the example above, you get files named <code>job.JOBID.err</code> and <code>job.JOBID.out</code>, you can of course give them other names, but if you are running several batch jobs, remember to name them so they are not over-written by later jobs (use the <code>%J</code> environment variable).

A job submission file can either be very simple, with most of the job attributes specified on the command line, or it may consist of several Slurm directives, comments and executable statements. A Slurm directive provides a way of specifying job attributes in addition to the command line options.

**Naming**: You can name your script anything, including the suffix. It does not matter. Just name it something that makes sense to you and helps you remember what the script is for. The standard is to name it with a suffix of <code>.sbatch</code> or <code>.sh</code>.

**Note** that you have to <u>always</u> include <code>#!/bin/bash</code> at the beginning of the script, since <code>bash</code> is the only supported shell. Some things may work under other shells, but not everything.

!!! Example

    This example batch script is for a job with 8 MPI tasks, and separated output and error files. 

    ```bash
    #!/bin/bash
    # The name of the account you are running in, mandatory.
    #SBATCH -A hpc2nXXXX-YYY
    # Request resources - here for eight MPI tasks
    #SBATCH -n 8
    # Request runtime for the job (HHH:MM:SS) where 168 hours is the maximum. Here asking for 15 min. 
    #SBATCH --time=00:15:00 
    # Set the names for the error and output files 
    #SBATCH --error=job.%J.err 
    #SBATCH --output=job.%J.out

    # Clear the environment from any previously loaded modules
    module purge > /dev/null 2>&1

    # Load the module environment suitable for the job - here foss/2021b 
    module load foss/2021b

    # And finally run the job - use srun for MPI jobs, but not for serial jobs 
    srun ./my_mpi_program
    ```

!!! NOTE 

    - One (or more) <code>#</code> in front of a text line means it is a comment, with the exception of the string <code>#SBATCH</code>. <code>#SBATCH</code> is used to signify a Slurm directive. In order to comment out these, you need to put one more <code>#</code> in front of the <code>#SBATCH</code>.
    - It is important to use capital letters for <code>#SBATCH</code>. Otherwise the line will be considered a comment, and ignored.

Let us go through the most commonly used arguments: 

- **-A PROJ-ID**: The project that should be accounted. It is a simple conversion from the SUPR project id. You can also find your project account with the command <code>projinfo</code>.  The PROJ-ID argument is of the form 
      - hpc2nXXXX-YYY (HPC2N local project)
- **-N**: number of nodes. If this is not given, enough will be allocated to fullfill the requirements of -n and/or -c. A range can be given. If you ask for, say, 1-1, then you will get 1 and only 1 node, no matter what you ask for otherwise. It will also assure that all the processors will be allocated on the same node.
- **-n**: number of tasks.
- **-c**: cores per task. Request that a specific number of cores be allocated to each task. This can be useful if the job is multi-threaded and requires more than one core per task for optimal performance. The default is one core per task.

See <code>man sbatch</code> or the section on [Job Submit file design](./submit_file_design.md) for more commands for the script.

!!! Overview

    Processing of the job script

    - When the job is submitted, the lines of the script file are scanned for directives. 
    - An initial line in the script that begins with the characters <code>"#!"</code> will be ignored at this point and scanning will start with the next line. 
    - Scanning will continue until the first executable line, that is a line that is not blank, not a directive line, nor a line whose first non-white space character is <code>"#"</code>. 
    - If directives occur on subsequent lines, they will be ignored. 
    - The remainder of the directive line consists of the options to slurm in the same syntax as they appear on the command line. 
    - The option character is to be preceded with the <code>"-"</code> character, or <code>"--"</code> in the long form. 
    - If an option is present in both a directive and on the command line, that option and its argument, if any, will be ignored in the directive. The command line takes precedence!
    - If an option is present in a directive and not on the command line, that option and its argument, if any, will be processed as if it had occurred on the command line.

There are several examples of Slurm job submission files in [a later section](./basic_examples.md). 
