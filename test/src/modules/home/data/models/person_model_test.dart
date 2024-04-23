//people model test

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
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

  //check if inherits personentity
  test('should be a subclass of person entity', () async {
    //assert
    expect(testPersonModel, isA<PersonEntity>());
  });

  //from json
  test('should be from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_person_response.json'));
    //act
    final result = Person.fromJson(jsonMap);
    //assert
    expect(result, equals(testPersonModel));
  });
}
