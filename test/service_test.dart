import "package:test/test.dart";

import "package:rxservice/rxservice.dart";

class CounterService extends Service<int> {
  CounterService() : super(0);

  final memoSquare = computed<int, (int,)>();

  void increment(int n) => state = state + n;
  void decrement(int n) => state = state - n;
  void reset() => state = 0;
  void square() {
    final (compute) = memoSquare;
    setState((count) => compute((count,), () => count * count));
  }
}

void main() {
  final counter = CounterService();

  test("increments counter", () {
    counter.increment(4);
    assert(counter.state == 4);
  });

  test("squares counter", () {
    counter.square();
    assert(counter.state == 16);
  });

  test("decrements counter", () {
    counter.decrement(6);
    assert(counter.state == 10);
  });

  test("resets counter", () {
    counter.reset();
    assert(counter.state == 0);
  });
}
