//tests vehicle's inheritance, if value is the same as created dummy model and entity, and if dummy json file returns correct values
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/transpo_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  var testVehicleModel = Vehicle(
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

  var testVehicleEntity = VehicleEntity(
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

  group('vehicle model test group', () {
    final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/vehicle/dummy_vehicle_response.json'));
    final jsonResult = Vehicle.fromJson(jsonMap);
    test(
        'should be inherited by vehicle entity and should be sub-subclass of transpo',
        () {
      expect(testVehicleModel, isA<VehicleEntity>());
      expect(testVehicleModel, isA<TranspoBaseEntity>());
    });

    test('should be equal to fromJson(dummy_vehicle_json)', () {
      //assert
      debugPrint('$jsonResult');
      expect(testVehicleModel, equals(jsonResult));
    });
    test('should be equal to fromJson(dummy_vehicle_json).toEntity()', () {
      //arrange
      final vehicleEntityFromJson = jsonResult.toEntity();
      //assert
      debugPrint('$vehicleEntityFromJson');
      expect(testVehicleEntity, equals(vehicleEntityFromJson));
    });
  });
  group('list vehicle models test group', () {
    final Map<String, dynamic> jsonMap = json.decode(readJson(
        'helpers/dummy_data/vehicle/dummy_list_vehicle_response.json'));
    final jsonResult = ListVehicleResponse.fromJson(jsonMap);
    test('should be inherited by list vehicle response entity', () {
      expect(jsonResult, isA<ListVehicleResponseEntity>());
    });
  });
}
