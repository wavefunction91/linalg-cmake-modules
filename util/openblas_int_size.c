#if __has_include(<openblas_config.h>)
#include <openblas_config.h>
#else
#include <openblas/openblas_config.h>
#endif

int main(int argc, char** argv) {
  int blis_int_size = sizeof(blasint)*8;
  if( blis_int_size == 32 ) return 0;
  else                      return 1;
}
