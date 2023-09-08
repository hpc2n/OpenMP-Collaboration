Module qsort_utils

  implicit none
  
contains

  recursive subroutine quicksort(a, n, nstart, nfin)
    ! pick a pivot element and sort the array a of size n for 
    ! elements larger and smaller then n

    integer, intent(in) :: n
    double precision, dimension(n), intent(inout) :: a
    ! start and final index for sorting
    integer, intent(in) :: nstart, nfin

    ! index of the pivot
    integer :: pindex

    ! we partition the array:
    !  elements before pindex are smaller than a(pindex) 
    !  elements after pindex are larger than a(pindex)
    pindex = partition(a, n, nstart, nfin)
    
    if (pindex .gt. nstart+1) then
       call quicksort(a, n, nstart, pindex-1)
    endif

    if (pindex .lt. nfin-1) then
       call quicksort(a, n, pindex+1, nfin)
    end if

  end subroutine quicksort

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  function  partition(a, n, nstart, nfin)
    ! pick last element as pivot and sort the array a of size n for 
    ! elements larger and smaller then n

    integer :: partition

    integer, intent(in) :: n
    double precision, dimension(n), intent(inout) :: a
    ! start and final index for sorting
    integer, intent(in) :: nstart, nfin

    integer:: temp, current
    double precision :: aux

    double precision :: pivot

    ! select the kast element privot in the middle of the interval
    pivot = a(nfin)

    ! assume all elements are larger than pivot
    temp = nstart - 1

    ! check all elements that they are indeed larger than pivot
    do current = nstart, nfin-1
       !! check
       if ( a(current) .lt. pivot) then
          ! we have one more element small than pivot
          temp = temp + 1
          ! put that to the end of the low elements
          aux = a(current)
          a(current) = a(temp)
          a(temp) = aux
       endif
    end do

    ! put pivoting element between he lower and larger part
    partition = temp + 1
    aux = a(nfin)
    a(nfin) = a(partition)
    a(partition) = aux
  end function partition

  

End Module qsort_utils
