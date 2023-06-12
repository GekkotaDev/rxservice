/// Memoizes a computation.
typedef Compute<S, D extends Record> = S Function(
    D dependencies, S Function() computation);

/// Cache the result of computationally expensive pure functions.
///
/// Creates a data structure to cache the result of computationally expensive
/// pure functions. The cache may be used through the (:compute) method exposed
/// by the data structure to memoize the public methods exposed by your service.
///
/// (:compute) expects a record of dependencies and a callback function to
/// memoize to be passed to it. The dependencies record will usually be the
/// arguments passed to the service's method while the callback function is the
/// computationally expensive logic of your method to be memoized. The callback
/// function must be pure to not invalidate the cache.
///
/// Additionally, to narrow down the types that (:compute) can only accept, you
/// must explicitly declare the generics provided by [computed]. It is expected
/// that [computed] will be called as an attribute of your Service while the
/// memo's (:compute) method will be called from a method of your service. Each
/// memoized method must have their own memo attribute.
Compute<S, D> computed<S, D extends Record>() {
  final Map<D, S> cache = {};

  S compute(D dependencies, S Function() computation) {
    final cached = cache[dependencies];

    if (cached is S) {
      return cached;
    }

    final result = computation();
    cache[dependencies] = result;
    return result;
  }

  return compute;
}
