# Squeue "Reason" explained

Due to the way we have setup the batch system, jobs can sometimes
display unexpected states in the squeue output. Here we describe some of
the ones that can usually be ignored since they won't normally affect a
jobs ability to start.

- **AssocGrpBillingRunMinutes**: The project's currently active
  resources plus the pending job's requested resources exceeds the limit
  of one monthly allocation being in use at any point in time.  The
  pending job will eventually start, unless it, by itself, is larger
  than one monthly allocation for the project.

- **BadConstraints**: Some contraint set on the job (-C/--contraint) is
  not available on some of the partitions the job has been sent to by
  our remapping script. This is not a problem since the batch system
  will only send the job to a partition which fulfills the contraint. If
  the jobs constraints can't be fulfilled by any partition the job will
  stay in this state and never start.
