cmake_minimum_required( VERSION 3.17 FATAL_ERROR )
project( check_ilp64 LANGUAGES C CXX Fortran )

find_package( ILP64 REQUIRED )
add_executable( my_test_c test.c )
add_executable( my_test_cxx test.cxx )
add_executable( my_test_fortran test.f90 )

target_compile_options( my_test_c       PUBLIC ${ILP64_COMPILE_OPTIONS} )
target_compile_options( my_test_cxx     PUBLIC ${ILP64_COMPILE_OPTIONS} )
target_compile_options( my_test_fortran PUBLIC ${ILP64_COMPILE_OPTIONS} )

add_executable( my_test_c_2 test.c )
add_executable( my_test_cxx_2 test.cxx )
add_executable( my_test_fortran_2 test.f90 )
target_compile_options( my_test_c       PUBLIC ${ILP64_C_COMPILE_OPTIONS} )
target_compile_options( my_test_cxx     PUBLIC ${ILP64_CXX_COMPILE_OPTIONS} )
target_compile_options( my_test_fortran PUBLIC ${ILP64_Fortran_COMPILE_OPTIONS} )
