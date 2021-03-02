PROGRAM Parallel_Hello_World

  !$ USE OMP_LIB

  implicit none
  
  logical parallel_omp
  integer threadid, threadnum

  parallel_omp = .false.
  !$ parallel_omp = .true.
  
  !$OMP PARALLEL

  !$ threadid  = omp_get_num_threads()
  !$ threadnum = omp_get_thread_num()

  if (.not.parallel_omp) then
     threadid  = 0
     threadnum = 1
  endif
  
  PRINT *, "Hello, I am thread", threadid, " out of", threadnum 

  !$OMP END PARALLEL

END PROGRAM Parallel_Hello_World
