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
/// must explicitly declare the generics provided by [createMemo]. It is
/// expected that [createMemo] will be called as an attribute of your Service
/// while the memo's (:memoize) method will be called from a method of your
/// service. Each memoized method must have their own memo attribute.
///
/// ```dart
/// class FibonacciService extends Service<int> {
///   final memoFibonacci = createMemo<int, (int,)>();
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
({S Function(D, S Function()) memoize}) createMemo<S, D extends Record>() {
  Map<D, S> cache = {};

  S memoize(D dependencies, S Function() callback) {
    final cachedState = cache[dependencies];

    if (cachedState is! S) {
      cache[dependencies] = callback();
      return cache[dependencies] as S;
    }

    return cachedState;
  }

  return (memoize: memoize);
}
