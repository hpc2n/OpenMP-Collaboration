Program firstTouch_lab

  use omp_lib
  implicit none

  integer, parameter :: vleng = 500000000

  ! data structures
  double precision, dimension(:), allocatable :: a, b, c

  ! verification variables
  logical :: pass
  double precision :: compare
  
  ! OpenMP related and measurement
  integer num_threads
  double precision :: start_time, init_time, calc_time, check_time

  ! indices
  integer i
  double precision :: idbl
  
  allocate(a(vleng))
  allocate(b(vleng))
  allocate(c(vleng))

  !$omp parallel default(none) shared(num_threads)
  !$omp master
  num_threads = omp_get_num_threads()
  !$omp end master
  !$omp end parallel

  start_time = omp_get_wtime()
  !$omp parallel do default(none) shared(a, b, c) schedule(static)
  do i= 1, vleng
     idbl = dble(i)
     a(i) = 2.0D0 * idbl
     b(1) = 3.0D0 * idbl
     c(i) =         idbl
  enddo

  init_time = omp_get_wtime() - start_time

  start_time = omp_get_wtime()
  
  !$omp parallel do default(none) shared(a, b, c) schedule(static)
  do i=1, vleng
     c(i) = a(i) * b(i)
  enddo

  calc_time = omp_get_wtime() - start_time

  print *, "Initialisation time:", init_time
  print *, "Size:", vleng, " Threads:", num_threads, " Calculation time:", calc_time

  !Verification time
  pass = .true.

  start_time = omp_get_wtime()

  !$omp parallel do default(none) shared(c) reduction( .and. : pass) schedule(static)
  do i=1, vleng
     idbl = dble(i)
     compare = (c(i) - 6.0d0 * idbl *idbl)/c(i)
     compare = dabs(compare)
     if ( compare .lt. 1.0D-14 ) then
        pass = .false.
        print *, "Fail for i=", i, " we have c(i)=", c(i)
     endif
  enddo

  check_time = omp_get_wtime() - start_time

  if ( pass) then
     print *, "Verification: passed!"
  else
     print *, "Verification: failed!!!!"
  endif

  print *, "Time for verification:", check_time

  deallocate(a)
  deallocate(b)
  deallocate(c)

End program firstTouch_lab
