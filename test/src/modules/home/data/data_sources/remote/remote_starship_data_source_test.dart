import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';

void main() {
  late RemoteStarshipDataSourceImpl dataSource;
  setUp(() {
    initializeDependencies();
    dataSource = RemoteStarshipDataSourceImpl(apiService: sl());
  });

  //starship api call tests
  group('starship api data source test', () {
    var testStarshipModel = const Starship(
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
    test('should return list of starship response', () async {
      //arrange
      int page = 1;
      //act
      final result = await dataSource.listStarships(page);
      //assert
      debugPrint('COUNT: ${result.data.count}');
      debugPrint('NEXT: ${result.data.next}');
      debugPrint('PREVIOUS: ${result.data.previous}');
      for (var starship in result.data.results) {
        debugPrint('$starship');
      }
      //assert
      expect(result.data, isA<ListStarshipsResponse>());
      expect(result.data, isA<ListStarshipsResponseEntity>());
    });
    test('should return starship model', () async {
      //arrange
      int id = 2;
      //act
      final apiResult = await dataSource.getCurrentStarship(id);
      final apiStarshipResult = apiResult.data;
      final apiStarshipResultEntity = apiStarshipResult.toEntity();
      //assert
      expect(apiStarshipResult, equals(testStarshipModel));
      expect(apiStarshipResultEntity, equals(testStarshipModel.toEntity()));
    });
  });
}
