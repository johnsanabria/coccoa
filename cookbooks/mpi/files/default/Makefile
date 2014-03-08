run: compile
	mpiexec -wdir ${HOME} -n 8 -f machinefile /mirror/mpi_hello
compile:
	mpicc mpi_hello.c -o /mirror/mpi_hello
clean:
	rm -rf mpi_hello
python:
	mpiexec -n 8 -f machinefile python /mirror/helloworld.py
