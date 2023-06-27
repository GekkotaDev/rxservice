import "service.dart";

/// `rxservice`'s service locator tailor made for the library itself.
///
/// The [Injector] namespace provides a simple [Service] locator API that
/// provides users a consistent and reliable means of Dependency Injection; This
/// allows users to have simplified tests by encouraging the design of a loosely
/// coupled codebase, and to have a simple global state management solution.
///
/// The [Injector] encourages that all [Service]s must be singletons and is the
/// default behaviour when [inject]ing [Service]s into their respective
/// dependents. This behaviour may be circumvented through the [create] method
/// wherein instead of using the method to provide mock [Service]s and to
/// eagerly initialize services, it is instead used to force a new instance of a
/// given [Service] to take the place of its previous [Service].
final class Injector {
  static final Map<Type, Service> _registry = {};

  /// Register a [Service] to the [Injector]'s registry.
  ///
  /// The [create] method may be used to eagerly initialize specified services
  /// at the start of the entry point function or to provide a mock [Service]
  /// within a test.
  ///
  /// In addition, the [create] method may be used to swap an implementation of
  /// a given [Service] of type [S] with a compatible alternative implementation
  /// that is a subtype of [S] by using the same API that is used when mocking
  /// [Service]s.
  static S create<S extends Service>(S service, {S? mock}) {
    if (mock != null) {
      _registry[S] = mock;
      return mock;
    }

    _registry[S] = service;
    return service;
  }

  /// Inject a [Service] singleton into the dependent parameter.
  ///
  /// The [inject] method provides the parameter that invoked it a singleton of
  /// the [Service] dependency returned from the [serviceInjector], and is
  /// expected to be directly invoked within a dependent class's constructor so
  /// that it may be lazy loaded rather than being eagerly loaded while still
  /// not in use, in addition to the benefits of Dependency Injection.
  ///
  /// Additionally, the [inject] method guarantees that any [Service] returned
  /// by the [serviceInjector] is a global singleton that is maintained
  /// throughout the lifespan of the application, and through the use of Dart's
  /// type inferrence the singleton will be used instead of invoking the service
  /// injector again for the given type.
  ///
  /// This has the side effect that it allows for [inject]ing directly within a
  /// class to be a cheap operation, and avoids having to reinstantiate a
  /// [Service] of a given type when it's already registered within [Injector]'s
  /// registry.
  static S inject<S extends Service>(S Function() serviceInjector) {
    final service = _registry[S];

    if (service is! S) return Injector.create<S>(serviceInjector());
    return service;
  }

  /// An alias to [inject].
  static S use<S extends Service>(S Function() serviceInjector) =>
      inject(serviceInjector);
}
