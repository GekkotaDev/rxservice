import "package:test/test.dart";

import "package:rxservice/rxservice.dart";

final class CounterService extends Service<int> {
  CounterService() : super(0);

  final memoSquare = computed<int, (int,)>();

  void increment(int n) => state = state + n;
  void decrement(int n) => state = state - n;
  void reset() => state = 0;
  void square() {
    final (compute) = memoSquare;
    setState((count) => compute((count,), () => count * count));
  }

  int mock() => 42;
}

final class MockCounterService extends CounterService {
  @override
  int mock() => 0;
}

void main() {
  Injector.create(CounterService(), mock: MockCounterService());

  test("increments counter", () {
    final counter = Injector.inject(() => CounterService());
    counter.increment(4);
    assert(counter.state == 4);
  });

  test("squares counter", () {
    final counter = Injector.inject(() => CounterService());
    counter.square();
    assert(counter.state == 16);
  });

  test("decrements counter", () {
    final counter = Injector.inject(() => CounterService());
    counter.decrement(6);
    assert(counter.state == 10);
  });

  test("resets counter", () {
    final counter = Injector.inject(() => CounterService());
    counter.reset();
    assert(counter.state == 0);
  });

  test("counter has been mocked", () {
    final counter = Injector.inject(() => CounterService());
    assert(counter.mock() == 0);
  });
}
