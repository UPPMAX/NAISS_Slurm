# Job monitoring and efficiency

This section looks at how to monitor your job(s), including to see if they are efficient. 

Many of the relevant commands have already been discussed in previous parts: 

- `squeue`: for viewing the state of the batch queue. More here: <a href="https://uppmax.github.io/NAISS_Slurm/slurm/#squeue" target="_blank">https://uppmax.github.io/NAISS_Slurm/slurm/#squeue</a>
- `scancel`: to cancel a job. More info here: <a href="https://uppmax.github.io/NAISS_Slurm/slurm/#scancel" target="_blank">https://uppmax.github.io/NAISS_Slurm/slurm/#scancel</a>
- `sinfo`: information about the partitions/queues. More info here: <a href="https://uppmax.github.io/NAISS_Slurm/slurm/#sinfo" target="_blank">https://uppmax.github.io/NAISS_Slurm/slurm/#sinfo</a>
- `scontrol show job`: lots of information about a job. More info here: <a href="https://uppmax.github.io/NAISS_Slurm/slurm/#scontrol__show__job" target="_blank">https://uppmax.github.io/NAISS_Slurm/slurm/#scontrol__show__job</a>

But there are several others that have either not been mentioned or only done so briefly, including `sacct`, `projinfo`, `sshare`` and a number of center specific commands. We will look more into all of them here. 

## Why is a job ineffective? 

There are several reasons that a job might be ineffective. Some of those could be: 

- using more threads than the allocated number of cores
- not using all the cores you have allocated (unless on purpose/for memory)
- inefficient use of the file system (many small files, open/close many files)
- running a job that could run on GPUs on CPUs instead

Job monitoring is (also) about detecting signs the job is not running efficiently. This can be done with many different commands. 

## Job monitoring 

Now let us look at some of the commands that are genereally available, as well as those that are specific to one or more centres. 

### Commands valid at all centres 

| Command | What |  
| ------- | ---- | 
| ``scontrol show job JOBID`` | info about a job, including *estimated* start time | 
| ``squeue --me --start`` | your running and queued jobs with *estimated* start time | 
| ``sacct -l -j JOBID`` | info about job, pipe to ``less -S`` for scrolling side-ways (it is a wide output) | 
| ``projinfo`` | usage of your project, adding ``-vd`` lists member usage | 
| ``sshare -l -A <proj-account>`` | gives priority/fairshare (LevelIFS) | 

Most up-to-date project usage on a project's SUPR page, linked from here: <a href="https://supr.naiss.se/project/" target="_blank">https://supr.naiss.se/project/</a>

### Site-specific commands 

| Command | What | Centre | 
| ------- | ---- | ------ |
| ``jobinfo``| wrapper around ``squeue`` | UPPMAX, LUNARC, C3SE |
| ``jobstats -p JOBID`` | CPU and memory use of finished job (> 5 min) in a plot | UPPMAX |
| ``job_stats.py`` | link to Grafana dashboard with overview of your running jobs. Add ``JOBID`` for real-time usage of a job | C3SE |
| ``job-usage JOBID`` | grafana graphics of resource use for job (> few minutes) | HPC2N |
| ``jobload JOBID`` | show cpu and memory usage in a job | NSC |
| ``jobsh NODE`` | login to node, run "top" | NSC |
| ``seff JOBID`` |  displays memory and CPU usage from job run | NSC, PDC | 
| ``lastjobs`` | lists 10 most recent job in recent 30 days | NSC |
| <a href="https://pdc-web.eecs.kth.se/cluster_usage/" target="_blank">https://pdc-web.eecs.kth.se/cluster_usage/</a> | Information about project usage | PDC |
| <a href="https://grafana.c3se.chalmers.se/d/user-jobs/user-jobs" target="_blank">https://grafana.c3se.chalmers.se/d/user-jobs/user-jobs</a> | Grafana dashboard for user jobs | C3SE |
| <a href="https://www.nsc.liu.se/support/batch-jobs/tetralith/monitoring/" target="_blank">https://www.nsc.liu.se/support/batch-jobs/tetralith/monitoring/</a> | Job monitoring | NSC |
| <a href="https://docs.uppmax.uu.se/software/jobstats/" target="_blank">https://docs.uppmax.uu.se/software/jobstats/</a> | Job efficiency | UPPMAX |

