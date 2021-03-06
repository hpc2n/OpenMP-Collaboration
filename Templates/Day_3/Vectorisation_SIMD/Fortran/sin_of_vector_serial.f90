Program sin_of_vector

  use trig_taylor

  implicit none

  integer, parameter :: nsize = 8192
  double precision, dimension(nsize) :: x, y
  
  integer :: index


  ! intialise the vector
  Do index = 1, nsize
     x(index) = 0.001D0 * dble(index)
  end do

  ! calculate the sin
  Do index = 1, nsize
     y(index) = sin_taylor(x(index)) 
  end do

  ! write the result
  open(11,file="sin_vector.out")
  do index = 1, nsize
     write(11,*) x(index), y(index)
  end do
  close(11);

  print *, "Calculation finished for", nsize, " elements"

End program sin_of_vector
