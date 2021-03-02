#include <stdio.h>
#ifdef _OPENMP
#include <omp.h>
#endif

int main()
{

#pragma omp parallel
    {
      int threadid, threadnum, procnum;
      
#ifdef _OPENMP
      printf("Hello, I am thread %i of %i\n", 
	     omp_get_thread_num(), omp_get_num_threads());
#else
      printf("Hello from serial!\n");
#endif
    }
  
  return 0;
}
