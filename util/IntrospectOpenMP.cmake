set( OMP_UTILITY_CMAKE_FILE_DIR ${CMAKE_CURRENT_LIST_DIR} )

function( check_openmp_is_intel _openmp_libs _openmp_is_intel )

include( CMakePushCheckState )
include( CheckLibraryExists )
include( CheckSymbolExists )


cmake_push_check_state( RESET )

if( ${_openmp_libs} )
  set( CMAKE_REQUIRED_LIBRARIES ${${_openmp_libs}} )
endif()
set( CMAKE_REQUIRED_QUIET ON )

check_library_exists( "" "kmp_set_defaults" "" ${_openmp_is_intel} )

if( ${_openmp_is_intel} )
  set( ${_openmp_is_intel} TRUE PARENT_SCOPE )
else()
  set( ${_openmp_is_intel} FALSE PARENT_SCOPE )
endif()

endfunction()






function( check_openmp_is_nv _openmp_libs _openmp_is_nv )

include( CMakePushCheckState )
include( CheckLibraryExists )
include( CheckSymbolExists )


cmake_push_check_state( RESET )



if( ${_openmp_libs} )
  if( NOT TARGET ${_openmp_libs} )
    set( _openmp_libs ${${_openmp_libs}} )
  endif()
  set( CMAKE_REQUIRED_LIBRARIES ${_openmp_libs} )
endif()
set( CMAKE_REQUIRED_QUIET ON )

check_library_exists( "" "nvomp_set_memory_preferred_location_device" "" ${_openmp_is_nv} )

if( ${_openmp_is_nv} )
  set( ${_openmp_is_nv} TRUE PARENT_SCOPE )
else()
  set( ${_openmp_is_nv} FALSE PARENT_SCOPE )
endif()

endfunction()
