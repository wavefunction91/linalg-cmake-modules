set( ILP64_COMPILE_OPTIONS
     # Ensure 64-bit executables for GNU C,CXX,Fortran
     $<$<AND:$<COMPILE_LANGUAGE:CXX,C,Fortran>,$<C_COMPILER_ID:GNU>>:"-m64">
     # Make default integers 64-bit for Fortran
     $<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<C_COMPILER_ID:Intel,PGI>>:"-i8">
     $<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<C_COMPILER_ID:GNU,Flang>>:"-fdefault-integer-8">
)

get_property( _enabled_languages GLOBAL PROPERTY ENABLED_LANGUAGES )
set( ILP64_FLAGS_WORK )
foreach(_lang ${_enabled_langauges})
  if( NOT _lang MATCHES "RC" )
    include( Check${_lang}CompilerFlag )
    check_${_lang}_compiler_flag( ${ILP64_COMPILE_OPTIONS} ${_lang}_ILP64_FLAGS_WORK )
    list(APPEND ILP64_FLAGS_WORK ${_lang}_ILP64_FLAGS_WORK )
  endif()
endif()
unset( _enabled_languages )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args( ILP64 REQUIRED_VARS ${ILP64_FLAGS_WORK} )
