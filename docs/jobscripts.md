# Sample job scripts

## The Simplest Job

The simplest possible batch script would look something like this:

```bash
#!/bin/bash
#SBATCH -A lu20yy-x-xx    ###replace with your project ID
#SBATCH -t 00:05:00

echo $HOSTNAME
```

The first line is called the "shebang" and it indicates that the script is
written in the bash shell language.

The second and third lines are resource statements. The second line above is a
template resembling typical project IDs at LUNARC. While not technically required
if you only have one project to your name, we recommend that you make a habit of
including it. The third line in the example above provides the walltime, the
maximum amount of time that the program would be allowed to run (5 minutes in
this example). If a job does not finish within the specified walltime, the
resource management system terminates it and any data that were not already
written to a file before time ran out are lost.

The last line in the above sample is the code to be executed by the batch script.
In this case, it just prints the name of the server on which the code ran.

All of the parameters that Slurm needs to determine which resources to allocate,
under whose account, and for how long, must be given as a series of resource
statements of the form `#SBATCH -<option> <value>` or `#SBATCH --<key-words>=<value>`
(*note: `<` and `>` are not typically used in real arguments; they're just used*
*here to indicate placeholder text*). For most compute nodes, unless otherwise
specified, a batch script will run on 1 core of 1 node by default. However, the
default settings may vary between HPC centers or between partitions at the same
HPC center.

## Basic Serial Job

Let's say you have a simple Python script called `mmmult.py` that creates 2
random-valued matrices, multiplies them together, and prints the shape of the
result and the computation time. Let's also say that you want to run this code
in your current working directory. Here is how you might run that program once
on 1 core and 1 node:

```bash
#!/bin/bash
#SBATCH -A lu20yy-x-xx       ### replace with your project ID
#SBATCH -t 00:10:00          ### walltime in hh:mm:ss format
#SBATCH -J mmmult            ### sample job name; customize as desired or omit
#SBATCH -o process_%j.out    ### filename for stderr - customise, include %j
#SBATCH -e process_%j.err    ### filename for stderr - customise, include %j
#SBATCH -n 1                 ### number of cores to use; same as --ntasks-per-node

# write this script to stdout-file - useful for scripting errors
cat $0

# Purge any loaded modules
ml purge > /dev/null 2>&1

# Load required modules; customize as needed
# Can omit module version number if prerequisites only allow one version
ml foss/2023b Python/3.11.5 SciPy-bundle

#run the script
python3 mmmult.py
```
