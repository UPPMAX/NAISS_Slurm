# Sample job scripts

The simplest possible batch script would look something like this:
```
#!/bin/bash
#SBATCH -t 00:05:00

echo "hello"
```
The first line is called the "shebang" and it indicates that the script is written in the bash shell language.
