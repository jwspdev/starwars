import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';

void main() {
  setUp(() {
    initializeDependencies();
  });
  test('should initialize dependencies', () {
    debugPrint('$sl');
  });
}
