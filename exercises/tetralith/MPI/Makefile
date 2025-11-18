FC = mpifort
FFLAGS = -O3 -march=native

objectsf =  integration2D_f90
allf: $(objectsf)

$(objectsf): %: %.f90
	        $(FC) $(FFLAGS) -o $@ $<

.PHONY: clean
	 
clean:
	rm *_f90
