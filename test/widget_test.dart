// Smoke test placeholder. The default counter template test does not apply to
// this game; we keep a trivial test so `flutter test` has a valid entry point.
import 'package:flutter_test/flutter_test.dart';
import 'package:hidden_objects/main.dart';

void main() {
  test('app entry symbol exists', () {
    // Referencing the real app class keeps this file compiling with the app.
    expect(HiddenObjectsApp, isNotNull);
  });
}
