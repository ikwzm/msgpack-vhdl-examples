from polyphony import testbench

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

@testbench
def test():
    assert 0  == fib(0)
    assert 1  == fib(1)
    assert 1  == fib(2)
    assert 2  == fib(3)
    assert 21 == fib(8)

test()

