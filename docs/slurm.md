# Introduction to Slurm

The batch system used at UPPMAX, HPC2N, LUNARC, NSC, PDC, C3SE (and most other HPC centres in Sweden) is called Slurm.

!!! note "Guides and documentation"

    - HPC2N: <a href="https://docs.hpc2n.umu.se/documentation/batchsystem/intro/" target="_blank">https://docs.hpc2n.umu.se/documentation/batchsystem/intro/</a>
    - UPPMAX: <a href="https://docs.uppmax.uu.se/cluster_guides/slurm/" target="_blank">https://docs.uppmax.uu.se/cluster_guides/slurm/</a>
    - LUNARC: <a href="https://lunarc-documentation.readthedocs.io/en/latest/manual/manual_intro/" target="_blank">https://lunarc-documentation.readthedocs.io/en/latest/manual/manual_intro/</a>
    - NSC: <a href="https://www.nsc.liu.se/support/batch-jobs/introduction/" target="_blank">https://www.nsc.liu.se/support/batch-jobs/introduction/</a>
    - PDC: <a href="https://support.pdc.kth.se/doc/run_jobs/job_scheduling/" target="_blank">https://support.pdc.kth.se/doc/run_jobs/job_scheduling/</a>
    - C3SE: <a href="https://www.c3se.chalmers.se/documentation/submitting_jobs/" target="_blank">https://www.c3se.chalmers.se/documentation/submitting_jobs/</a>

Slurm is an Open Source job scheduler, which provides three key functions:

- Keeps track of available system resources - it allocates to users, exclusive or non-exclusive access to resources for some period of time
- Enforces local system resource usage and job scheduling policies - provides a framework for starting, executing, and monitoring work
- Manages a job queue, distributing work across resources according to policies

Slurm is designed to handle thousands of nodes in a single cluster, and can sustain throughput of 120,000 jobs per hour.

You can run programs either by giving all the commands on the command line or by submitting a job script.

Using a job script is often recommended:

- If you ask for the resources on the command line, you will wait for the program to run before you can use the window again (unless you can send it to the background with ``&``).
- If you use a job script you have an easy record of the commands you used, to reuse or edit for later use.

In order to run a batch job, you need to create and submit a SLURM submit file (also called a batch submit file, a batch script, or a job script).

## Slurm commands

There are many more commands than the ones we have chosen to look at here, but these are the most commonly used ones. You can find more information on the Slurm homepage: <a href="https://slurm.schedmd.com/documentation.html" target="_blank">Slurm documentation</a>.

- **salloc**: requesting an interactive allocation
- **interactive**: another way of requesting an interactive allocation
- **sbatch**: submitting jobs to the batch system
- **squeue**: viewing the state of the batch queue
- **scancel**: cancel a job
- **scontrol show**: getting more info on jobs, nodes
- **sinfo**: information about the partitions/queues

Let us look at these one at a time.

### salloc and interactive

This will be covered in the next section about Interactive. 

### sbatch

The command ``sbatch`` is used to submit jobs to the batch system.

This is done from the command line in the same way at all the HPC centres in Sweden:

```bash
sbatch <batchscript.sh>
```

For any <batchscript.sh> named whatever you want to. It is a convention to use the suffix ``.sbatch`` or ``.sh``, but it is not a requirement. You can use any or no suffix. It is merely to make it easier to find the script among the other files.

!!! note

    - At centres that have OpenOnDemand installed, you do not have to submit a batch job, but can run directly on the already allocated resources (see interactive jobs).
        - OpenOnDemand is a good option for interactive tasks, graphical applications/visualization, and simpler job submittions. It can also be more user-friendly.
        - Regardless, there are many situations where submitting a batch job is the best option instead, including when you want to run jobs that need many resources (time, memory, multiple cores, multiple GPUs) or when you run multiple jobs concurrently or in a specified succession, without need for manual intervention. Batch jobs are often also preferred for automation (scripts) and reproducibility. Many types of application software fall into this category.
    - At centres that have ThinLinc you can usually submit MATLAB jobs to compute resources from within MATLAB.

We will talk much more about batch scripts in a short while, but for now we can use <a href="../simple.sh" target="_blank">this small batch script</a> for testing the Slurm commands:

```bash
#!/bin/bash
# Project id - change to your own!
#SBATCH -A PROJ-ID
# Asking for 1 core
#SBATCH -n 1
# Asking for a walltime of 1 min
#SBATCH --time=00:01:00

echo "What is the hostname? It is this: "

/bin/hostname
```

!!! hint 

    You find the above batch script named "simple.sh" in the exercises tarball, under the folder "introslurm". 

    REMEMBER TO CHANGE THE PROJECT ID TO YOUR OWN! 

    - If you are on Dardel, you also need to add a partition in order to make it run. Use the "dardel-simple.sh" from the tarball in that case. 

**Example**:

Submitting the above batch script on Tetralith (NSC)

```bash
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194426
```

As you can see, you get the job id when submitting the batch script.

When it has run, you can see with ``ls`` that you got a file called ``slurm-JOBID.out`` in your directory.

!!! hint

    Try it out! 

### squeue

The command ``squeue`` is for viewing the state of the batch queue.

If you just give the command, you will get a long list of all jobs in the queue, so it is usually best to constrain it to your own jobs. This can be done in two ways:

- ``squeue -u <username>``
- ``squeue --me``

**Example**:

```bash
b-an01 [~]$ squeue --me
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          34815904   cpu_sky mpi_gree bbrydsoe  R       0:00      1 b-cn1404
          34815905   cpu_sky mpi_hell bbrydsoe  R       0:00      2 b-cn[1404,1511]
          34815906   cpu_sky mpi_hi.s bbrydsoe  R       0:00      2 b-cn[1511-1512]
          34815907   cpu_sky simple.s bbrydsoe  R       0:00      1 b-cn1512
          34815908   cpu_sky compiler bbrydsoe  R       0:00      2 b-cn[1415,1512]
          34815909   cpu_sky mpi_gree bbrydsoe  R       0:00      1 b-cn1415
          34815910   cpu_sky mpi_hell bbrydsoe  R       0:00      3 b-cn[1415,1421-1422]
          34815911   cpu_sky mpi_hi.s bbrydsoe  R       0:00      1 b-cn1422
          34815912   cpu_sky simple.s bbrydsoe  R       0:00      1 b-cn1422
          34815913   cpu_sky compiler bbrydsoe  R       0:00      2 b-cn[1422,1427]
          34815902  cpu_zen4 simple.s bbrydsoe CG       0:03      1 b-cn1707
          34815903  cpu_zen4 compiler bbrydsoe  R       0:00      1 b-cn1708
          34815898  cpu_zen4 compiler bbrydsoe  R       0:03      2 b-cn[1703,1705]
          34815899  cpu_zen4 mpi_gree bbrydsoe  R       0:03      2 b-cn[1705,1707]
          34815900  cpu_zen4 mpi_hell bbrydsoe  R       0:03      1 b-cn1707
          34815901  cpu_zen4 mpi_hi.s bbrydsoe  R       0:03      1 b-cn1707
          34815922 cpu_zen4, simple.s bbrydsoe PD       0:00      1 (Priority)
          34815921 cpu_zen4, mpi_hi.s bbrydsoe PD       0:00      1 (Priority)
          34815920 cpu_zen4, mpi_hell bbrydsoe PD       0:00      1 (Priority)
          34815919 cpu_zen4, mpi_gree bbrydsoe PD       0:00      1 (Priority)
          34815918 cpu_zen4, compiler bbrydsoe PD       0:00      1 (Priority)
          34815917 cpu_zen4, simple.s bbrydsoe PD       0:00      1 (Priority)
          34815916 cpu_zen4, mpi_hi.s bbrydsoe PD       0:00      1 (Priority)
          34815915 cpu_zen4, mpi_hell bbrydsoe PD       0:00      1 (Priority)
          34815914 cpu_zen4, mpi_gree bbrydsoe PD       0:00      1 (Resources)
```

Here you also see some of the "states" a job can be in. Some of the more common ones are:

- **CA**: CANCELLED. Job was explicitly cancelled by the user or system administrator.
- **CF**: CONFIGURING. Job has been allocated resources, but are waiting for them to become ready for use (e.g. booting).
- **CG**: COMPLETING. Job is in the process of completing. Some processes on some nodes may still be active.
- **PD**: PENDING. Job is awaiting resource allocation.
- **R**: RUNNING. Job currently has an allocation.
- **S**: SUSPENDED. Job has an allocation, but execution has been suspended and resources have been released for other jobs.

List above from <a href="https://slurm.schedmd.com/squeue.html" target="_blank">Slurm workload manager page about squeue</a>.

**Example**:

Submit the "simple.sh" script several times, then do ``squeue --me`` to see that it is running, pending, or completing.

```bash
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194596
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194597
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194598
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194599
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194600
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194601
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194602
[x_birbr@tetralith3 ~]$ sbatch simple.sh
Submitted batch job 45194603
[x_birbr@tetralith3 ~]$ squeue --me
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          45194603 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194602 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194601 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194600 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194599 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194598 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194597 tetralith simple.s  x_birbr PD       0:00      1 (None)
          45194596 tetralith simple.s  x_birbr PD       0:00      1 (None)
```

!!! hint

    Try it! Remember, "arrow up" lets you quickly access a previous command. 

### scancel

The command to cancel a job is ``scancel``.

You can either cancel a specific job:

``scancel <job id>``

or cancel all your jobs:

``scancel -u <username>``

!!! note

    As before, you get the ``<job id>`` either from when you submitted the job or from ``squeue --me``.

!!! warning "Note"

    Only administrators can cancel other people's jobs!

### scontrol show

The command ``scontrol show`` is used for getting more info on jobs and nodes.

#### scontrol show job

As usual, you get the ``<job id>`` from either when you submit the job or from ``squeue --me``.

The command is:

```bash
scontrol show job <job id>
```

**Example**:

```bash
b-an01 [~]$ scontrol show job 34815931
JobId=34815931 JobName=compiler-run
   UserId=bbrydsoe(2897) GroupId=folk(3001) MCS_label=N/A
   Priority=2748684 Nice=0 Account=staff QOS=normal
   JobState=COMPLETED Reason=None Dependency=(null)
   Requeue=0 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
   RunTime=00:00:07 TimeLimit=00:10:00 TimeMin=N/A
   SubmitTime=2025-06-24T11:36:32 EligibleTime=2025-06-24T11:36:32
   AccrueTime=2025-06-24T11:36:32
   StartTime=2025-06-24T11:36:32 EndTime=2025-06-24T11:36:39 Deadline=N/A
   SuspendTime=None SecsPreSuspend=0 LastSchedEval=2025-06-24T11:36:32 Scheduler=Main
   Partition=cpu_zen4 AllocNode:Sid=b-an01:626814
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=b-cn[1703,1705]
   BatchHost=b-cn1703
   NumNodes=2 NumCPUs=12 NumTasks=12 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   ReqTRES=cpu=12,mem=30192M,node=1,billing=12
   AllocTRES=cpu=12,mem=30192M,node=2,billing=12
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryCPU=2516M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:02:00
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/compile-run.sh
   WorkDir=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage
   StdErr=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out
   StdIn=/dev/null
   StdOut=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out
   Power=
```

Here you get much interesting information:

- **JobState=COMPLETED**: the job was completed and was not FAILED. It could also have been PENDING or COMPLETING
- **RunTime=00:00:07**: the job ran for 7 seconds
- **TimeLimit=00:10:00**: It could have run for up to 10 min (what you asked for)
- **SubmitTime=2025-06-24T11:36:32**: when your job was submitted
- **StartTime=2025-06-24T11:36:32**: when the job started
- **Partition=cpu_zen4**: what partition/type of node it ran on
- **NodeList=b-cn[1703,1705]**: which specific nodes it ran on
- **BatchHost=b-cn1703**: which of the nodes (if several) that was the master
- **NumNodes=2 NumCPUs=12 NumTasks=12 CPUs/Task=1**: number of nodes, cpus, tasks
- **WorkDir=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage**: which directory your job was submitted from/was running in
- **StdOut=/pfs/proj/nobackup/fs/projnb10/support-hpc2n/bbrydsoe/intro-course/hands-ons/3.usage/slurm-34815931.out**: which directory the output files will be placed in

The command ``scontrol show job <job id>`` can be run also while the job is pending, and can be used to get an estimate of when the job will start. Actual start time depends on the jobs priority, any other (people's) jobs starting and completing and being submitted, etc.

It is often useful to know which nodes a job ran on if something did not work - perhaps the node was faulty.

!!! hint "Exercise" 

    Try it! Submit the "simple.sh" batch script and then do ``scontrol show job JOBID`` using the job ID you got when you submitted the batch script. Try to find the "SubmitTime", "StartTime", and "NodeList" in the output. 

#### scontrol show node

This command is used to get information about a specific node. You can for instance see its features, how many cores per socket, uptime, etc. Specifics will vary and depend on the centre you are running jobs at.

**Example**:

This is for one of the AMD Zen4 nodes at Kebnekaise, HPC2N.

```bash
b-an01 [~]$ scontrol show node b-cn1703
NodeName=b-cn1703 Arch=x86_64 CoresPerSocket=128 
   CPUAlloc=253 CPUEfctv=256 CPUTot=256 CPULoad=253.38
   AvailableFeatures=rack17,amd_cpu,zen4
   ActiveFeatures=rack17,amd_cpu,zen4
   Gres=(null)
   NodeAddr=b-cn1703 NodeHostName=b-cn1703 Version=23.02.7
   OS=Linux 5.15.0-142-generic #152-Ubuntu SMP Mon May 19 10:54:31 UTC 2025 
   RealMemory=644096 AllocMem=636548 FreeMem=749623 Sockets=2 Boards=1
   State=MIXED ThreadsPerCore=1 TmpDisk=0 Weight=100 Owner=N/A MCS_label=N/A
   Partitions=cpu_zen4 
   BootTime=2025-06-24T06:32:25 SlurmdStartTime=2025-06-24T06:37:02
   LastBusyTime=2025-06-24T08:29:45 ResumeAfterTime=None
   CfgTRES=cpu=256,mem=629G,billing=256
   AllocTRES=cpu=253,mem=636548M
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
```

### sinfo

The command ``sinfo`` gives you information about the partitions/queues.

**Example**:

This is for Tetralith, NSC

```bash
[x_birbr@tetralith3 ~]$ sinfo
PARTITION  AVAIL  TIMELIMIT  NODES  STATE NODELIST
tetralith*    up 7-00:00:00      1   plnd n1541
tetralith*    up 7-00:00:00     16 drain* n[237,245,439,532,625,646,712,759-760,809,1290,1364,1455,1638,1847,1864]
tetralith*    up 7-00:00:00      3  drain n[13,66,454]
tetralith*    up 7-00:00:00     20   resv n[1-4,108,774,777,779-780,784-785,788,1109,1268,1281-1285,1288]
tetralith*    up 7-00:00:00    327    mix n[7,39-40,46,50,69-70,75,78,85,91-93,97,112,119,121,124,126,128,130-134,137,139,141,149-150,156,159,164,167-168,170,174,184,187-188,190,193,196,203,206,208,212,231,241,244,257,259,262,267,280,287,293-294,310,315,323,327,329,333,340,350,352,371,377,379-381,385,405,420-422,434,441,446,465,467,501,504-505,514,524,529,549,553,558,561,564,573,575,602,610,612,615,617,622-623,626-627,631,637,651,662,671,678,691-692,699,703,709,718,720,723,726,741,745,752,754-755,768,776,781,790,792-793,803-804,808,818,853,855,859,863,867,881,883,915,925,959,966,974,981,984,999,1001-1003,1007-1011,1015,1018,1033,1044-1046,1050-1052,1056-1058,1071,1077,1102,1105-1106,1111-1115,1117,1119,1130,1132,1134-1136,1138-1140,1142-1143,1252,1254,1257,1267,1278-1279,1292,1296,1298,1309,1328,1339,1343,1345,1347,1349,1352,1354-1355,1357,1367,1375-1376,1379,1381,1386-1388,1398,1403,1410,1412,1420-1422,1428,1440,1446,1450,1459,1466,1468-1470,1474,1490-1491,1493,1498,1506,1510,1513,1520,1524,1529,1548-1549,1553,1562,1574-1575,1579,1586,1592,1595,1601,1606,1608,1612,1615,1620-1621,1631,1634,1639,1642,1647,1651-1653,1665,1688,1690,1697,1702,1706,1715-1716,1725,1728,1749,1754,1756,1767,1772,1774-1775,1778,1795-1796,1798-1799,1811,1816,1822,1826,1834,1842,1849,1857-1858,1871,1874,1879,1881,1896,1900,1902,1909,1911-1914,1945,1951,1953,1955-1956,1960,1969,1978,1983,2001,2005-2006,2008]
tetralith*    up 7-00:00:00   1529  alloc n[5-6,8-12,14-38,41-45,47-49,51-60,65,67-68,71-74,76-77,79-84,86-90,94-96,98-107,109-111,113-118,120,122-123,125,127,129,135-136,138,140,142-148,151-155,157-158,160-163,165-166,169,171-173,175-183,185-186,189,191-192,194-195,197-202,204-205,207,209-211,213-230,232-236,238-240,242-243,246-256,258,260-261,263-266,268-279,281-286,288-292,295-309,311-314,316-322,324-326,328,330-332,334-339,341-349,351,353-370,372-376,378,382-384,386-404,406-419,423-433,435-438,440,442-445,447-453,455-464,466,468-500,502-503,506-513,515-523,525-528,530-531,533-548,550-552,554-557,559-560,562-563,565-572,574,576-601,603-609,611,613-614,616,618-621,624,628-630,632-636,638-645,647-650,652-661,663-670,672-677,679-690,693-698,700-702,704-708,710-711,713-717,719,721-722,724-725,727-740,742-744,746-751,753,756-758,761-767,769-773,775,778,782-783,786-787,789,791,794-802,805-807,810-817,819-852,854,856-858,860-862,864-866,868-880,882,884-889,893,896-914,916-924,926-937,939-940,943,945,948-958,960-965,967-973,975-980,982-983,985-998,1000,1004-1006,1012-1014,1016-1017,1019-1032,1034-1043,1047-1049,1053-1055,1059-1070,1072-1076,1078-1101,1103-1104,1107-1108,1110,1116,1118,1120-1129,1131,1133,1137,1141,1144,1249-1251,1253,1255-1256,1258-1266,1269-1277,1280,1286-1287,1289,1291,1293-1295,1297,1299-1308,1310-1327,1329-1338,1340-1342,1344,1346,1348,1350-1351,1353,1356,1358-1363,1365-1366,1368-1374,1377-1378,1380,1382-1385,1389-1397,1399-1402,1404-1409,1411,1413-1419,1423-1427,1429-1439,1441-1445,1447-1449,1451-1454,1456-1458,1460-1465,1467,1471-1473,1475-1489,1492,1494-1497,1499-1505,1507-1509,1511-1512,1514-1519,1521-1523,1525-1528,1530-1540,1542-1547,1550-1552,1554-1561,1563-1573,1576-1578,1580-1585,1587-1591,1593-1594,1596-1600,1602-1605,1607,1609-1611,1613-1614,1616-1619,1622-1630,1632-1633,1635-1637,1640-1641,1643-1646,1648-1650,1654-1664,1666-1687,1689,1691-1696,1698-1701,1703-1705,1707-1714,1717-1724,1726-1727,1729-1748,1750-1753,1755,1757-1766,1768-1771,1773,1776-1777,1779-1794,1797,1800-1810,1812-1815,1817-1821,1824-1825,1827-1833,1835-1841,1843-1846,1848,1850-1856,1859-1863,1865-1870,1872-1873,1875-1878,1880,1882-1895,1897-1899,1901,1903-1908,1910,1915-1944,1946-1950,1952,1954,1957-1959,1961-1968,1970-1977,1979-1982,1984-2000,2002-2004,2007,2009-2016]
```

As you can see, it shows partitions, nodes, and states. State can be drain, idle, resv, alloc, mix, plnd (and a few others), where the exact naming varies between centers.

- **drain**: node is draining after running a job
- **resv**: node is reserved/has a reservation for something
- **alloc**: node is allocated for a job
- **mix**: node is in several states, could for instance be that it is allocated, but starting to drain
- **idle**: node is free and can be allocated
- **plnd**: job planned for a higher priority job

You can see the full list of states and their meaning with ``man sinfo``.

!!! hint

    Try it! Give the command ``sinfo`` and look at the output from your chosen HPC centre. 

## Slurm job scripts

Now we have looked at the commands to control the job, but what about the job scripts? 

We had a small example further up on the page, which we used to test the commands, but now we will look more at the job scripts themselves. 

### Simplest job 

The simplest possible batch script would look something like this:

=== "Other" 

    This works for most of the centres, except Dardel which also requires you to give the partition. 

    ```bash
    #!/bin/bash
    #SBATCH -A <proj-id>    ###replace with your project ID
    #SBATCH -t 00:05:00
    #SBATCH -n 1

    echo $HOSTNAME
    ```

=== "Dardel" 

    Dardel requires you to give the partition. There are several: "main", "shared", "long", "memory", "gpu". In most cases when you are running a regular CPU job on less than all cores on a node, you should use "shared". 

    ```bash
    #!/bin/bash
    #SBATCH -A <proj-id>    ###replace with your project ID
    #SBATCH -t 00:05:00
    #SBATCH -n 1
    #SBATCH -p shared 

    echo $HOSTNAME
    ```

!!! note

    A job submission file can either be very simple, with most of the job attributes specified on the command line, or it may consist of several Slurm directives, comments and executable statements. 

    A Slurm directive provides a way of specifying job attributes in addition to the command line options. All Slurm directives are prefaced with `#SBATCH` which *must* be written with capital letters. 

    Comments are added with a `#` in front - an extra `#` in front of the Slurm directive comment that out. 

!!! note "Common Slurm arguments" 

    Some of the most commonly used arguments are:

    - `-A PROJ-ID`: The project that should be accounted. It is a simple conversion from the SUPR project id. You can also find your project account with the command projinfo. The PROJ-ID argument is of the form **naissXXXX-YY-ZZZ** 
    - `-N`: number of nodes
    - `-n`, `--ntasks=`: number of tasks. Since cores-per-task is 1 as default, this then translates to number of cores. 
    - `-t`, `--time=`: walltime. How long your job is allowed to run. Given as HHH:MM:SS (example: 4 hours and 20 min is given as 4:20:00). Different centres have different maximum walltime, but it is usually at least a week. 
    - `-p`: partition. Only used at some centres. Dardel is one of them. 
    - `-c`, `--cores-per-task=`: This changes the number of cores each task may use. Can also be used for getting more memory, with some cores only providing memory. (example: **-c 2 -n 4** allocates 4 tasks and 2 cores per task, totally 8 cores). More about this argument later. 

    In addition, these can be quite useful: 

    - `-o`, `--output=``: Used for naming the output differently that ``slurm-<job-id>.out`` and splitting it from errors and such. The environment variable ``%j`` is very useful since adding it to the output name prevents it being overwritten next time you run the job. 
    - `-e`, `--error=`: Used for naming and splitting the error from the other output. Adding the environment variable ``%j``to the name is useful, like it is for the output file. 

    Example: 

    ```bash
    #SBATCH -o process_%j.out    
    #SBATCH -e process_%j.err    
    ``` 

**Now for the example script, "Simplest job", above**:

The first line is called the “shebang” and it indicates that the script is written in the bash shell language.

The second, third, and fourth lines are resource statements to the Slurm batch scheduler. Also called Slurm directives. 

The second line above is where you put your **project ID**. 
Depending on centre, this is either always required or not technically required if you only have one project to your name. Regardless, we recommend that you make a habit of including it. 

The third line in the example above provides the **walltime**, the maximum amount of time that the program would be allowed to run (5 minutes in this example). If a job does not finish within the specified walltime, the resource management system terminates it and any data that were not already written to a file before time ran out are lost.

The fourth line asks for compute resources, here one core (or rather one task, but cores-per-task is one as default). You could ask for more cores if it was a parallel job, or for GPUs and so on. More about that later.  

The last line in the above sample is the code to be executed by the batch script. In this case, it just prints the name of the server on which the code ran.

All of the parameters that Slurm needs to determine which resources to allocate, under whose account, and for how long, must be given as a series of resource statements of the form ``#SBATCH -<option> <value>`` or ``#SBATCH --<key-words>=<value>`` (note: `<` and `>` are not typically used in real arguments; they are just used here to indicate placeholder text). 

Depending on centre, for most compute nodes, unless otherwise specified, a batch script will run on 1 core of 1 node by default. However, at several centres it is required to always give the number of cores or nodes, so you should make it a habit to include it. 

!!! Note

    You find the above job script in the exercises tarball. It is named "first.sh". 

    Remember to change the project ID to your own! 

!!! note "Some comments on time/walltime"

    - the job **will** terminate when the time runs out, whether it has finished or not
    - you will only be "charged" for the consumed time
    - asking for a lot more time than needed will generally make the job take longer to start
    - short jobs can start quicker (backfill)
    - if you have no idea how long your job takes, ask for "long" time
    - **Conclusion**: It is typically a good idea to overbook your job with perhaps 30% (or more). 

!!! note

    There are many more resource statements and other commands that can go into the Slurm batch script. We will look at some of them in the next section, where we show some sample job scripts. 

You submit the job script with ``sbatch <jobscript.sh>`` as was mentioned earlier.

## Dependencies 

Sometimes your workflow has jobs that depend on a previous job (a pipeline). This can be handled through Slurm (if many, make a script):

- Submit your first job: ``sbatch my-job.sh``
- Wait for that job to finish before starting next job: ``sbatch -d afterok:<prev-JOBID> my-next-job.sh``

Generally: 

- **`after:jobid[:jobid...]`** begin after specified jobs have started
- **`afterany:jobid[:jobid...]`** begin after specified jobs have terminated
- **`afternotok:jobid[:jobid...]`** begin after specified jobs have failed
- **`afterok:jobid[:jobid...]`**  begin after specified jobs have run to completion with exit code zero
- **`singleton`** begin execution after all previously launched jobs with the same name and user have ended 

!!! hint

    **Try it!** You can use `matrix-gen.sh` as the first and `mmmult-v2.sh` as the dependent job. You find these batch scripts in the exercises tarball, under your cluster. 

    - Remember to change the project ID of the scripts to be your project ID. 
    - Remember, you can use `squeue --me` to see if your jobs are running - and probably also that one of them is now marked as being dependent on another. 

### Script example 

This simple script can be run from the command line. It starts one job; gets the job ID, then tell Slurm to wait until job one has finished before starting a second job which is dependent on the first.  

```bash
#!/bin/bash

# first job - no dependencies
jid1=$(sbatch --parsable matrix-gen.sh)

# Next job depend on first job 
sbatch --dependency=afterany:${jid1} mmmult-v2.sh
```

If you want to test it, the scripts for this can be found in <a href="https://github.com/UPPMAX/NAISS_Slurm/raw/refs/heads/main/exercises.tar.gz" target="_blank">the tarball with the exercises</a> under the cluster name and then "dependency". 

The first job it runs generates two matrices and then the second job does matrix-matrix multiplication, but not until the first has finished. 

## How to monitor jobs

Unless mentioned, these are valid at all centres. 

Use the following:

- `sacct`: `sacct -l -j JOBID`. Lots of (wide format) info about a job with job-id JOBID
- `job-info` (UPPMAX, LUNARC, C3SE): wrapper around `squeue`
- `scontrol show job JOBID`: info about a job, including estimated start time, assigned nodes, working directory, etc. 
- `squeue --me --start`: your running and queued jobs with estimated start time
- `job_usage` (HPC2N): grafana graphics of resource use for job (> few minutes)
- and several more 

See [Job monitoring and efficiency](../monitoring) for more about job info, including several commands that are site-specific and very useful. 

