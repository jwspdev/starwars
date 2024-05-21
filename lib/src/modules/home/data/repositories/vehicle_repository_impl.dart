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
import 'package:http/http.dart' as http;

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
        ListVehicleResponse data = response.data;
        await Future.forEach(data.results, (vehicle) async {
          var imageUrl =
              'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/${vehicle.uniqueId}.jpeg?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
          final response = await http.head(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            vehicle.imageUrl = imageUrl;
          }
        });
        return DataSuccess(data.toEntity());
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
