import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/film_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/film_repository.dart';

void main() {
  late FilmRepository filmRepository;
  setUp(() {
    initializeDependencies();
    filmRepository = FilmRepositoryImpl(remoteFilmDataSource: sl());
  });
  group('test repository methods', () {
    test('should call data source and return current film', () async {
      int id = 1;
      final result = await filmRepository.getCurrentFilm(id);
      expect(result.data, isA<FilmEntity>());
    });
    test('should call data source and return list of films', () async {
      int pageNumber = 1;
      final result = await filmRepository.listFilms(pageNumber);
      expect(result.data, isA<ListFilmsResponseEntity>());
    });
  });
}
