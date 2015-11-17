int fib(int n)
{
  int curr = 0;
  int next = 1;
  int i;
  for(i = 0; i < n; i++) {
    int prev = curr;
    curr = next;
    next += prev;
  }
  return curr;
}
