import "package:rxservice/src/service.dart";

/// Declare a side effect when a [Service] updates.
///
/// Declare a [sideEffect] that will re-run whenever any of its dependencies
/// update. [effect] will automatically track of any of the services that are
/// referenced within the [sideEffect] without explicitly declaring a dependency
/// list.
///
/// The [sideEffect] must not write to any of its dependencies directly to avoid
/// recursively running the [sideEffect]. Services used in the side effect must
/// provide their state directly instead of themselves or their [Stream]; this
/// allows for an ergonomic API that allows the user to think in terms of the
/// values directly rather than in [Stream]s. [effect] makes no attempts to
/// memoize.
///
/// ```dart
/// class HypotenuseService extends Service<int> {
///   HypotenuseService() : super(0) {
///     effect(() {
///       state = sqrt( GetIt.I<A>().state + GetIt.I<B>().state )
///     });
///   }
/// }
/// ```
void effect(void Function() sideEffect) {
  effects.add(() => sideEffect());
  sideEffect();
  effects.removeLast();
}
