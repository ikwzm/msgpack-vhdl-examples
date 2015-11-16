int fib(int n)
{
  int r0 = 0;
  int r1 = 1;
  int i;
  if (n <= 0) return 0;
  if (n == 1) return 1;
  for(i = 1; i < n; i++) {
    int prev_r1 = r1;
    r1 = r0 + r1;
    r0 = prev_r1;
  }
  return r1;
}
