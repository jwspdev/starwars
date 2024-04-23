import 'package:star_wars_app/src/modules/home/domain/entities/transpo_base_entity.dart';

class VehicleEntity extends TranspoBaseEntity {
  final String vehicleClass;
  const VehicleEntity(
      {required this.vehicleClass,
      required super.name,
      required super.model,
      required super.manufacturer,
      required super.costInCredits,
      required super.length,
      required super.maxAtmosphericSpeed,
      required super.crew,
      required super.passengers,
      required super.cargoCapacity,
      required super.consumables,
      required super.pilots,
      required super.films,
      required super.url});
  @override
  List<Object?> get props => super.props..add(vehicleClass);
}