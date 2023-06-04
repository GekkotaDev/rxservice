import "package:test/test.dart";

import "package:rxservice/rxservice.dart";

class CounterService extends Service<int> {
  CounterService() : super(0);

  void increment(int count) =>
      setState((previousState) => previousState + count);

  void decrement(int count) =>
      setState((previousState) => previousState - count);

  void reset() => state = 0;
}

void main() {
  test("runs effects correctly", () {
    final counterA = CounterService();
    final counterB = CounterService();
    final counterC = CounterService();

    effect(() {
      final count = counterA.state + counterB.state;
      counterC.state = count;
    });

    assert(counterC.state == 0);

    counterA.increment(4);
    assert(counterC.state == 4);

    counterB.increment(6);
    assert(counterC.state == 10);

    counterA.reset();
    counterB.reset();
    assert(counterC.state == 0);
  });
}
