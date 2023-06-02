import "package:rxdart/rxdart.dart";

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
abstract class Service<T> {
  late final BehaviorSubject<T> _state;

  Service(T state) {
    this._state = BehaviorSubject.seeded(state);
  }

  /// A [Stream] of the latest [state]. The [state] may be consumed by passing a
  /// callback function to the listen method of [$] which will implicitly rerun
  /// the consumer updated with the latest [state].
  ///
  /// If this is behaviour is not desired then the consumer may directly get the
  /// current [state] property or otherwise refactor to acheive the desired
  /// results.
  ValueStream<T> get $ => _state.stream;

  /// Alias to [$].
  ValueStream<T> call() => $;

  /// A reference to the current [state]. Consumers of this property receive a
  /// non-reactive updated reference to the [state] but can update the [state]
  /// with the [Service] reacting by updating the stream.
  ///
  /// Note that while this will not rerun the consumer with the updated state, a
  /// consequence of this behaviour will be that the state will eventually
  /// become stale and outdated.
  T get state => _state.value;
  set state(T value) => _state.add(value);

  /// Update the [state] by deriving it from the previous [state], causing the
  /// [Service] to react by updating the stream.
  void setState(T Function(T state) setter, {bool forceUpdate = false}) {
    T nextState = setter(state);

    if (forceUpdate) {
      state = nextState;
      return;
    }

    if (state != nextState) {
      state = nextState;
      return;
    }
  }
}
