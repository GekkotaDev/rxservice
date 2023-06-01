import "package:rxdart/rxdart.dart";

typedef Memoize<D, S> = S Function(D dependencies, S Function() computation);
typedef ComputedMethods<D, S> = ({Memoize<D, S> memoize});

/// Cache the result of computationally expensive pure functions.
///
/// Creates a data structure to cache the result of computationally expensive
/// pure functions. The cache may be used through the (:memoize) method exposed
/// by the data structure to memoize the public methods exposed by your service.
///
/// (:memoize) expects a record of dependencies and a callback function to
/// memoize to be passed to it. The dependencies record will usually be the
/// arguments passed to the service's method while the callback function is the
/// computationally expensive logic of your method to be memoized. The callback
/// function must be pure to not invalidate the cache.
///
/// Additionally, to narrow down the types that (:memoize) can only accept, you
/// must explicitly declare the generics provided by [computed]. It is expected
/// that [computed] will be called as an attribute of your Service while the
/// memo's (:memoize) method will be called from a method of your service. Each
/// memoized method must have their own memo attribute.
///
/// ```dart
/// class FibonacciService extends Service<int> {
///   final memoFibonacci = computed<int, (int,)>();
///   ...
///
///   void recurseUntil(int n) {
///     final (:memoize) = memoFibonacci;
///
///     return memoize((n,), () {
///       //? Implementation...
///     });
///   }
/// }
/// ```
ComputedMethods<D, S> computed<S, D extends Record>() {
  Map<D, S> cache = {};

  S memoize(D dependencies, S Function() computation) {
    final cachedState = cache[dependencies];

    if (cachedState is! S) {
      cache[dependencies] = computation();
      return cache[dependencies] as S;
    }

    return cachedState;
  }

  return (memoize: memoize);
}
