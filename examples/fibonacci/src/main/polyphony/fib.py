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
    expect = [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610]
    for i in range(len(expect)):
        result = fib(i)
        assert expect[i] == result
        print(i, "=>", result)

test()
