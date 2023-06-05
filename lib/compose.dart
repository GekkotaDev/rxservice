/// The Composition API.
///
/// Designed to be primarily used in conjuction with `rxservice` but can be used
/// independently of `rxservice`; The Composition API provides users a more
/// ergonomic API to compose together states of both your services and from your
/// stateful widgets.
///
/// The Composition API abstracts the direct usage of [Stream]s from the user
/// and instead allows them to think in terms of the actual values that their
/// state represents rather than as [Stream]s. It provides a more direct method
/// of composing together states.
library compose;

export "src/hooks.dart";
