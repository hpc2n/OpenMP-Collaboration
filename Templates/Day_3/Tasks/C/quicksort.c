#include <stdlib.h>
#include <stdio.h>
#include <math.h>




int partition(double* a, int n, int nstart, int nfin)
{
  // take the last element as pivot
  double pivot = a[nfin];

  //assume all elements are larger than pivot
  int temp = nstart-1;

  // check all elements that they are indeed larger than pivot
  for( int current= nstart; current< nfin; current++)
    {
      if(a[current] < pivot)
	{
	  // we have one more element smaller than pivot
	  temp++;
	  // put that element to the end of the low elements
	  double aux = a[current];
	  a[current] = a[temp];
	  a[temp] = aux;
	}
    }
  // put pivoting element between the lower and larger part
  int pivindex = temp + 1;
  double aux = a[nfin];
  a[nfin] = a[pivindex];
  a[pivindex] = aux;

  return pivindex;
}



void quicksort(double* a, int n, int nstart, int nfin)
{

  // partition the array
  //   elements before pindex are smaller than a(pindex)
  //   elements after pindex are larger than a(pindex)
  int pindex = partition(a, n, nstart, nfin);

  if (pindex > nstart+1)
    quicksort(a, n, nstart, pindex - 1);
  
  if (pindex < nfin-1)
    quicksort(a, n, pindex+1, nfin);
  

}   



void randomsetup(double* a, int ndim)
{

  // random intialisation of array using GSL lib

#include <gsl/gsl_rng.h>

  const gsl_rng_type * T;
  gsl_rng * r;
     
  gsl_rng_env_setup();
     
  T = gsl_rng_default;
  r = gsl_rng_alloc (T);

  for (int i = 0; i < ndim; i++) 
    a[i] = gsl_rng_uniform(r);
  
  gsl_rng_free (r);
}


void printa(double* a, int n)
{
  for (int i = 0 ; i <n; i++)
    {
      printf("%f ", a[i]);
    }
  printf("\n");
}

int checksorted(double* a, int n) 
{
  int testok = 1;
  for (int i; i<n-1; i++)
    {
      if(a[i] > a[i+1])
	{
	  printf("Problem at index = %i : %f > %f\n", i, a[i], a[i+1]);
	  testok = 0;
	}
    }
  return testok;
} 


int main(){

  int const ndim=20000000;
  
  double* a;
  a = malloc(ndim * sizeof(double));
  
  randomsetup(a, ndim);
	     
  //printa(a, ndim);

  quicksort(a, ndim, 0, ndim-1);

  //printa(a, ndim);
    
  int passed = checksorted(a, ndim);
  if (passed)
    {
      printf("Test passed!\n");
    }
  else
    {
      printf("Test failed !!!!\n");
    }

  free(a);

}


