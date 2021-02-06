
#!/bin/bash

export dist_name=$1
export thread_name=$2
export int_type=$3
export mpi_type=$4

my_realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}


export local_path=$(my_realpath $0)
export script_dir=$(dirname $local_path)
export lapack_name=`$script_dir/lapack_libname.sh "$dist_name" "$thread_name" "$int_type"`

if [ "$dist_name" == "intel-mkl" ]
then
  export mkl_scalapack_name="mkl_scalapack_$3"

  if [ "$mpi_type" == "mpich" ] || [ "$mpi_type" == "intelmpi" ]
  then
    export mkl_blacs_name="mkl_blacs_intelmpi_$3"
  elif [ "$mpi_type" == "openmpi" ]
  then
    export mkl_blacs_name="mkl_blacs_openmpi_$3"
  else
    export mkl_blacs_name="mkl_blacs_sgimpt_$3"
  fi

  echo "$mkl_scalapack_name.*$lapack_name.*$mkl_blacs_name"
else
  echo "scalapack"
fi

