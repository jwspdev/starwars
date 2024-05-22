import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/database.dart';
import 'package:star_wars_app/src/modules/liked/data/repositories/local/film_local_repository_impl.dart';
import 'package:star_wars_app/src/modules/liked/data/repositories/local/people_local_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

void main() {
  late AppDatabase appDatabase;
  late PeopleLocalRepositoryImpl repositoryImpl;
  late FilmLocalRepositoryImpl filmRepo;
  setUp(() async {
    appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    repositoryImpl = PeopleLocalRepositoryImpl(appDatabase);
    filmRepo = FilmLocalRepositoryImpl(appDatabase);
  });

  group('test repository methods\n', () {
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
    var person2 = const PersonEntity(
        uniqueId: 'person/126',
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
    test('should insert a person entity to database', () async {
      await repositoryImpl.insertPerson(person2);
    });
    test('should return a list of person entities', () async {
      final result = await repositoryImpl.getAllPeople();
      debugPrint('$result');
    });
    test('should delete a person entity', () async {
      await repositoryImpl.deletePerson(person);
    });
    test('should return a single person entity by uniqueid', () async {
      final result = await repositoryImpl.findPersonById('person/125');
      debugPrint('$result');
    });
  });
  group('test film repository impl', () {
    FilmEntity filmEntity = const FilmEntity(
        uniqueId: 'film/1',
        title: 'test title',
        episodeId: 4,
        openingCrawl: 'openingCrawl',
        director: 'director',
        producer: 'producer',
        releaseDate: 'releaseDate',
        url: 'url',
        characters: ['test char1', 'test char2']);
    FilmEntity filmEntity2 = const FilmEntity(
        uniqueId: 'film/2',
        title: 'test title',
        episodeId: 4,
        openingCrawl: 'openingCrawl',
        director: 'director',
        producer: 'producer',
        releaseDate: 'releaseDate',
        url: 'url',
        characters: ['test char1', 'test char2']);
    List<FilmEntity> films = [filmEntity, filmEntity2];
    test('should use film dao\'s get all films', () async {
      final result = await filmRepo.getAllFilms();
      debugPrint('$result');
    });
    test('should use film dao\'s insert films', () async {
      await filmRepo.insertListOfFilms(films);
      final result = await filmRepo.getAllFilms();
      debugPrint('$result');
    });
    test('should use film dao\'s get film by id', () async {
      String uniqueId = 'film/1';
      final result = await filmRepo.findFilmById(uniqueId);
      debugPrint('$result');
    });
  });
}
