def fib(n):
    if n <= 0: return 0
    if n == 1: return 1
    r0 = 0
    r1 = 1
    for i in range(n-1):
        prev_r1 = r1
        r1 = r0 + r1
        r0 = prev_r1
    return r1
