#!/bin/bash

export dist_name=$1
export thread_name=$2
export int_type=$3

my_realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

if [ "$dist_name" == "netlib" ]
then
  echo "lapack"
elif [ "$dist_name" == "blis" ]
then
  echo "lapack.*blis"
else
  export local_path=$(my_realpath $0)
  export script_dir=$(dirname $local_path)
  $script_dir/blas_libname.sh "$dist_name" "$thread_name" "$int_type"
fi

