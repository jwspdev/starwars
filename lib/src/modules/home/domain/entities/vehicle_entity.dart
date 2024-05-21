import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/transpo_base_entity.dart';

class VehicleEntity extends TranspoBaseEntity {
  final String? vehicleClass;
  VehicleEntity({
    super.uniqueId,
    required this.vehicleClass,
    required super.name,
    required super.model,
    required super.manufacturer,
    required super.costInCredits,
    required super.length,
    required super.maxAtmospheringSpeed,
    required super.crew,
    required super.passengers,
    required super.cargoCapacity,
    required super.consumables,
    required super.pilots,
    required super.films,
    required super.url,
    super.imageUrl,
  });
  @override
  List<Object?> get props => super.props..add(vehicleClass);
}
