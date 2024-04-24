import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

abstract class VehicleRepository {
  //get current vehicle
  Future<DataState<VehicleEntity>> getCurrentVehicle(int id);
  //list vehicles
  Future<DataState<ListVehicleResponseEntity>> listVehicles(int pageNumber);
}
