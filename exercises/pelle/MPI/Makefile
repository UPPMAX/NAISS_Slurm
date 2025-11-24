CC = mpicc
CFLAGS = -O3 -march=native
FC = mpifort
FFLAGS = -O3 -march=native

objectsc = mpi_hello_c
objectsf =  integration2D_f90 mpi_hello
all: $(objectsf) $(objectsc)


$(objectsf): %: %.f90
	        $(FC) $(FFLAGS) -o $@ $<

$(objectsc): %: %.c
		$(CC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm mpi_hello_c mpi_hello *_f90
