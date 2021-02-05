ubuntu_codename ?= $(shell lsb_release -sc)
clang_version ?= 9
software_prefix := /home/software

export DEBIAN_FRONTEND=noninteractive

ubuntu_release = $(shell lsb_release -sr)


intel_mkl_version ?= 2020.4-304
intel_mkl := intel-mkl-\*-${intel_mkl_version}

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


# Intel
apt-add-repository/intel-mkl:
	wget -O - https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | apt-key add -
	apt-add-repository "deb https://apt.repos.intel.com/mkl all main"
	apt-get -yq update

download/intel-mkl:
	apt-get install -yq --download-only ${intel_mkl}

install/intel-mkl:
	apt-get -yq install ${intel_mkl}
	rm -rf /opt/intel/mkl
	ln -s /opt/intel/compilers_and_libraries_$(subst -,.,${intel_mkl_version})/linux/mkl /opt/intel/mkl
	test -x /opt/intel/mkl/bin/mklvars.sh

install/intel-mkl-lp64-serial:  install/intel-mkl
install/intel-mkl-lp64-openmp:  install/intel-mkl
install/intel-mkl-lp64-tbb:     install/intel-mkl
install/intel-mkl-ilp64-serial: install/intel-mkl
install/intel-mkl-ilp64-openmp: install/intel-mkl
install/intel-mkl-ilp64-tbb:    install/intel-mkl


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
install/blis/lp64-serial:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-lp64-serial -t no -i 32 -b 32 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install

install/blis/ilp64-pthreads:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-pthreads -t pthreads -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/ilp64-openmp:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-openmp -t openmp -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install
install/blis/ilp64-serial:
	cd ${software_prefix}/src/blis/blis-0.8.0 && CC=gcc ./configure -p ${software_prefix}/install/blis-ilp64-serial -t no -i 64 -b 64 --enable-blas auto
	make -C ${software_prefix}/src/blis/blis-0.8.0 install

# OpenBLAS
download/openblas:
	mkdir -p ${software_prefix}/src/openblas
	cd ${software_prefix}/src/openblas && wget https://github.com/xianyi/OpenBLAS/releases/download/v0.3.13/OpenBLAS-0.3.13.tar.gz
	cd ${software_prefix}/src/openblas && tar xzf OpenBLAS-0.3.13.tar.gz

install/openblas/lp64-serial:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_THREAD=0 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-serial  install
install/openblas/lp64-pthreads:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_THREAD=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-pthreads  install
install/openblas/lp64-openmp:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 USE_OPENMP=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-lp64-openmp  install

install/openblas/ilp64-serial:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_THREAD=0 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-serial  install
install/openblas/ilp64-pthreads:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_THREAD=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-pthreads  install
install/openblas/ilp64-openmp:
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 clean
	BINARY64=1 INTERFACE64=1 USE_OPENMP=1 CC=gcc FC=gfortran NO_CBLAS=1 NO_LAPACKE=1 make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13
	make -C ${software_prefix}/src/openblas/OpenBLAS-0.3.13 PREFIX=${software_prefix}/install/openblas-ilp64-openmp  install

# NETLIB == NETLIB-LAPACK b/c it includes NETLIB-BLAS
download/netlib:
	mkdir -p ${software_prefix}/src/netlib
	cd ${software_prefix}/src/netlib && wget https://github.com/Reference-LAPACK/lapack/archive/v3.9.0.tar.gz
	cd ${software_prefix}/src/netlib && tar xzf v3.9.0.tar.gz

install/netlib/lp64-serial-static:
	rm -fr ${software_prefix}/build/netlib-lp64-serial
	cmake -H${software_prefix}/src/netlib/lapack-3.9.0 -B${software_prefix}/build/netlib-lp64-serial -DCMAKE_INSTALL_PREFIX=${software_prefix}/install/netlib-lp64-serial
	cmake --build ${software_prefix}/build/netlib-lp64-serial --target install
install/netlib/lp64-serial-shared:
	rm -fr ${software_prefix}/build/netlib-lp64-serial
	cmake -H${software_prefix}/src/netlib/lapack-3.9.0 -B${software_prefix}/build/netlib-lp64-serial -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=${software_prefix}/install/netlib-lp64-serial
	cmake --build ${software_prefix}/build/netlib-lp64-serial --target install

install/netlib/lp64-serial: install/netlib/lp64-serial-static install/netlib/lp64-serial-shared