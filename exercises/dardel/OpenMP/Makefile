CC = cc
FC = ftn

CFLAGS = -ffp=3 -fopenmp
FFLAGS = -O3 -homp

objectsc = omp_hello
objectsf =  gauss2d_omp_atomic
all: $(objectsf) $(objectsc)


$(objectsf): %: %.f90
	        $(FC) $(FFLAGS) -o $@ $<

$(objectsc): %: %.c
		$(CC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_atomic *_hello
