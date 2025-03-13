# Detailed description of scheduling

The Slurm scheduler divides the job queue in two parts.

1. **Running jobs.** These are the jobs that are currently running.
2. **Pending jobs.** These are the jobs that are being considered for scheduling, or (for policy reasons like rules and limits), are not (yet) being considered for scheduling.

Basically what happens when a job is submitted is this.

1. The job is put in the correct part of the queue (pending) according to the policy rules.
2. The scheduler checks if any jobs that were previously breaking policy rules, can now be considered for scheduling.
3. The scheduler calculates a new priority for all the jobs in the pending part.
4. If there are available processor resources the highest priority job(s) will be started.
5. If the highest priority job cannot be started for lack of resources, the next job that fits, without changing the predicted startwindow for any higher priority jobs, will be started (so called backfilling).

**Calculating priority**

When a job is submitted, the Slurm batch scheduler assigns it an initial priority. The priority value will be recalculated periodically while the job is waiting, until the job gets to the head of the queue. This happens as soon as the needed resources are available, provided no jobs with higher priority and matching available resources exists. When a job gets to the head of the queue, and the needed resources are available, the job will be started.

At HPC2N, Slurm assigns job priority based on the Multi-factor Job Priority scheduling. As it is currently set up, only one thing influence job priority:

- Fair-share: the difference between the portion of the computing resource that has been promised and the amount of resources that has been consumed by a group

Weights has been assigned to the above factors in such a way that fair-share is the dominant factor.

The following formula is used to calculate a job's priority:

<div>
```bash
Job_priority = 1000000 * (fair-share_factor)
```
</div>

Priority is then calculated as a weighted sum of these.

The <code>fair-share\_factor</code> is dependent on several things, mainly:

- Which project account you are running in.
- How much you and other members of your project have been running. This fair share weight decays over 50 days, as mentioned earlier.

You can see the current value of your jobs fairshare factors with this command

```bash
sprio -l -u <username>
```

and your and your project's current fairshare value with 

```bash
sshare -l -u <username>
```

!!! Note 

    - these values change over time, as you and your project members use resources, others submit jobs, and time passes.
    - the job will NOT rise in priority just due to sitting in the queue for a long time. No priority is calculated merely due to age of the job.

For more information about how fair-share is calculated in Slurm, please see: <a href="https://slurm.schedmd.com/priority_multifactor.html" target="_blank">http://slurm.schedmd.com/priority_multifactor.html</a>. 

