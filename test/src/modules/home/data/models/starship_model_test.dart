import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/transpo_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  const testStarshipModel = StarshipEntity(
      hyperdriveRating: '2.0',
      mglt: '60',
      starshipClass: "corvette",
      name: "CR90 corvette",
      model: "CR90 corvette",
      manufacturer: "Corellian Engineering Corporation",
      costInCredits: "3500000",
      length: "150",
      maxAtmospheringSpeed: "950",
      crew: "30-165",
      passengers: "600",
      cargoCapacity: "3000000",
      consumables: "1 year",
      pilots: [],
      films: [
        "https://swapi.py4e.com/api/films/1/",
        "https://swapi.py4e.com/api/films/3/",
        "https://swapi.py4e.com/api/films/6/"
      ],
      url: "https://swapi.py4e.com/api/starships/2/");
  //check if inherits base transpo and starship entity
  group('test starship inheritance\n\t', () {
    test('should be a subclass of starship entity', () {
      expect(testStarshipModel, isA<StarshipEntity>());
    });

    test('should be a sub-subclass of transpo base entity', () {
      expect(testStarshipModel, isA<TranspoBaseEntity>());
    });
  });

  group('test from json\n\t', () {
    test('should be starship from json', () {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/starship/dummy_starship_response.json'));
      //act
      final jsonResult = Starship.fromJson(jsonMap).toEntity();
      //assert
      debugPrint('$jsonResult');
      expect(jsonResult, equals(testStarshipModel));
    });
  });
}
