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

  // measure multiple times to stabilise results - cycles is defined in vectorNormSizes.h
  // uncomment the loop when required
  //for (int iloop=0; iloop < cycles; iloop++)
    {      

      norm =0.0;

      
      vectorInit(vect, vleng);	
      norm = vectorNormSqr(vect, vleng);	
      norm = sqrt(norm);
    }

  printf("Norm: %f\n",norm);

}



void vectorInit(double* v, int leng)
{
  for (int i=0; i < leng; i++)
    v[i] = (double) i; 
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
