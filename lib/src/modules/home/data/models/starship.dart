import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

class Starship extends StarshipEntity {
  const Starship(
      {super.uniqueId,
      required super.hyperdriveRating,
      required super.mglt,
      required super.starshipClass,
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
      super.imageUrl});

  //from json mapper
  factory Starship.fromJson(Map<String, dynamic> json) {
    String id = json['url'].toString().getIdFromUrl();
    String uniqueId = "starship_$id";
    return Starship(
        uniqueId: uniqueId,
        hyperdriveRating: json['hyperdrive_rating'],
        mglt: json['MGLT'],
        starshipClass: json['starship_class'],
        name: json['name'],
        model: json['model'],
        manufacturer: json['manufacturer'],
        costInCredits: json['cost_in_credits'],
        length: json['length'],
        maxAtmospheringSpeed: json['max_atmosphering_speed'],
        crew: json['crew'],
        passengers: json['passengers'],
        cargoCapacity: json['cargo_capacity'],
        consumables: json['consumables'],
        pilots: (json['pilots'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        films: (json['films'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        url: json['url']);
  }

  //to entity converter
  StarshipEntity toEntity() => StarshipEntity(
      uniqueId: uniqueId,
      hyperdriveRating: hyperdriveRating,
      mglt: mglt,
      starshipClass: starshipClass,
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
      url: url);
}
