# Makefile

INPUT_LLVM    := ./0fib00.s
INPUT_FORTRAN := ./fib.f
TEST_PROGRAM  := ./fib_test

# Command
OPT       := opt-3.4
GFORTRAN  := gfortran-4.8
DRAGONEGG := /usr/lib/gcc/x86_64-linux-gnu/4.8/plugin/dragonegg.so
FORTROCK  := ~/work/FortRock/src/fortrock.so
REMOVE    := rm

.PHONY: all clean

all: output.v

test: $(INPUT_FORTRAN) $(TEST_PROGRAM).f
	$(GFORTRAN) -O1 -o $(TEST_PROGRAM) $(TEST_PROGRAM).f $(INPUT_FORTRAN) 
	$(TEST_PROGRAM)

output.v: $(INPUT_LLVM)
	$(OPT) -load $(FORTROCK) -instnamer -fortrock $(INPUT_LLVM) -S


$(INPUT_LLVM): $(INPUT_FORTRAN)
	$(GFORTRAN) -O1 $(INPUT_FORTRAN) \
		-fplugin=$(DRAGONEGG) \
		-fplugin-arg-dragonegg-emit-ir -S -o $(INPUT_LLVM)

clean:
	$(REMOVE) output.v $(INPUT_LLVM) $(TEST_PROGRAM)

