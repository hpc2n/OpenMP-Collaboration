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
      threadid  = omp_get_thread_num();
      threadnum = omp_get_num_threads();
      procnum   = omp_get_num_procs();
#else
      threadnum = 1;
      threadid = 0;
#endif
      
      
      printf("Hello, I am thread %i of %i - we have %i procs\n", 
	     threadid, threadnum, procnum);
      
    }
  
  return 0;
}
