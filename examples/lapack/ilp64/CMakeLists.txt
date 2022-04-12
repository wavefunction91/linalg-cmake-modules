cmake_minimum_required( VERSION 3.10 )
project(lapack_test LANGUAGES C)

find_package( LAPACK REQUIRED COMPONENTS ilp64 )
include( ../../lapack/common.cmake )