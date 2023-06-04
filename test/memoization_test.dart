import "package:rxservice/rxservice.dart";
import "package:test/test.dart";

class FibonacciService extends Service<int> {
  int count = 0;
  final memoFibonacci = computed<int, (int,)>();

  FibonacciService() : super(0);

  void loopUntil(int n) {
    final (:memoize) = memoFibonacci;

    state = memoize((n,), () {
      var a = 0;
      var b = 1;

      while (b < n) {
        count++;
        final c = a + b;
        a = b;
        b = c;
      }

      return a;
    });
  }
}

void main() {
  test("generates fibonacci sequence correctly", () {
    // TODO: Find performance profiling solely for Dart.
    final sequencer = FibonacciService();

    sequencer.loopUntil(42);
    assert(sequencer.state == 34);
    assert(sequencer.count == 9);

    sequencer.loopUntil(42);
    assert(sequencer.state == 34);
    assert(sequencer.count == 9);
  });
}
