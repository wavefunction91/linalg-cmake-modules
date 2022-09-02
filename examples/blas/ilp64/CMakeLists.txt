cmake_minimum_required( VERSION 3.10 )
project(blas_test LANGUAGES C)

find_package( BLAS REQUIRED COMPONENTS ilp64 )
include( ../../blas/common.cmake )
