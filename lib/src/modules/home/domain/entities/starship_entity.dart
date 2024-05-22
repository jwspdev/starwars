import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/transpo_base_entity.dart';

class StarshipEntity extends TranspoBaseEntity {
  final String hyperdriveRating;
  final String mglt;
  final String starshipClass;
  const StarshipEntity({
    required this.hyperdriveRating,
    required this.mglt,
    required this.starshipClass,
    super.uniqueId,
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

  StarshipEntity copyWith({String? imageUrl}) {
    return StarshipEntity(
        hyperdriveRating: hyperdriveRating,
        mglt: mglt,
        starshipClass: starshipClass,
        uniqueId: uniqueId,
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
  List<Object?> get props =>
      super.props..add([hyperdriveRating, mglt, starshipClass]);
}
