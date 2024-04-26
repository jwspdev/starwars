import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/service/remote_film_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/source/remote_film_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/film.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_films_response.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';

void main() {
  late RemoteFilmApiService filmApiService;
  late RemoteFilmDataSource remoteFilmDataSource;
  setUp(() {
    initializeDependencies();
    filmApiService = RemoteFilmApiService(sl());
    remoteFilmDataSource = RemoteFilmDataSourceImpl(apiService: sl());
  });
  group('test api service calls', () {
    test('should return current film', () async {
      //arrange
      int id = 1;
      //act
      final result = await filmApiService.getCurrentFilm(id);
      debugPrint('${result.data}');
      //assert
      expect(result.data, isA<Film>());
      expect(result.data, isA<FilmEntity>());
    });
    test('should return list film response', () async {
      int page = 1;
      final result = await filmApiService.listFilms(page);
      // debugPrint('${result.data.runtimeType}');
      expect(result.data, isA<ListFilmsResponseEntity>());
      expect(result.data, isA<ListFilmsResponse>());
    });
  });
  group('test data source calls', () {
    test('should call api service\'s method getcurrentfilm', () async {
      int id = 1;
      final result = await remoteFilmDataSource.getCurrentFilm(id);
      debugPrint('${result.data}');
      expect(result.data, isA<Film>());
      expect(result.data.toEntity(), isA<FilmEntity>());
    });
    test('should call api service\'s method list films', () async {
      int pageNumber = 1;
      final result = await remoteFilmDataSource.listFilms(pageNumber);
      debugPrint('${result.data}');
      expect(result.data, isA<ListFilmsResponse>());
      expect(result.data.toEntity(), isA<ListFilmsResponseEntity>());
    });
  });
}
