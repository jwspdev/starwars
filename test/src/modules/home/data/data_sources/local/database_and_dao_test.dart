import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/database.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/film_dao.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/person_dao.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

void main() {
  late AppDatabase database;
  late PersonDao personDao;
  late FilmDao filmDao;
  setUp(() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    personDao = database.personDao;
    filmDao = database.filmDao;
  });
  test('test database', () {
    debugPrint('${database.database}');
  });

  test('test dao', () async {
    // final
    var person = const PersonEntity(
        uniqueId: 'person/125',
        name: 'test name',
        height: '12',
        mass: '12',
        hairColor: 'blonde',
        skinColor: 'fair',
        eyeColor: 'green',
        birthYear: '19BBY',
        gender: 'male',
        url: 'test_url',
        films: ['test', 'test2', 'test3']);
    await personDao.insertPerson(person);
  });

  group('test local film\n', () {
    FilmEntity filmEntity = const FilmEntity(
        uniqueId: 'id1',
        title: 'UNA',
        episodeId: 4,
        openingCrawl: 'openingCrawl',
        director: 'director',
        producer: 'producer',
        releaseDate: 'releaseDate',
        url: 'url',
        rank: 2,
        characters: ['test char1', 'test char2']);
    FilmEntity filmEntity2 = const FilmEntity(
        uniqueId: 'id2',
        title: 'pangalawa',
        rank: 1,
        episodeId: 4,
        openingCrawl: 'openingCrawl',
        director: 'director',
        producer: 'producer',
        releaseDate: 'releaseDate',
        url: 'url',
        characters: ['test char1', 'test char2']);
    List<FilmEntity> films = [filmEntity, filmEntity2];
    test('should print database instance', () {
      debugPrint('${database.database}');
    });

    test('should return and print dao.getallfilms', () async {
      final result = await filmDao.getAllFilms();
      debugPrint('$result');
    });
    test('should insert film', () async {
      await filmDao.insertListOfPeople(films);
      final output = await filmDao.getAllFilms();
      debugPrint('$output');
    });
    test('should return list of film entities ordered by rank', () async {
      final result = await filmDao.getOrderedFilms('DESC');
      debugPrint('$result');
    });
    test('should delete all films', () async {
      await filmDao.deleteAllRecords();
    });
    test('should update ranks of films', () async {
      // List<FilmEntity> newFilms = [];
      for (var film in films) {
        film.copyWith(rank: 5);
        // if (!newFilms.contains(film)) {
        //   newFilms.add(film);
        // }
        // debugPrint('${film.title}');
      }

      await filmDao.updateFilmEntities(films);
      final result = await filmDao.getOrderedFilms('DESC');
      for (var res in result) {
        debugPrint('${res.rank}');
      }
    });
    test('should update a single note', () async {
      FilmEntity film = filmEntity;
      film.copyWith(rank: 5);
      debugPrint('$film');
      await filmDao.updateFilm(film);
      final result = await filmDao.findFilmById('id1');
      debugPrint('$result');
    });
  });
}
