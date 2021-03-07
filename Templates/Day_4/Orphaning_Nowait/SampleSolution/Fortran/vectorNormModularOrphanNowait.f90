Program VectorNormModular

  use vectorNormSizes
  use omp_lib
  
  implicit none

  double precision, dimension(*), allocatable :: vect
  double precision :: norm

  double precision :: startTime, endTime
  integer numThreads

  integer :: iloop
  
  print *, "Length:" vleng

  allocate(vect(vleng))

  startTime = omp_get_wtime();
  
  ! measure multiple times to stabilise results - ncycles is defined in vectorNormSizes.f90
  do iloop = 1, ncycles

     !$omp parallel default(none) shared(vect) reduction(+:norm)
     call vectorInit(vect, vleng)
     norm = vectorNormSqr(vect,vleng)
     !$omp end parallel

     norm = sqrt(norm)
  enddo ! loop over iloop

  endTime = omp_get_wtime() - startTime
  ! normalise timing
  endTime = enTime/ncycles

  ! print result
  print *,"Norm::", norm
  
  deallocate(vect)

  !$omp parallel default(none) shared(numThreads)
  !$omp master
  numThreads = omp_get_num_threads()
  !$omp end master
  !$omp end parallel

  print *, "Average time taken:" endTime*1000.0D0, " ms on", numThreads, &
       "averaged over", ncycles, " cycles"

contains

  subroutine vectorInit(v, leng)
    integer, intent(in)  :: leng
    double precision, intent(out) :: v

    integer i

    ! orphan directive
    ! default static schedule is required in connection with the nowait statement
    !$omp do schedule(static) nowait
    do i=1, leng
       v(i) = dble(i)
    enddo

  end subroutine vectorInit

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  function vectorNormSqr(v, leng)
    integer, intent(in) :: leng
    double precision, intent(in) :: v
    double precision :: vectorNormSqr

    integer i

    vectorNormSqr = 0.0d0
    ! orphan directive
    ! default static schedule is required in connection with the nowait statement
    !$ omp do schedule(static) nowait
    do i=1, leng
       vectorNormSqr = VectorNormSqr + v(i) * v(i)
    enddo

  end function vectorNormSqr
  
  
End Program VectorNormModular
  
