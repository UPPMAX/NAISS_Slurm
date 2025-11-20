FC = ftn
FFLAGS = -O3

objectsf =  integration2D_f90 mpi_hello
all: $(objectsf) $(objectsc)


$(objectsf): %: %.f90
	        $(FC) $(FFLAGS) -o $@ $<

$(objectsc): %: %.c
		$(CC) $(CFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_f90 *_hello
