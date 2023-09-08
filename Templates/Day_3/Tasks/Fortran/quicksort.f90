Program qsort

  use qsort_utils

  implicit none

  ! the work array
  double precision, dimension(:), allocatable ::  a

  integer, parameter :: ndim=20000000
  logical :: passed

  allocate(a(ndim))

  call randomsetup(a,ndim)
  
  !print *, a

  call quicksort(a, ndim, 1, ndim)
  
  !print *, a

  passed = checksorted(a, ndim)

  if (passed) then
     print *, "test passed"
  else 
     print *, "test failed"
  endif

  deallocate(a)
  
contains
  
  function checksorted(a, n)
    logical :: checksorted
    integer, intent(in) :: n
    double precision, intent(in), dimension(n) :: a

    integer :: index

    checksorted = .true.

    Do index = 1, n-1
       if(a(index) .gt. a(index+1)) then
          print *, "Problem at index =", index, a(index), a(index+1)
          checksorted = .false.
       endif
    enddo
  end function checksorted

  subroutine randomsetup(a,n)
    integer, intent(in) :: n
    double precision, intent(inout), dimension(n) :: a
    
    integer :: seedsize
    integer, dimension(:), allocatable :: seed
    call random_seed(size = seedsize)
    allocate(seed(seedsize))
    seed = 3
    call random_seed(put = seed)
    
    call random_number(a)

    deallocate (seed)
  end subroutine randomsetup


End Program qsort
