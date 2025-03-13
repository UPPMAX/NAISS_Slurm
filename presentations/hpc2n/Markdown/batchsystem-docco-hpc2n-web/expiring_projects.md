## Expiring projects

If you have jobs still in the queue when your project expires, your job will not be removed, but they will not start to run. 

You will have to remove them yourself, or, if you have a new project, you can change the project account for the job with this command

<div>
```bash 
scontrol update job=<jobid> account=<newproject> 
```
</div>

