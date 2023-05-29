import "package:streamstate/streamstate.dart";
import "package:test/test.dart";

class CounterService extends Service<int> {
  CounterService() : super(0);

  void increment(int count) =>
      setState((previousState) => previousState + count);

  void decrement(int count) =>
      setState((previousState) => previousState - count);

  void reset() => state = 0;
}

void main() {
  group("[isolated tests]", () {
    test("increments counter", () {
      final counter = CounterService();
      assert(counter.state == 0);
      counter.increment(1);
      assert(counter.state == 1);
    });

    test("decrements counter", () {
      final counter = CounterService();
      assert(counter.state == 0);
      counter.decrement(1);
      assert(counter.state == -1);
    });
  });

  group("[stateful tests]", () {
    final counter = CounterService();

    test("increments counter", () {
      assert(counter.state == 0);
      counter.increment(4);
      assert(counter.state == 4);
    });

    test("decrements counter", () {
      counter.decrement(2);
      assert(counter.state == 2);
    });

    test("resets counter", () {
      counter.reset();
      assert(counter.state == 0);
    });
  });
}
