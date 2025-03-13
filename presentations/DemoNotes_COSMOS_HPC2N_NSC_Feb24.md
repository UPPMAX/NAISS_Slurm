#Demo notes for SLURM

## Concepts
Show and discuss the slides

## simple scripts
Start in `/home/x_joahe/Support/BatchSeminar/`

```
mkdir Demo
cd Demo
```

Make simple script `run_hello.sh`

*Tetralith*

```
#!/bin/bash
#SBATCH -t 00:05:00
#SBATCH -A naiss2024-5-11

echo "hello from:" $HOSTNAME
```



* Show `projinfo` on Aurora, Kebnekaise or Tetralith
* Mention directories, e.g. Kebnekaise you need to run from `/pfs/nobackup/home/u/user/`
* run `echo "hello from:" $HOSTNAME` on frontend

### interacting with the queue
Submit to the queue using `sbatch`

* add a line: `sleep 120` to the script

Demo:

* `squeue`
* `squeue -u x_joahe`
* `scancel 7103` of a running job

Add a line `#SBATCH -n 1500` to make the jobs wait

* show `squeue -u jhein --start` needs some time to show
* `scancel` that job
* Remove the `-n 1500` from the script to clean up!

### Show slides
* Comments on wall time
* Dependencies

### Quick demo dependency
Reduce sleep time to: `sleep 30` and show the following:

```
sbatch run_hello.sh
squeue -u x_joahe

# get the jobnumber

sbatch -d afterok:jobnumber run_hello.sh
squeue -u x_joahe
```

## Beautification
Show commenting, e.g. jobtime
### Jobname

```
#SBATCH -J hello_60
```

* mention metadata
* show it is to long

### Output/Error file names
Add output and jobnames 

```
#SBATCH -o result_hello_10.out
#SBATCH -e result_hello_10.err
```
and change sleep time/job name to 10

show that it overwrites output, change to

```
#SBATCH -o result_hello_10_%j.out
#SBATCH -e result_hello_10_%j.err
```
to add jobnumber.

### job script in output
add a

```
cat $0
```
to the script to get the script into the output.

### get mail from slurm

```
#SBATCH --mail-user=joachim.hein@lunarc.lu.se
#SBATCH --mail-type=END
```

Final output should look similar to:

```
#!/bin/bash

# specify the jobtime
#SBATCH -t 00:05:00

# specify project
#SBATCH -A snic2022-5-301

#SBATCH -J hello_10

#SBATCH -o result_hello_10_%j.out
#SBATCH -e result_hello_10_%j.err

#SBATCH --mail-user=joachim.hein@math.lu.se
#SBATCH --mail-type=END

cat $0

sleep 10
echo "hello from:" $HOSTNAME
```

## Node load disks
* show slides

## Additional resouces

* show slides

## Multiprocessor jobs

* show slides

change directory:

```
cd /home/x_joahe/Support/BatchSeminar/BatchDemo/Fortran
```

create script:
No module loads needed on tetralith - typically they are needed

```
#!/bin/bash

#SBATCH -t 5
#SBATCH -A naiss2024-5-11
#SBATCH -N 2
#SBATCH --tasks-per-node=32

#SBATCH -J mpi_N2_32

#SBATCH -o mpi_run_N2_32_%j.out
#SBATCH -e mpi_run_N2_32_%j.out


cat $0

# on other system you need to load the relevant modules, e.g. MPI library

mpprun ./mpihello
```

## Jobfarm

* show slides

Demo in:

**Make sure to run:** `createScript.sh` **!!!!!**

```
cd /home/jhein/SLURMdemo/Taskfarm
```

Show files

monitor with:

```
squeue -j 4760791 -s
```
