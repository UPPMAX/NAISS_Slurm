# Batch system concepts

## What is a batch system?

A batch system provides a mechanism to submit programs (jobs) or groups of programs to be executed automatically.

### The Simplest Job

The simplest possible batch script would look something like this:

```bash
#!/bin/bash
#SBATCH -t 00:05:00

echo $HOSTNAME
```

1. The first line is the "shebang", which defines the scripting language for the rest of the code. This example shows how to specify that the scripting language is bash.

2. Lines of the form `#SBATCH -<option> <value>` or `#SBATCH --<key-words>=<value>` are **resource statements**\*. Option `-t` is for wall time, the maximum time that your code should be allowed to run. Most scripts require additional resource statements, but whether a particular resource setting has a default value, or what that value is, varies between HPC centers. (\**Note: `<` and `>` are only used here to indicate placeholder text*).

3. Everything after the resource statements is code to be executed. In the example above, ``echo $HOSTNAME`` prints the name of the node that the script was assigned to run on. 
