cmake_minimum_required( VERSION 3.10 )
project( introspect_omp LANGUAGES C )

find_package( OpenMP REQUIRED )

include(IntrospectOpenMP)
check_openmp_is_gnu( OpenMP::OpenMP_C OpenMP_IS_GOMP )
#check_openmp_is_nv( OpenMP_C_LIBRARIES OpenMP_IS_NV )

message( STATUS "OpenMP_LIBRARIES = ${OpenMP_C_LIBRARIES}" )
message( STATUS "OpenMP_IS_GOMP   = ${OpenMP_IS_GOMP}"     )
#message( STATUS "OpenMP_IS_IOMP   = ${OpenMP_IS_IOMP}"     )
#message( STATUS "OpenMP_IS_NV     = ${OpenMP_IS_NV}"       )
