#!/bin/bash

export dist_name=$1
export thread_name=$2
export int_type=$3

if [ "$dist_name" == "intel-mkl" ]
then
  export mkl_base_name="mkl_intel_$3"
  if [ "$thread_name" == "sequential" ]
  then
    export mkl_thread_name="mkl_sequential"
  elif [ "$thread_name" == "openmp" ] 
  then
    export mkl_thread_name="mkl_(gnu|intel|pgi)_thread"
  elif [ "$thread_name" == "tbb" ] 
  then
    export mkl_thread_name="mkl_tbb_thread"
  fi
  echo "$mkl_base_name.*$mkl_thread_name"
elif [ "$dist_name" == "netlib" ]
then
  echo "blas"
else
  echo "$dist_name"
fi

