cmake_minimum_required( VERSION 3.10 )
project(scalapack_test LANGUAGES C)

find_package( ScaLAPACK REQUIRED )
include( ../../scalapack/common.cmake )