# An introduction to shared memory parallel programming using OpenMP

This online course is given in cooperation between HPC2N and LUNARC.

OpenMP provides an efficient method to write parallel programs in C, C++ and Fortran.  OpenMP programs are suitable for execution on shared memory architectures such as modern multi core systems or a single compute node of the HPC clusters deployed by Lunarc and within SNIC.

This course will introduce participants to the shared-memory model for parallel programming and the OpenMP application-programming interface.  In many cases OpenMP allows an existing serial program to be upgraded incrementally, starting with the parallelisation of the most time-consuming parts of the code.  Typically OpenMP programs are easily ported from one shared memory multi processor system to another one.

The course consists of lectures alternating with practical sessions.  The teaching language will be English.  No prior experience in parallel computing is required.  Participants are however expected to be able to write serial programs in C, C++ or Fortran.  The course contents includes:

* Shared memory programming concepts
* Syntax of the OpenMP API
* Parallel and serial regions
* Shared and private data
* Workshare constructs and scheduling
* Reductions
* Avoiding data access conflicts and race conditions
* Performance considerations for non-uniform memory access hardware (e.g. nodes of SNIC HPC clusters)

At the end of the course participants should have the ability to parallelise many of the computational kernels used in scientific codes.

## Instructors: 

- Joachim Hein (LUNARC), Pedro Ojeda-May (HPC2N)

## Useful material:

- Linux introductory course at HPC2N on Youtube: https://www.youtube.com/watch?v=2AVZVJ3HkPs&t=1894s

