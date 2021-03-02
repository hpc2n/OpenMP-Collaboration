
# Compiling the code

## GNU Compilers
ml purge    
module load foss/2020b
gfortran -fopenmp -o hello_exe hello.f90
export OMP_NUM_THREADS=4
./hello_exe

## Intel Compilers
ml purge
module load intel/2020a
ifort -qopenmp -O3 -xHost -o hello_exe  hello.f90
export OMP_NUM_THREADS=4
./hello_exe
