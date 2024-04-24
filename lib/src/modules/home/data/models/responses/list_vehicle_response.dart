import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

class ListVehicleResponse extends ListVehicleResponseEntity {
  const ListVehicleResponse(
      {required super.count,
      super.next,
      super.previous,
      required super.results});

  //json mapper
  factory ListVehicleResponse.fromJson(Map<String, dynamic> json) {
    List<VehicleEntity> results = [];
    for (var vehicle in json['results']) {
      results.add(Vehicle.fromJson(vehicle).toEntity());
    }
    return ListVehicleResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: results,
    );
  }
  //to entity converter
  ListVehicleResponseEntity toEntity() => ListVehicleResponseEntity(
      count: count, next: next, previous: previous, results: results);
}
