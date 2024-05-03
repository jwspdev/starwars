part of 'vehicle_bloc.dart';

sealed class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

final class VehicleInitial extends VehicleState {}

final class VehicleLoading extends VehicleState {}

final class VehicleByIdsLoaded extends VehicleState {
  final List<VehicleEntity>? vehicles;

  const VehicleByIdsLoaded({this.vehicles});

  @override
  List<Object> get props => [vehicles ?? []];
}

final class VehicleError extends VehicleState {
  final Exception exception;
  const VehicleError({required this.exception});
  @override
  List<Object> get props => [exception];
}
