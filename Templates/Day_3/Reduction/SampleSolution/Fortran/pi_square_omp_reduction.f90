Program pi

  !$ use omp_lib
  
  implicit none

  integer, parameter :: finval = 10000
  
  double precision :: pi_square = 0.0d0

  ! timing
  !$ double precision start_time, end_time
  
  
  double precision :: factor
  integer:: i

  !$ start_time = omp_get_wtime()

  !$omp parallel do reduction(+:pi_square) private(factor)
  do i= 1, finval
     factor = i
     pi_square = pi_square + 1.0d0/(factor * factor)
  enddo
  !$omp end parallel do

  !$ end_time = omp_get_wtime() - start_time
  
  print *, 'Pi**2 =', 6.0d0 * pi_square
  !$ print *, 'Time taken: ', end_time
  
end Program pi
