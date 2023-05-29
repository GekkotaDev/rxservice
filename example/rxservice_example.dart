import "package:get_it/get_it.dart";

import "src/counter.dart";

void counterApp(CounterService counter) {
  // Implementation details…

  // Print the updated value to stdout.
  GetIt.I<CounterService>().$.listen(print);
}

void main() {
  GetIt.I.registerSingleton(CounterService());

  /*
    Assume that the mock function below initializes an actual CLI/TUI program
    that allows you to modify the value of a counter and that the initializer
    accepts a parameter of the type CounterService so that it may be tested with
    a mock counter, otherwise normal operations.
   */
  counterApp(GetIt.I<CounterService>());
}
