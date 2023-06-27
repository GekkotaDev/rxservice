import "package:rxservice/rxservice.dart";

import "src/counter.dart";

void counterApp(CounterService counter) {
  // Implementation details…

  // Print the updated value to stdout.
  Injector.inject(() => CounterService()).$.listen(print);
}

void main() {
  /*
    Assume that the mock function below initializes an actual CLI/TUI program
    that allows you to modify the value of a counter and that the initializer
    accepts a parameter of the type CounterService so that it may be tested with
    a mock counter, otherwise normal operations.
   */
  counterApp(
    Injector.inject(() => CounterService()),
  );
}
