PROGRAM Parallel_Hello_World

  !$ USE OMP_LIB

  implicit none
  
  logical parallel_omp

  parallel_omp = .false.
  !$ parallel_omp = .true.
  
  !$OMP PARALLEL
  
  !$ PRINT *, "Hello, I am thread", omp_get_thread_num(), " out of", omp_get_num_threads()

  !$OMP END PARALLEL

  if (.not.parallel_omp) then
     PRINT *,"Hello from serial!"
  endif
  
END PROGRAM Parallel_Hello_World
