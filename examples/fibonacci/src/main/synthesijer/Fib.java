public class Fib {
    public long fib(int n) {
        long cur  = 0;
        long next = 1;
        for (int i = 0; i < n; ++i) {
            long tmp = cur;
            cur = next;
            next += tmp;
        }
        return cur;
    }
}
