CC = mpicc
CFLAGS = -O3 -march=native
FC = mpifort
FFLAGS = -O3 -march=native

objectsc = mpi_hello
objectsf =  integration2D_f90
all: $(objectsf) $(objectsc)


$(objectsf): %: %.f90
	        $(FC) $(FFLAGS) -o $@ $<

$(objectsc): %: %.c
		$(CC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_f90 *_hello
