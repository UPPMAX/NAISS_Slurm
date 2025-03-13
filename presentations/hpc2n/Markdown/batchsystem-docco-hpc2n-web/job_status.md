# Queue and job status

To see status of partitions and nodes, use

<div>
```bash
$ sinfo
```
</div>

To get the status of all Slurm jobs

<div>
```bash
$ squeue
```
</div>

To get the status of all your Slurm jobs

<div>
```bash
$ squeue --me
```
</div>

Get detailed information about an individual job

<div>
```bash
$ scontrol show job JOBID
```
</div>

You get the JOBID either when you submit the job with <code>sbatch</code>, or from checking with <code>squeue -u USERNAME</code>. 

