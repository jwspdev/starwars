// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:retrofit/dio.dart';

import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/service/remote_vehicle_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';

abstract class RemoteVehicleDataSource {
  Future<HttpResponse<ListVehicleResponse>> listVehicles(
    int pageNumber,
  );
  Future<HttpResponse<Vehicle>> getCurrentVehicle(int id);
}

class RemoteVehicleDataSourceImpl implements RemoteVehicleDataSource {
  RemoteVehicleApiService apiService;
  RemoteVehicleDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<HttpResponse<Vehicle>> getCurrentVehicle(int id) {
    return apiService.getCurrentVehicle(id);
  }

  @override
  Future<HttpResponse<ListVehicleResponse>> listVehicles(int pageNumber) {
    return apiService.listVehicles(pageNumber);
  }
}
