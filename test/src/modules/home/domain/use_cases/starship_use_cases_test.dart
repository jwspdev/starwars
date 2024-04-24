import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';

void main() {
  late GetCurrentStarshipUseCase getCurrentStarshipUseCase;
  late ListStarshipUseCase listStarshipUseCase;
  setUp(() {
    initializeDependencies();
    getCurrentStarshipUseCase = GetCurrentStarshipUseCase(sl());
    listStarshipUseCase = ListStarshipUseCase(sl());
  });

  group('current starship use case test', () {
    test('should call getcurrent starship method from repository', () async {
      int id = 2;

      final result = await getCurrentStarshipUseCase.call(params: id);
      final actualResult = result.data;

      debugPrint('$actualResult');
    });
  });

  group('list starships use case test', () {
    test('should call list starships method from repository', () async {
      int page = 1;

      final result = await listStarshipUseCase.call(params: page);
      final actualResult = result.data;

      debugPrint('$actualResult');
    });
  });
}
