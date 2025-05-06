# Sample job scripts

The simplest possible batch script would look something like this:

```bash
#!/bin/bash
#SBATCH -t 00:05:00

echo "hello"
```

The first line is called the "shebang" and it indicates that the script
is written in the bash shell language.

The second line provides the walltime, the maximum amount of time that the
program will be allowed to run, which is 5 minutes in this example. The given
example will finish in a fraction of a second, but if the it took more than
the 5 minutes specified, the resource manager would cut it off and any data not
already written to file would be lost.

The last line is the program to be executed by the script with the given resources.

All of the parameters that Slurm needs to determine which resources to allocate,
under whose account, and for how long, must be given as `#SBATCH` followed by the
flag for the name of the parameter, and then the value(s) of that parameter.


