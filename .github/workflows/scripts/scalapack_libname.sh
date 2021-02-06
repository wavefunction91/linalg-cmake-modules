
#!/bin/bash

export dist_name=$1
export thread_name=$2
export int_type=$3
export mpi_type=$4

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
  echo "$mkl_scalapack_name.*$mkl_base_name.*$mkl_thread_name.*$mkl_blacs_name"
else
  echo "scalapack"
fi

