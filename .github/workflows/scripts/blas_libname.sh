#!/bin/sh

export dist_name=$1
export thread_name=$2

if [ "$dist_name" == "intel-mkl" ]
then
  if [ "$thread_name" == "sequential" ]
  then
    echo ".*mkl_sequential.*"
  elif [ "$thread_name" == "openmp" ] 
  then
    echo ".*mkl_(gnu|intel|pgi)_thread.*"
  elif [ "$thread_name" == "tbb" ] 
  then
    echo ".*mkl_tbb_thread.*"
  fi
elif [ "$dist_name" == "netlib" ]
then
  echo "blas"
else
  echo "$dist_name"
fi

