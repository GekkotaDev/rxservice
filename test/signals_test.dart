import "package:test/test.dart";

import "package:rxservice/compose.dart";

void main() {
  test("gets signal updated", () {
    final (count, setCount) = signal(0);

    assert(count() == 0);

    setCount(count() + 4);

    assert(count() == 4);
  });

  test("gets signal's side effects updated", () {
    final (countA, setCountA) = signal(0);
    final (countB, setCountB) = signal(0);
    final (countC, setCountC) = signal(0);

    assert(countC() == 0);

    effect(() => setCountC(countA() + countB()));

    setCountA(4);
    assert(countC() == 4);

    setCountB(6);
    assert(countC() == 10);

    setCountA(0);
    setCountB(0);
    assert(countC() == 0);
  });
}
