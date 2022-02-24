#include <stdio.h>
#include <stdlib.h>
#include "trig_taylor.h"

int main()
{

  const int nsize = 8192;

  double* x = aligned_alloc(64, nsize* sizeof *x);
  double* y = aligned_alloc(64, nsize* sizeof *x);

  for (int i=0; i<nsize; i++)
    x[i] = 0.001 * (double)i;

  // calculate the sin
  for (int i=0; i<nsize; i++)
    y[i] = sin_taylor(x[i]);

  // write the result
  FILE * fp;
  fp = fopen("sin_result.out", "w");
  for(int i=0; i<nsize; i++)
    fprintf(fp, "%8.4f %12.9f\n", x[i], y[i]);
  fclose;

  printf("Finished calculation for %d elements\n", nsize);

  free(x);
  free(y);
  return 0;

}
