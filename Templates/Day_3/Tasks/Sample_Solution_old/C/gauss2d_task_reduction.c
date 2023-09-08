#include <stdio.h>
#include <math.h>


#ifdef _OPENMP
   #include <omp.h>
#else
  double ctiming();
#endif

#define NSIZE 40000
#define BLOCKSIZE 100
#define STEPSIZE 0.0002

int main()
{

  double xpos, ypos;
  double integral=0.0;
  int numThreads;
  int numBlocks;

  if ( NSIZE % BLOCKSIZE != 0 )
    {
      printf("Problemsize NSIZE and blocksize BLOCKSIZE do not devide!!\n");
      return 1;
    }
  else
    {
      numBlocks = NSIZE/BLOCKSIZE ;
    }

#pragma omp parallel default(none) shared(numThreads)
  {
    #pragma omp master
    {
     #ifdef _OPENMP
      numThreads = omp_get_num_threads();
     #else
      numThreads = 1;
     #endif
    }
  }


#ifdef _OPENMP
  double starttime = omp_get_wtime();
#else
  double starttime = ctiming();
#endif


#pragma omp parallel default(none) shared(integral) private(xpos, ypos) shared(numBlocks)
  {
#pragma omp single
    {
#pragma omp taskgroup task_reduction(+: integral)
      {
	for ( int iblk = 0; iblk < numBlocks; iblk++)
	  {
#pragma omp task in_reduction(+: integral) firstprivate(iblk) private(xpos, ypos)	  
	    {
	      for ( int i = iblk * BLOCKSIZE; i < (iblk + 1) * BLOCKSIZE; i++ )
		{
		  xpos =(double) i * STEPSIZE;
		  for (int j = i ; j < NSIZE ; j++ )
		    {
		      ypos = (double) j * STEPSIZE;
		      double xvecSquare = xpos*xpos + ypos*ypos;
		      integral += exp(-xvecSquare) * STEPSIZE * STEPSIZE;
		    }  // end of j loop
		}  // end of i loop
	    }  // end of task
	  }    // end of iblk loop
      } // end task group
    }  // end single
  }    // end parallel
  integral *= 8.0;

#ifdef _OPENMP
  double finaltime = omp_get_wtime() - starttime;
#else
  double finaltime = ctiming() - starttime;
#endif

  printf("Approximate integral: %f for n: %i and stepsize: %f \n",
	 integral, NSIZE, STEPSIZE);

#ifdef _OPENMP  
  printf("Time taken: %f s on %i threads\n", finaltime, numThreads);
  printf("Parallelised starting %i tasks\n", numBlocks);
#else
  printf("Time taken: %f s for serial compile\n", finaltime);
#endif
  return 0;

}

#ifndef _OPENMP

#include <sys/time.h>



double ctiming()
{
        struct timeval tp;
        int i = gettimeofday(&tp, NULL );
        return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.0e-6 );

}


#endif
