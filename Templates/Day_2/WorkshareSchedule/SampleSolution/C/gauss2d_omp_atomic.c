#include <stdio.h>
#include <omp.h>
#include <math.h>

#define NSIZE 40000
#define STEPSIZE 0.0002

int main()
{

  double xpos, ypos;
  double integral=0.0;
  double local_int;
  int numThreads;

  // Query the number of threads
#ifdef _OPENMP
#pragma omp parallel default(none) shared(numThreads)
  {
    #pragma omp master
    {
      numThreads = omp_get_num_threads();
    }
  }
#else
  numThreads = 1;
#endif


  // start the time
#ifdef _OPENMP
  double starttime = omp_get_wtime();
#endif

  // parallel evaluation of the double sum, parallelise outer loop
#pragma omp parallel default(none)              \
  private(xpos, ypos, local_int) shared(integral} schedule(dynamic,1000) 
  {
    local_int = 0.0;
#pragma omp for
    for ( int i = 0; i < NSIZE; i++)
      {

	xpos = (double) i * STEPSIZE;
	for (int j = i+1; j < NSIZE; j++ )
	  {
	    ypos = (double) j * STEPSIZE;
	    double xvecSquare = xpos*xpos + ypos*ypos;
	    local_int += exp(-xvecSquare) * STEPSIZE * STEPSIZE;
	  }  // j-loop
      }  // i-loop
    
#pragma omp atomic update
    integral += local_int;
    
  }  // parallel region
  
  integral *= 8.0;

#ifdef _OPENMP
  double finaltime = omp_get_wtime() - starttime;
#endif
  printf("Approximate integral: %f for n: %i and stepsize: %f \n",
	 integral, NSIZE, STEPSIZE);
#ifdef _OPENMP
  printf("Time taken: %f s on %i threads\n", finaltime, numThreads);
#else
  printf("No timing for serial code\n");
#endif

  return 0;

}
