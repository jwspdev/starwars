import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/get_current_vehicle_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/list_vehicles_use_case.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final GetCurrentVehicleUseCase _getCurrentVehicleUseCase;
  // ignore: unused_field
  final ListVehiclesUseCase _listVehiclesUseCase;
  VehicleBloc(this._getCurrentVehicleUseCase, this._listVehiclesUseCase)
      : super(VehicleInitial()) {
    on<VehicleEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnGetVehiclesByIds>(_onGetVehiclesByIds);
  }
  _onGetVehiclesByIds(
      OnGetVehiclesByIds event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    List<int> ids = [];
    List<VehicleEntity> vehicleList = [];
    Exception? exception;
    debugPrint('${event.vehicleUrls}');
    if (event.vehicleUrls.isEmpty) {
      emit(const VehicleByIdsLoaded(vehicles: []));
      return;
    }
    for (var vehicle in event.vehicleUrls) {
      var currentId = int.parse(vehicle.getIdFromUrl());
      ids.add(currentId);
    }
    for (var id in ids) {
      final result = await _getCurrentVehicleUseCase(params: id);
      if (result is DataSuccess) {
        vehicleList.add(result.data);
      }
      if (result is DataFailure) {
        exception = result.exception;
      }
    }
    if (exception != null) {
      emit(VehicleError(exception: exception));
    }
    emit(VehicleByIdsLoaded(vehicles: vehicleList));
  }
}
