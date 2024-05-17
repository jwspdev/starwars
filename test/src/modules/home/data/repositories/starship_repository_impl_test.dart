import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  late RemoteStarshipDataSourceImpl remoteStarshipDataSourceImpl;
  setUp(() {
    initializeDependencies();
    remoteStarshipDataSourceImpl =
        RemoteStarshipDataSourceImpl(apiService: sl());
  });

  group('starship repository test: get list starships response\n\t', () {
    //check if returned values is of corrent type
    test('should return listStarshipResponse', () async {
      //arrange
      int pageNumber = 1;
      //act
      final result =
          await remoteStarshipDataSourceImpl.listStarships(pageNumber);
      debugPrint('${result.data}');
      //assert
      expect(result.data, isA<ListStarshipsResponse>());
    });
    //check if returned values is same as dummy list of data
    test('should be same as converted dummy list of starships response data',
        () async {
      //arrange
      int pageNumber = 1;
      final Map<String, dynamic> jsonMap = json.decode(readJson(
          'helpers/dummy_data/starship/dummy_list_starships_response.json'));
      //act
      final jsonResult = ListStarshipsResponse.fromJson(jsonMap).toEntity();
      final result =
          await remoteStarshipDataSourceImpl.listStarships(pageNumber);
      final actualResult = result.data.toEntity();
      //assert
      expect(actualResult, equals(jsonResult));
    });
  });

  group('starship repository test: get current starship\n\t', () {
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
    //check if dummy starship json file is equalt to returned data
    test('should be the same as test starship model', () async {
      int id = 2;

      final result = await remoteStarshipDataSourceImpl.getCurrentStarship(id);
      final actualResult = result.data.toEntity();

      expect(actualResult, equals(testStarshipModel));
    });
    //check if test starship model is equal to returned data
    test('should be the same as starship_dummy_data.json', () async {
      final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/starship/dummy_starship_response.json'));
      int id = 2;

      final jsonResult = Starship.fromJson(jsonMap).toEntity();
      final apiResult =
          await remoteStarshipDataSourceImpl.getCurrentStarship(id);
      final actualResult = apiResult.data.toEntity();

      expect(actualResult, equals(jsonResult));
    });
  });
}
