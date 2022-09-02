#!/bin/bash

export cmake_dir=$1
export linalg_dist=$2
export linalg_thread=$3
export linalg_int=$4
export mpi_dist=$5


my_realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

export local_path=$(my_realpath $0)
export script_dir=$(dirname $local_path)


echo "CHECKING ScaLAPACK_LIBRARIES=`cmake -N -LA $cmake_dir | grep ScaLAPACK_LIBRARIES`"
echo "REFERENCE REGEX=`$script_dir/scalapack_libname.sh $linalg_dist $linalg_thread $linalg_int $mpi_dist`"

cmake -N -LA $cmake_dir | \
  grep "ScaLAPACK_LIBRARIES" | \
  grep -q -E `$script_dir/scalapack_libname.sh $linalg_dist $linalg_thread $linalg_int $mpi_dist`
