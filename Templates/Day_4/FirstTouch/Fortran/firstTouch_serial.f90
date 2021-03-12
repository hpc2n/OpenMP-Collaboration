Program firstTouch_lab

  implicit none

  integer, parameter :: vleng = 500000000

  ! data structures
  double precision, dimension(:), allocatable :: a, b, c

  ! verification variables
  logical :: pass
  double precision :: compare
  
  ! indices
  integer i
  double precision :: idbl
  
  allocate(a(vleng))
  allocate(b(vleng))
  allocate(c(vleng))

  do i= 1, vleng
     idbl = dble(i)
     a(i) = 2.0D0 * idbl
     b(i) = 3.0D0 * idbl
     c(i) =         idbl
  enddo

  do i=1, vleng
     c(i) = a(i) * b(i)
  enddo

  print *, "Size:", vleng

  ! verification
  pass = .true.

  do i=1, vleng
     idbl = dble(i)
     compare = (c(i) - 6.0d0 * idbl *idbl)/c(i)
     compare = dabs(compare)
     if ( compare .gt. 1.0D-14 ) then
        pass = .false.
        print *, "Fail for i=", i, " we have c(i)=", c(i)
     endif
  enddo


  if ( pass) then
     print *, "Verification: passed!"
  else
     print *, "Verification: failed!!!!"
  endif

  deallocate(a)
  deallocate(b)
  deallocate(c)

End program firstTouch_lab
