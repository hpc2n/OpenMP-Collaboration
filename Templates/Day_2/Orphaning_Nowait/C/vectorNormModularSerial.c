#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "vectorNormSizes.h"

void vectorInit(double* v, int leng);
double vectorNormSqr(double* v, int leng);

int main()
{

  printf("length: %i\n", vleng);
  double *vect; 
  double norm;

  vect = malloc(vleng * sizeof(double));

  // measure multiple times to stabilise timing results - cycles is defined in vectorNormSizes.h
  // uncomment the loop when required
  //for (int iloop=0; iloop < cycles; iloop++)
    {      
      
      vectorInit(vect, vleng);	
      norm = vectorNormSqr(vect, vleng);	
      norm = sqrt(norm);
    }

  printf("Norm: %f\n",norm);

  free(vect);
  
}



void vectorInit(double* v, int leng)
{
  for (int i=0; i < leng; i++)
    v[i] = (double) (i+1); 
  return;
}

double vectorNormSqr(double* v, int leng)
{
  double norm = 0.0;
  for (int i=0; i < leng; i++)
    {
      norm += v[i] * v[i];
    }

  return norm;
}
