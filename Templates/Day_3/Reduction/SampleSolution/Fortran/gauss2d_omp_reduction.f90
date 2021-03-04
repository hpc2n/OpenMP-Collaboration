Program gauss2d

  !$ use omp_lib
  
  implicit none

  ! parameters N and h
  integer, parameter :: nsize    = 44800
  double precision, parameter :: stepsize = 0.0002D0

  
  double precision :: xpos, ypos
  double precision :: integral
  integer :: numthreads

  logical :: parallel_omp

  ! summation indices
  integer :: i, j

  ! timing
  double precision :: start_time, stop_time
  
  ! logical variable to check OpenMP compilation
  parallel_omp = .false.
  !$ parallel_omp = .true.

  ! query the number of threads
  if ( parallel_omp ) then
     !$OMP parallel default(none) shared(numthreads)
     !$ if (omp_get_thread_num() .eq. 0) then
     !$    numThreads = omp_get_num_threads()     
     !$ endif
     !$OMP end parallel
  else
     numThreads = 1
  endif

  integral = 0.0D0
  
  ! start the timer
  !$ start_time = omp_get_wtime()

  ! parallel evalutation of the double sum, parallelise outer loop
  !$OMP parallel do default(none) reduction(+:integral) &
  !$OMP    private(xpos, ypos, i, j) schedule(static, 250)
  do i = 0, nsize-1
     xpos = i * stepsize
     do j = i+1, nsize-1
        ypos = j * stepsize
        integral = integral + &
             stepsize*stepsize*exp(-xpos*xpos - ypos*ypos)
     enddo  ! j-loop
  enddo     !i-loop
  !$OMP end parallel do

  integral = 8.0D0 * integral

  !$ stop_time = omp_get_wtime()

  print *, "Approximate integral:", integral, " for n:", nsize, " and stepsize:", stepsize 

  if(parallel_omp) then
     print *, "Time taken:", stop_time - start_time, "s on", numthreads
  else
     print *,"No timing for serial code implemented"
  endif
  
End program gauss2d
