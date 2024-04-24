// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/source/remote_vehicle_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/vehicle_repository.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final RemoteVehicleDataSourceImpl _remoteVehicleDataSourceImpl;
  VehicleRepositoryImpl(this._remoteVehicleDataSourceImpl);
  @override
  Future<DataState<VehicleEntity>> getCurrentVehicle(int id) async {
    try {
      final HttpResponse<Vehicle> response =
          await _remoteVehicleDataSourceImpl.getCurrentVehicle(id);
      if (response.response.statusCode == HttpStatus.ok) {
        final vehicleResponse = response.data;
        return DataSuccess(vehicleResponse.toEntity());
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }

  @override
  Future<DataState<ListVehicleResponseEntity>> listVehicles(
      int pageNumber) async {
    try {
      final HttpResponse<ListVehicleResponse> response =
          await _remoteVehicleDataSourceImpl.listVehicles(pageNumber);
      if (response.response.statusCode == HttpStatus.ok) {
        final listVehicleResponse = response.data;
        return DataSuccess(listVehicleResponse.toEntity());
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }
}
