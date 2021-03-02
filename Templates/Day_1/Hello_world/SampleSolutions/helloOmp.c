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
	     threadid, threadnum, procnum);
#else
      printf("Hello from serial!\n");
#endif
    }
  
  return 0;
}
