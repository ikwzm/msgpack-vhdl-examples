      program fib_test
      implicit none
      integer i, n, o
      n = 7
      i = 0
 1000 call fib(i,o)
      print *,i,o
      if (i < n) then
         i = i + 1
         goto 1000
      endif
      end
