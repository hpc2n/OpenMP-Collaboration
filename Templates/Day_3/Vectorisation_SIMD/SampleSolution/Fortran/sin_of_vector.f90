Program sin_of_vector

  use trig_taylor
  !$ use omp_lib

  implicit none

  integer, parameter :: nsize = 8192
  double precision, dimension(nsize) :: x, y
  
  integer :: index
  double precision :: start_time, end_time


  ! intialise the vector
  Do index = 1, nsize
     x(index) = 0.001D0 * dble(index)
  end do

  !$ start_time = omp_get_wtime()

  ! calculate the sin
  !$omp simd
  Do index = 1, nsize
     y(index) = sin_taylor(x(index)) 
  end do

  !$ end_time = omp_get_wtime()  
  
  ! write the result
  open(11,file="sin_vector.out")
  do index = 1, nsize
     write(11,*) x(index), y(index)
  end do
  close(11);

  print *, "Calculation finished"
  !$ print *, "Calculation for n=", nsize, " took", &
  !$     end_time - start_time, " seconds"

End program sin_of_vector
