Program VectorNormModular

  use vectorNormSizes
  
  implicit none

  double precision, dimension(:), allocatable :: vect
  double precision :: norm

  integer :: iloop
  
  print *, "Length:", vleng

  allocate(vect(vleng))
  
  ! measure multiple times to stabilise timing results - ncycles is defined in vectorNormSizes.f90
  ! unccomment the loop when required
  ! do iloop = 1, ncycles

  call vectorInit(vect, vleng)
  norm = vectorNormSqr(vect,vleng)
  norm = sqrt(norm)
  ! enddo ! loop over iloop

  ! print result
  print *,"Norm::", norm
  
  deallocate(vect)

contains

  subroutine vectorInit(v, leng)
    integer, intent(in)  :: leng
    double precision, dimension(leng), intent(out) :: v

    integer i

    ! orphan directive
    ! default static schedule is required in connection with the nowait statement
    !$omp do schedule(static)
    do i=1, leng
       v(i) = dble(i)
    enddo
    !$omp end do nowait

  end subroutine vectorInit

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  function vectorNormSqr(v, leng)
    integer, intent(in) :: leng
    double precision, dimension(leng), intent(in) :: v
    double precision :: vectorNormSqr

    integer i

    vectorNormSqr = 0.0d0
    ! orphan directive
    ! default static schedule is required in connection with the nowait statement
    !$omp do schedule(static)
    do i=1, leng
       vectorNormSqr = VectorNormSqr + v(i) * v(i)
    enddo
    !$omp end do nowait

  end function vectorNormSqr
  
  
End Program VectorNormModular
  
