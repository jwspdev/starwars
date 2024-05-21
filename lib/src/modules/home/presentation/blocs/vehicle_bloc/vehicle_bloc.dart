import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/get_current_vehicle_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/list_vehicles_use_case.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final GetCurrentVehicleUseCase _getCurrentVehicleUseCase;
  final ListVehiclesUseCase _listVehiclesUseCase;
  int page = 1;
  bool canLoadMore = true;
  ScrollController scrollController = ScrollController();
  VehicleBloc(this._getCurrentVehicleUseCase, this._listVehiclesUseCase)
      : super(VehicleInitial()) {
    scrollController.addListener(() {
      add(const OnLoadMoreVehicles());
    });
    on<VehicleEvent>((event, emit) {});
    on<OnGetVehiclesByIds>(_onGetVehiclesByIds);
    on<OnVehiclePageChanged>(_onVehiclePageChanged);
    on<OnLoadMoreVehicles>(_onLoadMoreVehicles);
  }

  _onVehiclePageChanged(
      OnVehiclePageChanged event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final result = await _listVehiclesUseCase.call(params: page);
    if (result is DataSuccess) {
      emit(VehiclesLoaded(
        result: result.data.results,
      ));
    }
    if (result is DataFailure) {
      emit(VehicleError(exception: result.exception!));
    }
  }

  _onLoadMoreVehicles(
      OnLoadMoreVehicles event, Emitter<VehicleState> emit) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        canLoadMore) {
      emit(LoadMoreVehicles(
        result: state.result,
      ));
      await Future.delayed(const Duration(seconds: 2));
      page++;

      final result = await _listVehiclesUseCase.call(params: page);
      if (result is DataSuccess) {
        ListVehicleResponseEntity? listVehicleResponseEntity = result.data;
        List<VehicleEntity> vehicleList =
            listVehicleResponseEntity?.results ?? [];

        debugPrint('${listVehicleResponseEntity?.next}');

        emit(VehiclesLoaded(
          result: [...state.result, ...vehicleList],
        ));
        canLoadMore = listVehicleResponseEntity?.next != null;
      }
      // emit(VehiclesLoaded(result: result.data.results));
    }
  }

  _onGetVehiclesByIds(
      OnGetVehiclesByIds event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    List<int> ids = [];
    List<VehicleEntity> vehicleList = [];
    Exception? exception;
    debugPrint('${event.vehicleUrls}');
    if (event.vehicleUrls.isEmpty) {
      emit(VehicleByIdsLoaded(vehicles: const []));
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
