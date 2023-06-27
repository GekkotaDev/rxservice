import "package:rxservice/rxservice.dart";

final class CounterService extends Service<int> {
  CounterService() : super(0);

  void increment(int count) =>
      setState((previousState) => previousState + count);

  void decrement(int count) =>
      setState((previousState) => previousState - count);

  void reset() => state = 0;
}
