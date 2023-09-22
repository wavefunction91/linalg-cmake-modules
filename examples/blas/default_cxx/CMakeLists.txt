cmake_minimum_required( VERSION 3.10 )
project(blas_test LANGUAGES CXX)

find_package( BLAS REQUIRED )
include( ../../blas/common.cmake )
