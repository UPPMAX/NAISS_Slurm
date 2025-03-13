# The different parts of the batch system

The batch system is made up of several different types of resources. At
the top we have partitions, which are similar to queues. Each partition
is made up of a specific set of nodes. At HPC2N we have three classes of
partitions, one for CPU-only nodes, one for GPU nodes and one for large
memory nodes. Each node type also has a set of features that can be used
to select which node(s) the job should run on.

The three types of nodes also have corresponding resources one must
apply for in SUPR to be able to use them.

## Partitions

There is only a single partition, <code>batch</code>, that users can
submit jobs to. The system then figures out, based on requested features
which actual partition(s) the job should be sent to.

(**Kebnekaise** has multiple partitions, one for each major type of resource.)

The command to ask for a specific partition in your Slurm submit script is: 

```bash
#SBATCH -p PARTITION
```

where PARTITION is the name of the partition. If no partition is
requested, the default, <code>batch</code> will be used.

Information about the Slurm nodes and partitions can be found using this
command:

```bash
$ sinfo
```

Unless otherwise specified the system will allocate resources on the
first available node(s) that the job can run on. It will try to use as
few resources as possible, i.e. use nodes with less memory per core
before nodes with more memory etc.

## Nodes

**Kebnekaise** have CPU-only, GPU enabled and large memory nodes.

### The CPU-only nodes are:

- 2 x 14 core Intel skylake
    - 6785 MB memory / core
    - 48 nodes
- 2 x 64 core AMD zen3
    - 8020 MB / core
    - 1 node
- 2 x 128 core AMD zen4
    - 2516 MB / core
    - 8 nodes

[To request node(s) with a specific type of CPU use the available features](#for__selecting__type__of__cpu)

### The GPU enabled nodes are:

- 2 x 14 core Intel skylake
    - 6785 MB memory / core
    - 2 x Nvidia V100
    - 10 nodes
- 2 x 24 core AMD zen3
    - 10600 MB / core
    - 2 x Nvidia A100
    - 2 nodes
- 2 x 24 core AMD zen3
    - 10600 MB / core
    - 2 x AMD MI100
    - 1 node
- 2 x 24 core AMD zen4
    - 6630 MB / core
    - 2 x Nvidia A6000
    - 1 node
- 2 x 24 core AMD zen4
    - 6630 MB / core
    - 2 x Nvidia L40s
    - 10 nodes
- 2 x 48 core AMD zen4
    - 6630 MB / core
    - 4 x Nvidia H100 SXM5
    - 2 nodes

See the next section regarding requesting GPUs.

### The large memory nodes are:

- 4 x 18 core Intel broadwell
    - 41666 MB memory / core
    - 8 nodes

## Requesting GPUs

To use GPU resources one has to explicitly ask for one or more GPUs.
Requests for GPUs can be done either in total for the job or per node of
the job.

```bash
#SBATCH --gpus=1
```
or
```bash
#SBATCH --gpus-per-node=1
```

One can ask for a specific GPU type by using
```bash
#SBATCH --gpus=l40s:1
```
or any of the other versions.

[To request node(s) with a specific type of GPU use the available features](#for__selecting__type__of__gpu)
or [the generic GPU features](#for__selecting__gpus__with__certain__features).

## Requesting specific features (i.e. setting contraints on the job)

To make it possible to target nodes in more detail there are a couple of features defined on each group of nodes. To select a feature one can use the <code>-C</code> option to <code>sbatch</code> or <code>salloc</code>

I.e. to constrain the job to nodes with the <code>zen4</code> feature use:
```bash
#SBATCH -C zen4
```

Features can be combined using "and" or "or" like this:
```bash
#SBATCH -C 'zen4&GPU_AI'
```
for a node with a zen4 CPU and a GPU with AI features, or
```bash
#SBATCH -C 'zen3|zen4'
```
to make sure the job runs on either a zen3 or a zen4 cpu.

We have at least the following features defined depending on type of node.

### For selecting type of CPU:

- intel_cpu
- broadwell
- skylake
- amd_cpu
- zen3
- zen4

### For selecting type of GPU:

- v100
- a40
- a6000
- a100
- l40s
- h100
- mi100

The above list can be used either as a specifier to
<code>--gpu=type:number</code> or as a constraint together with an
unspecified gpu request <code>--gpu=number</code>

### For selecting GPUs with certain features:

- nvidia_gpu (Any Nvidia GPU)
- amd_gpu (Any AMD GPU)
- GPU_SP (GPU with single precision capability)
- GPU_DP (GPU with double precision capability)
- GPU_AI (GPU with AI features, like half precisions and lower)
- GPU_ML (GPU with ML features, like half precisions and lower)


### For selecting large memory nodes:

- largemem

## Useful environment variables in a job

These are a few of the important and most useful environment variables available in a job.

- **SLURM_JOB_NUM_NODES**: the number of nodes you got.
- **SLURM_NTASKS**: contains the number of task slots allocated. Note that this is only set if one of the <code>--ntasks</code> options was used.
- **SLURM_CPUS_PER_TASK**: the number of cores allocated per task. Note that this is only set if the <code>-c</code> option was used.
- **SLURM_CPUS_ON_NODE**: the total number of cores allocated on the node for the job.
- **SLURM_JOB_ID**: contains the id of the current job.

