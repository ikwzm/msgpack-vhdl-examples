#include <stdio.h>

void main()
{
  int i;
  for(i = 0; i < 43; ++i) {
    printf("%d => %d\n", i, fib(i));
  }
}
