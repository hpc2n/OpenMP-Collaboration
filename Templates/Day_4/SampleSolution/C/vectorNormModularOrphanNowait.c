#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <math.h>

#include "vectorNormSizes.h"

void vectorInit(double* v, int leng);
double vectorNormSqr(double* v, int leng);

int main()
{

  printf("length: %i\n", vleng);
  double *vect; 
  double norm;

  double startTime, finTime;
  int numThreads;


  vect = malloc(vleng * sizeof(double));

  startTime = omp_get_wtime();

  // measure multiple times to stabilise results - cycles is defined in vectorNormSizes.h
  for (int iloop=0; iloop < cycles; iloop++)
    {      

      norm =0.0;

#pragma omp parallel default(none) shared(vect) reduction(+:norm)
      {
	vectorInit(vect, vleng);
	
	norm = vectorNormSqr(vect, vleng);
	
      }
      
      norm = sqrt(norm);

    }

  finTime = omp_get_wtime() - startTime;
  // normalise timing
  finTime = finTime/cycles;

  // print result
  printf("Norm: %f\n",norm);

  
  // query the number of threads
#pragma omp parallel default(none) shared(numThreads)
  {
#pragma omp master
    numThreads = omp_get_num_threads();
  }


  printf("Average time taken: %f ms on %i threads, averaged over %i cycles\n", 
	 finTime*1000.0, numThreads,cycles);
  return 0;

}



void vectorInit(double* v, int leng)
{

  // orphan directives
  // default static schedule is required in connection with the nowait statement
#pragma omp for schedule(static) nowait
  for (int i=0; i < leng; i++)
    v[i] = (double) i; 
  return;
}

double vectorNormSqr(double* v, int leng)
{
  double norm = 0.0;

  // orphan directives
  // default static schedule is required in connection with the nowait statement
#pragma omp for schedule(static) nowait
  for (int i=0; i < leng; i++)
    {
      norm += v[i] * v[i];
    }

  return norm;
}
