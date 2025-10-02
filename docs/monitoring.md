# Job monitoring and efficiency

Discuss squeue, scancel, sinfo, sacct, ...

## Why is a job ineffective?

- more threads than allocated cores
- not using all the cores you have allocated (unless on purpose/for memory)
- inefficient use of the file system (many small files, open/close many files)
- running job that could run on GPU on CPU instead

## Job monitoring 

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
| <a href="https://grafana.c3se.chalmers.se/d/user-jobs/user-jobs" target="_blank">https://grafana.c3se.chalmers.se/d/user-jobs/user-jobs</a> | Graphana dashboard for user jobs | C3SE |
| <a href="https://www.nsc.liu.se/support/batch-jobs/tetralith/monitoring/" target="_blank">https://www.nsc.liu.se/support/batch-jobs/tetralith/monitoring/</a> | Job monitoring | NSC |
| <a href="https://docs.uppmax.uu.se/software/jobstats/" target="_blank">https://docs.uppmax.uu.se/software/jobstats/</a> | Job efficiency | UPPMAX |

