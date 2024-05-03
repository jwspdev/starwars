part of 'vehicle_bloc.dart';

sealed class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class OnVehiclePageChanged extends VehicleEvent {
  final int pageNumber;
  const OnVehiclePageChanged({required this.pageNumber});
  @override
  List<Object> get props => [pageNumber];
}

class OnCurrentVehicleIdChanged extends VehicleEvent {
  final int id;

  const OnCurrentVehicleIdChanged({required this.id});
  @override
  List<Object> get props => [id];
}

class OnGetVehiclesByIds extends VehicleEvent {
  final List<String> vehicleUrls;

  const OnGetVehiclesByIds({required this.vehicleUrls});
  @override
  List<Object> get props => [vehicleUrls];
}
