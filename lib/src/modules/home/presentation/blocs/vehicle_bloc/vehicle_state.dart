part of 'vehicle_bloc.dart';

sealed class VehicleState extends Equatable {
  final List<VehicleEntity> result;
  const VehicleState({required this.result});

  @override
  List<Object> get props => [result];
}

final class VehicleInitial extends VehicleState {
  VehicleInitial() : super(result: []);
}

final class VehicleLoading extends VehicleState {
  VehicleLoading() : super(result: []);
}

final class VehicleByIdsLoaded extends VehicleState {
  final List<VehicleEntity>? vehicles;

  VehicleByIdsLoaded({this.vehicles}) : super(result: []);

  @override
  List<Object> get props => [vehicles ?? []];
}

final class VehicleError extends VehicleState {
  final Exception exception;
  VehicleError({required this.exception}) : super(result: []);
  @override
  List<Object> get props => [exception];
}

final class VehiclesLoaded extends VehicleState {
  // final ListVehicleResponseEntity result;

  const VehiclesLoaded({required super.result});
  @override
  List<Object> get props => [result];
}

final class LoadMoreVehicles extends VehicleState {
  const LoadMoreVehicles({required super.result});
  @override
  List<Object> get props => [result];
}
