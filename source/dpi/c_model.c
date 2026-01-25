#include <stdio.h>
#include <svdpi.h> // Required for DPI types/headers

extern "C" int c_adder(int a, int b) {
  printf("[C MODEL] Adding %0d + %0d\n", a, b);
  return a + b;
}
