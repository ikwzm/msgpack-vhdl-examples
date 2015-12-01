long long fib(int n)
{
  long long curr = 0;
  long long next = 1;
  int i;
  for(i = 0; i < n; i++) {
    long long prev = curr;
    curr = next;
    next += prev;
  }
  return curr;
}
