cmake_minimum_required( VERSION 3.10 )
project( introspect_omp LANGUAGES C CXX Fortran )

find_package( MPI REQUIRED )

include(IntrospectMPI)
get_mpi_vendor( MPI::MPI_C MPI_VENDOR )
message( STATUS "MPI_VENDOR = ${MPI_VENDOR}" )
