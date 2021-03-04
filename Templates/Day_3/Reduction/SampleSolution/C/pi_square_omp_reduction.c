#include <stdio.h>
#ifdef _OPENMP
#include <omp.h>
#endif

int main()
{

  const int finval = 10000;

  double pi_square = 0.0;

#ifdef _OPENMP
  double start_time = omp_get_wtime();
#endif

#pragma omp parallel for default(none) reduction(+:pi_square)  
  for ( int i=1 ; i <= finval; i++)
    {  
      double factor = (double) i;
      pi_square += 1.0/( factor * factor );
    }
#ifdef _OPENMP
  double end_time = omp_get_wtime() - start_time;
#else
  double end_time = 0.0;
#endif

  printf ( "Pi^2 = %.10f\n", pi_square*6.0);
  printf ( "Time taken: %f s\n", end_time);

  return 0;

}
