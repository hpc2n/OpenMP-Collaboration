#include <stdlib.h>
#include <stdio.h>
#include <math.h>


/* Remark: Make sure arry is larger than L3 */
#define VLENG  500000000


// switch for calloc instead of malloc
//#define USE_CALLOC

int main()
{

  double *a, *b, *c;

#ifdef USE_CALLOC
  printf("Using calloc to allocate the memory\n");
  a = calloc(VLENG, sizeof(double));
  b = calloc(VLENG, sizeof(double));
  c = calloc(VLENG, sizeof(double));
#else
  printf("Using malloc to allocate the memory\n");
  a = malloc(VLENG * sizeof(double));
  b = malloc(VLENG * sizeof(double));
  c = malloc(VLENG * sizeof(double));
#endif



  //initialisation 
  for (int i=0; i<VLENG; i++)
    {
      a[i] = 2.0 * (double)i;
      b[i] = 3.0 * (double)i;
      c[i] = (double)i;
    }

  for(int i=0; i<VLENG; i++)
    {
      c[i] = a[i] * b[i];
    }


  // Verification

  int pass=1;

  for(int i = 0; i<VLENG; i++)
    {
      double idb = (double)i;
      // compare relative difference
      double compare = (c[i] - 6.0 * idb * idb )/c[i];
      compare = fabs(compare);
      if ( compare > 1.0E-14)
	{
	  pass = 0;
	  printf("Fail: for i=%d we have c[i]: %f\n", i, c[i]);
	} // endif	
    }

  if ( pass ) 
    { printf("Test passed!\n");
    }
  else
    { printf("Test failed!!!\n");
    }

  free (a);
  free (b);
  free (c);

  return 0;
}
