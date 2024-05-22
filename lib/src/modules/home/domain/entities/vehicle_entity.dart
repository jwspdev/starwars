import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/transpo_base_entity.dart';

class VehicleEntity extends TranspoBaseEntity {
  final String? vehicleClass;
  const VehicleEntity({
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
  VehicleEntity copyWith({String? imageUrl}) {
    return VehicleEntity(
        uniqueId: uniqueId,
        vehicleClass: vehicleClass,
        name: name,
        model: model,
        manufacturer: manufacturer,
        costInCredits: costInCredits,
        length: length,
        maxAtmospheringSpeed: maxAtmospheringSpeed,
        crew: crew,
        passengers: passengers,
        cargoCapacity: cargoCapacity,
        consumables: consumables,
        pilots: pilots,
        films: films,
        url: url,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  @override
  List<Object?> get props => super.props..add(vehicleClass);
}
