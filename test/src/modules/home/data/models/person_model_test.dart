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
      url: 'https://swapi.py4e.com/api/people/1/');

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
