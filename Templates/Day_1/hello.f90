PROGRAM Parallel_Hello_World
USE OMP_LIB

!$OMP PARALLEL

PRINT *, "Thread ID: ", OMP_GET_THREAD_NUM(), " says Hello World"

!$OMP END PARALLEL

END
