# Batch system Policies

The batch system policy is fairly simple, and <u>currently</u> states that: 

- A job is not allowed to run longer than 7 days (604800 s) regardless of the allocated CPU time.
- A job will start when the resources you have asked for are available (it takes longer to get more cores etc.), and your priority is high enough, compared to others. How high a priority your job has, depends on 
    1. your allocation 
    2. whether or not you, or others using the same project, have run a lot of jobs recently. If you have, then your priority becomes lower.
- The sum of the size (remaining-runtime * number-of-cores) of all running jobs must be less than the monthly allocation.

!!! warning 

    If you submit a job that takes up more than your monthly allocation (remember running jobs take away from that), then your job will be pending with **"Reason=AssociationResourceLimit"** or **"Reason=AssocGrpBillingRunMinutes"** until enough running jobs have finished. 

    **Also, a job cannot start if it asks for more than your total monthly allocation.**

You can see the current priority of your project (and that of others), by running the command <code>sshare</code> and look for the column marked <code>'Fairshare'</code> - that shows your groups current priority.

The fairshare usage weight decays gradually over 50 days, meaning that jobs older than 50 days does not count towards priority.

!!! Remember 

    When and if a job starts depends on which resources it is requesting. If a job is asking for, say, 10 nodes and only 8 are currently available, the job will have to wait for resources to free up. Meanwhile, other jobs with lower requirements will be allowed to start as long as they do not affect the start time of higher priority jobs. 

