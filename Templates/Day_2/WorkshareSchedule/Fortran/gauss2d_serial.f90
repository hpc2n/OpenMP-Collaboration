Program gauss2d

  implicit none

  ! parameters N and h
  integer, parameter :: nsize    = 44800
  double precision, parameter :: stepsize = 0.0002D0

  
  double precision :: xpos, ypos
  double precision :: integral

  ! summation indices
  integer :: i, j

  integral = 0.0D0
  
  do i = 0, nsize-1
     xpos = i * stepsize
     do j = i+1, nsize-1
        ypos = j * stepsize
        integral = integral + &
             stepsize*stepsize*exp(-xpos*xpos - ypos*ypos)
     enddo  ! j-loop
  enddo     !i-loop
  
  integral = 8.0D0 * integral

  print *, "Approximate integral:", integral, " for n:", nsize, " and stepsize:", stepsize 

End program gauss2d
