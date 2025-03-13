# Job dependencies - Slurm

A job can be given the constraint that it only starts after another job has finished.

!!! Example 

    Assume we have two Jobs, A and B. We want Job B to start after Job A has successfully completed.

    First we start Job A (with submit file jobA.sh) by submitting it via <code>sbatch</code>:

    ```bash
    $ sbatch jobA.sh
    ```

    Making note of the assigned job-id for Job A (JOBID-JobA), we then submit Job B (with submit file jobB.sh) with the added condition that it only starts after Job A has successfully completed:

    ```bash
    $ sbatch --dependency=afterok:JOBID-JobA jobB.sh
    ```

    If we want Job B to start after several other Jobs have completed, we can specify additional jobs, using a ':' as a delimiter:

    ```bash
    $ sbatch --dependency=afterok:JOBID-JobA:JOBID-JobC:JOBID-JobD jobB.sh
    ```

    We can also tell slurm to run Job B, even if Job A fails, like so:

    ```bash
    sbatch --dependency=afterany:JOBID-JobA jobB.sh
    ```

For more information, consult the <code>man</code> page for <code>sbatch</code>.
