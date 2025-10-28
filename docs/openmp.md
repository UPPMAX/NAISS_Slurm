# Shared memory

Shared memory is memory that can be accessed by several programs at the same
time, enabling them to communicate quickly and avoid redundant copies. Shared
memory generally refers to a block of RAM accessible by several cores in a
multi-core system. Computers with large amounts of shared memory and many cores
per node are well suited for threaded programs, using OpenMP or similar.

Computer clusters built up of many off-the-shelf computers usually have smaller
amounts of shared memory and fewer cores per node than custom-built single
supercomputers. This means they are more suited for programs using MPI than
OpenMP. However, the number of cores per node is going up and many-core chips
are now common. This means that OpenMP programs as well as programs combining
MPI and OpenMP are often advantageous.
§
