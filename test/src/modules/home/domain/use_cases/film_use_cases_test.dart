import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/get_current_film_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/list_films_use_case.dart';

void main() {
  late GetCurrentFilmUseCase getCurrentFilmUseCase;
  late ListFilmUseCase listFilmUseCase;
  setUp(() {
    initializeDependencies();
    getCurrentFilmUseCase = GetCurrentFilmUseCase(sl());
    listFilmUseCase = ListFilmUseCase(sl());
  });
  test('should call api method get current film', () async {
    int id = 1;
    final result = await getCurrentFilmUseCase(params: id);
    expect(result.data, isA<FilmEntity>());
  });
  test('should call api method get list of films reponse', () async {
    int pageNumber = 1;
    final result = await listFilmUseCase(params: pageNumber);
    expect(result.data, isA<ListFilmsResponseEntity>());
  });
}
