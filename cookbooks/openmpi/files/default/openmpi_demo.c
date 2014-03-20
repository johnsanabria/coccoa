#include <stdio.h>
#include <mpi.h>
#include <unistd.h>

int main(int argc, char** argv) {
    int myrank, nprocs;
    char hostname[1024];
    struct hostent *h;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

    printf("Hello from processor %d of %d\n", myrank, nprocs);
    // -----------------
    hostname[1023] = '\0';
    gethostname(hostname,1023);
    printf("h_name: %s\n", hostname);
    //h = gethostbyname(hostname);
    //printf("h_name: %s\n", h->h_name);

    MPI_Finalize();
    return 0;
}
