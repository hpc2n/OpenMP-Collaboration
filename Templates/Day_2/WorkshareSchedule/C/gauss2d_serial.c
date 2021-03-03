#include <stdio.h>
#include <math.h>

// parameters N and h
#define NSIZE 44800
#define STEPSIZE 0.0002

int main()
{

  double xpos, ypos;
  double integral=0.0;
  int numThreads;


  for ( int i = 0; i < NSIZE; i++)
    {
      xpos = (double) i * STEPSIZE;
      for (int j = i+1; j < NSIZE; j++ )
	{
	  ypos = (double) j * STEPSIZE;
	  double xvecSquare = xpos*xpos + ypos*ypos;
	  integral += exp(-xvecSquare) * STEPSIZE * STEPSIZE;
	}  // j-loop
    }  // i-loop
    
  integral *= 8.0;

  printf("Approximate integral: %f for n: %i and stepsize: %f \n",
	 integral, NSIZE, STEPSIZE);

  return 0;

}
