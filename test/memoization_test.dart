import "package:rxservice/rxservice.dart";
import "package:test/test.dart";

class FibonacciService extends Service<int> {
  final memoFibonacci = createMemo<int, (int,)>();

  FibonacciService() : super(0);

  void loopUntil(int n) {
    final (:memoize) = memoFibonacci;

    state = memoize((n,), () {
      var a = 0;
      var b = 1;

      while (b < n) {
        print("a=$a b=$b");
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

    print("start run A");
    sequencer.loopUntil(42);
    assert(sequencer.state == 34);
    print("end run A");

    print("start run B");
    sequencer.loopUntil(42);
    assert(sequencer.state == 34);
    print("end run B");
  });
}
