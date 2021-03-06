#include <stdio.h>
#include <stdlib.h>
#include "trig_taylor.h"
#include <omp.h>

int main()
{

  const int nsize = 8192;

  double* x = aligned_alloc(64, nsize* sizeof *x);
  double* y = aligned_alloc(64, nsize* sizeof *x);

  for (int i=0; i<nsize; i++)
    x[i] = 0.001 * (double)i;

#ifdef _OPENMP
  double start_time = omp_get_wtime();
#endif

  // calculate the sin
#pragma omp simd
  for (int i=0; i<nsize; i++)
    y[i] = sin_taylor(x[i]);

#ifdef _OPENMP
  double end_time = omp_get_wtime();
#endif

  // write the result
  FILE * fp;
  fp = fopen("sin_result.out", "w");
  for(int i=0; i<nsize; i++)
    fprintf(fp, "%8.4f %12.9f\n", x[i], y[i]);
  fclose;

#ifdef _OPENMP
  printf("Calculation for n= %d took %f10 seconds\n", nsize, end_time-start_time);
#endif

  free(x);
  free(y);
  return 0;

}
