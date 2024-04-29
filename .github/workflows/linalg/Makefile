ubuntu_codename ?= $(shell lsb_release -sc)
clang_version ?= 9
mpich_version ?= 3.3
openmpi_version ?= 4.1.0
software_prefix := /home/software

export DEBIAN_FRONTEND=noninteractive

ubuntu_release = $(shell lsb_release -sr)


install/main:
	apt-get update
	apt-get -yq install \
          lsb-release coreutils sudo bash-completion \
          apt-transport-https software-properties-common ca-certificates gnupg \
          build-essential wget curl \
          git make ninja-build \
          gcc g++ gfortran gdb valgrind \
          libunwind-dev libomp-dev \
          vim

install/g++-%:
	apt-get -yq install gcc-$* g++-$* gfortran-$*

# CMake
install/cmake:
	wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | apt-key add -
	apt-add-repository "deb https://apt.kitware.com/ubuntu/ ${ubuntu_codename} main"
	apt-get -yq update
	apt-get -yq install cmake


# LLVM
install/clang-%:
	wget https://apt.llvm.org/llvm-snapshot.gpg.key -O - | apt-key add -
	add-apt-repository "deb http://apt.llvm.org/${ubuntu_codename}/ llvm-toolchain-${ubuntu_codename}-$* main"
	apt-get -yq update
	apt-get -yq install clang-$*

install/clang: install/clang-${clang_version}


# MPICH
#download/mpich:
#	mkdir -p ${software_prefix}/src/mpich
#	cd ${software_prefix}/src/mpich && wget --no-check-certificate -q http://www.mpich.org/static/downloads/${mpich_version}/mpich-${mpich_version}.tar.gz
#	cd ${software_prefix}/src/mpich && tar xzf mpich-${mpich_version}.tar.gz
#
#install/mpich:
#	cd ${software_prefix}/src/mpich/mpich-${mpich_version} && CC=gcc CXX=g++ FC=gfortran ./configure --prefix=${software_prefix}/install/mpich
#	make -C ${software_prefix}/src/mpich/mpich-${mpich_version} install
install/mpich:
	apt-get install -yq libmpich-dev

# OpenMPI
#download/openmpi:
#	mkdir -p ${software_prefix}/src/openmpi
#	cd ${software_prefix}/src/openmpi && wget --no-check-certificate -qi https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.0.tar.gz 
#	cd ${software_prefix}/src/openmpi && tar xzf openmpi-${openmpi_version}.tar.gz
#
#install/openmpi:
#	cd ${software_prefix}/src/openmpi/openmpi-${openmpi_version} && CC=gcc CXX=g++ FC=gfortran ./configure --prefix=${software_prefix}/install/openmpi
#	make -C ${software_prefix}/src/openmpi/openmpi-${openmpi_version} install
install/openmpi:
	apt-get install -yq libopenmpi-dev openmpi-bin



# Intel
apt-add-repository/intel-mkl:
	apt install -y build-essential wget make gpg
	wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
	echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list	
	apt update

install/intel-mkl:
	apt -y install intel-oneapi-mkl-core intel-oneapi-mkl-core-devel intel-oneapi-mpi intel-oneapi-mpi-devel intel-oneapi-mkl-cluster intel-oneapi-mkl-cluster-devel

download/intel-mkl: apt-add-repository/intel-mkl

install/intel-mkl/lp64-sequential:  install/intel-mkl
install/intel-mkl/lp64-openmp:  install/intel-mkl
install/intel-mkl/lp64-tbb:     install/intel-mkl
install/intel-mkl/ilp64-sequential: install/intel-mkl
install/intel-mkl/ilp64-openmp: install/intel-mkl
install/intel-mkl/ilp64-tbb:    install/intel-mkl


# BLIS
download/blis:
	mkdir -p ${software_prefix}/src/blis
	cd ${software_prefix}/src/blis && wget --no-verbose https://github.com/flame/blis/archive/0.8.0.tar.gz
	cd ${software_prefix}/src/blis && tar xzf 0.8.0.tar.gz

install/blis/lp64-pthreads:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-lp64-pthreads -t pthreads -i 32 -b 32 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/lp64-openmp:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-lp64-openmp -t openmp -i 32 -b 32 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/lp64-sequential:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-lp64-sequential -t no -i 32 -b 32 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install

install/blis/ilp64-pthreads:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-pthreads -t pthreads -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/ilp64-openmp:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-openmp -t openmp -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/ilp64-sequential:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-sequential -t no -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install

# OpenBLAS
download/openblas:
	mkdir -p ${software_prefix}/src/openblas
	cd ${software_prefix}/src/openblas && wget https://github.com/xianyi/OpenBLAS/releases/download/v0.3.13/OpenBLAS-0.3.13.tar.gz
	cd ${software_prefix}/src/openblas && tar xzf OpenBLAS-0.3.13.tar.gz

install/openblas/lp64-sequential:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_THREAD=0 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-sequential  install
install/openblas/lp64-pthreads:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_THREAD=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-pthreads  install
install/openblas/lp64-openmp:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_OPENMP=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-openmp  install

install/openblas/ilp64-sequential:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_THREAD=0 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-sequential  install
install/openblas/ilp64-pthreads:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_THREAD=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-pthreads  install
install/openblas/ilp64-openmp:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_OPENMP=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 TARGET=GENERIC make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-openmp  install

# NETLIB == NETLIB-ScaLAPACK b/c it includes NETLIB-BLAS/LAPACK
download/netlib:
	mkdir -p ${software_prefix}/src/netlib
	cd ${software_prefix}/src/netlib && wget https://github.com/Reference-ScaLAPACK/scalapack/archive/v2.1.0.tar.gz
	cd ${software_prefix}/src/netlib && tar xzf v2.1.0.tar.gz

install/netlib/lp64-sequential-static:
	rm -fr ${software_prefix}/build/netlib-lp64-sequential
	cmake -H${software_prefix}/src/netlib/scalapack-2.1.0 \
              -B${software_prefix}/build/netlib-lp64-sequential \
	      -DSCALAPACK_BUILD_TESTS=OFF \
	      -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} \
              -DCMAKE_INSTALL_PREFIX=${software_prefix}/install/netlib-lp64-sequential
	cmake --build ${software_prefix}/build/netlib-lp64-sequential --target install

install/netlib/lp64-sequential-shared:
	rm -fr ${software_prefix}/build/netlib-lp64-sequential
	cmake -H${software_prefix}/src/netlib/scalapack-2.1.0 \
              -B${software_prefix}/build/netlib-lp64-sequential \
	      -DSCALAPACK_BUILD_TESTS=OFF \
	      -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} \
              -DBUILD_SHARED_LIBS=ON \
              -DCMAKE_INSTALL_PREFIX=${software_prefix}/install/netlib-lp64-sequential
	cmake --build ${software_prefix}/build/netlib-lp64-sequential --target install

install/netlib/lp64-sequential: install/netlib/lp64-sequential-static install/netlib/lp64-sequential-shared
