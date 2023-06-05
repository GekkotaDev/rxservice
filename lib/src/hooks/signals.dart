import "package:rxdart/rxdart.dart";

import "package:rxservice/src/service.dart";

/// Gets the state of the signal.
typedef Getter<T> = T Function();

/// Setter function to reactively update the state.
typedef Setter<T> = void Function(T value);

/// Marks a value of type [T] as reactive.
typedef Signal<T> = (Getter<T>, Setter<T>);

/// Mark a [value] as reactive.
///
/// Mark the given [value] as reactive to explicitly allow it to be observed by
/// effects. This returns a [Record] of type [Signal] which exposes a [Getter]
/// that returns the [value] itself and a [Setter] that reactively updates the
/// state and any side effects.
Signal<S> signal<S>(S value) {
  final Set<Function()> sideEffects = {};
  final state = BehaviorSubject.seeded(value);

  S getState() {
    final effect = effects.lastOrNull;

    if (effect != null) sideEffects.add(effect);

    return state.value;
  }

  setState(S value) {
    state.add(value);

    // ignore: avoid_function_literals_in_foreach_calls
    sideEffects.forEach((sideEffect) => sideEffect());
  }

  return (getState, setState);
}
