import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/source/remote_vehicle_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

import '../../../../../../../helpers/json_reader.dart';

void main() {
  late RemoteVehicleDataSourceImpl dataSource;
  setUp(() {
    initializeDependencies();
    dataSource = RemoteVehicleDataSourceImpl(apiService: sl());
  });
  const testVehicleModel = Vehicle(
      vehicleClass: "wheeled",
      name: "Sand Crawler",
      model: "Digger Crawler",
      manufacturer: "Corellia Mining Corporation",
      costInCredits: "150000",
      length: "36.8 ",
      maxAtmospheringSpeed: "30",
      crew: "46",
      passengers: "30",
      cargoCapacity: "50000",
      consumables: "2 months",
      pilots: [],
      films: [
        "https://swapi.py4e.com/api/films/1/",
        "https://swapi.py4e.com/api/films/5/"
      ],
      url: "https://swapi.py4e.com/api/vehicles/4/");
  const testVehicleEntity = VehicleEntity(
      vehicleClass: "wheeled",
      name: "Sand Crawler",
      model: "Digger Crawler",
      manufacturer: "Corellia Mining Corporation",
      costInCredits: "150000",
      length: "36.8 ",
      maxAtmospheringSpeed: "30",
      crew: "46",
      passengers: "30",
      cargoCapacity: "50000",
      consumables: "2 months",
      pilots: [],
      films: [
        "https://swapi.py4e.com/api/films/1/",
        "https://swapi.py4e.com/api/films/5/"
      ],
      url: "https://swapi.py4e.com/api/vehicles/4/");
  group('vehicle api data source test', () {
    final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/vehicle/dummy_vehicle_response.json'));
    final jsonResult = Vehicle.fromJson(jsonMap);

    test(
        'should call api and should be equal to test model and entity, and from dummy json model and toEntity',
        () async {
      //arrange
      int id = 4;

      //act
      final apiResult = await dataSource.getCurrentVehicle(id);
      final vehicleFromApi = apiResult.data;
      final vehicleFromApiToEntity = vehicleFromApi.toEntity();
      //assert
      expect(vehicleFromApi, equals(testVehicleModel));
      expect(vehicleFromApiToEntity, equals(testVehicleEntity));
      expect(vehicleFromApi, equals(jsonResult));
      expect(vehicleFromApiToEntity, equals(jsonResult.toEntity()));
    });
  });
  group('list vehicles data source test', () {
    final Map<String, dynamic> jsonMap = json.decode(readJson(
        'helpers/dummy_data/vehicle/dummy_list_vehicle_response.json'));
    final jsonResult = ListVehicleResponse.fromJson(jsonMap);

    test('should call api and check if result is equal to dummy json',
        () async {
      //act
      int page = 1;
      //act
      final apiResult = await dataSource.listVehicles(page);

      final listFromApi = apiResult.data;
      final listFromApiToEntity = listFromApi.toEntity();
      //assert
      expect(listFromApi, equals(jsonResult));
      expect(listFromApiToEntity, equals(jsonResult.toEntity()));
    });
  });
}
