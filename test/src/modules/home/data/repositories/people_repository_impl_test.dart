import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

void main() {
  late RemotePeopleDataSourceImpl dataSource;
  late PeopleRepositoryImpl peopleRepositoryImpl;
  late Dio dio;
  late RemotePeopleApiService apiService;
  setUp(() {
    dio = Dio();
    apiService = RemotePeopleApiService(dio);
    dataSource = RemotePeopleDataSourceImpl(apiService: apiService);
    peopleRepositoryImpl = PeopleRepositoryImpl(dataSource);
  });

  const testPersonModel = Person(
    name: "Luke Skywalker",
    height: 172,
    mass: 77,
    hairColor: "blond",
    skinColor: "fair",
    eyeColor: 'blue',
    birthYear: '19BBY',
    gender: 'male',
    url: 'https://swapi.py4e.com/api/people/1/',
    films: [
      "https://swapi.py4e.com/api/films/1/",
      "https://swapi.py4e.com/api/films/2/",
      "https://swapi.py4e.com/api/films/3/",
      "https://swapi.py4e.com/api/films/6/",
      "https://swapi.py4e.com/api/films/7/"
    ],
    vehicles: [
      "https://swapi.py4e.com/api/vehicles/14/",
      "https://swapi.py4e.com/api/vehicles/30/"
    ],
    starships: [
      "https://swapi.py4e.com/api/starships/12/",
      "https://swapi.py4e.com/api/starships/22/"
    ],
  );

  const testPersonEntity = PersonEntity(
    name: "Luke Skywalker",
    height: 172,
    mass: 77,
    hairColor: "blond",
    skinColor: "fair",
    eyeColor: 'blue',
    birthYear: '19BBY',
    gender: 'male',
    url: 'https://swapi.py4e.com/api/people/1/',
    films: [
      "https://swapi.py4e.com/api/films/1/",
      "https://swapi.py4e.com/api/films/2/",
      "https://swapi.py4e.com/api/films/3/",
      "https://swapi.py4e.com/api/films/6/",
      "https://swapi.py4e.com/api/films/7/"
    ],
    vehicles: [
      "https://swapi.py4e.com/api/vehicles/14/",
      "https://swapi.py4e.com/api/vehicles/30/"
    ],
    starships: [
      "https://swapi.py4e.com/api/starships/12/",
      "https://swapi.py4e.com/api/starships/22/"
    ],
  );

  group('get current person', () {
    test('should return current person when data source is successful!',
        () async {
      //arrange
      int id = 1;
      //act
      final result = await peopleRepositoryImpl.getCurrentPerson(id);
      debugPrint('${result.data.runtimeType}, ${testPersonModel.runtimeType}');
      //assert
      expect(result.data, equals(testPersonEntity));
    });
  });
}
