import "package:rxs/rxdart.dart";
import "package:rxs/rxs.dart";

/// An abstract base class for implementing [Service]s.
///
/// @example
/// ```dart
/// class CounterService extends Service<int> {
///   CounterService() : super(0);
///
///   //? The code from this point on is not necessary to have a valid [Service]
///   //? but they are the preferred way of mutating [state]
///   void increment(int count) =>
///       setState((previousState) => previousState + count);
///
///   void decrement(int count) =>
///       setState((previousState) => previousState - count);
///
///   void reset() => state = 0;
/// }
/// ```
abstract base class Service<T> {
  late final ValueStream<T> $;
  late final Accessor<T> _getter;
  late final Setter<T> _setter;

  /// The default value of the [Service].
  Service(T value) {
    final (getter, setter) = signal(value);
    _getter = getter;
    _setter = setter;

    $ = stream(() => _getter());
  }

  /// The state of the [Service].
  T get state => _getter();
  set state(T value) => _setter(value);

  /// Set the next state derived from the previous state.
  void setState(T Function(T previousState) setter) {
    state = setter(state);
  }
}
