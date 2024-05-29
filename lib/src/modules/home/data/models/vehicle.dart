import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

class Vehicle extends VehicleEntity {
  const Vehicle(
      {super.uniqueId,
      required super.vehicleClass,
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
  //from Json Mapper
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    String id = json['url'].toString().getIdFromUrl();
    String uniqueId = "vehicle_$id";
    var imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/$uniqueId.png?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
    return Vehicle(
        uniqueId: uniqueId,
        vehicleClass: json['vehicle_class'] ?? '',
        name: json['name'] ?? '',
        model: json['model'] ?? '',
        manufacturer: json['manufacturer'] ?? '',
        costInCredits: json['cost_in_credits'] ?? '',
        length: json['length'] ?? '',
        maxAtmospheringSpeed: json['max_atmosphering_speed'] ?? '',
        crew: json['crew'] ?? '',
        passengers: json['passengers'] ?? '',
        cargoCapacity: json['cargo_capacity'] ?? '',
        consumables: json['consumables'] ?? '',
        pilots: (json['pilots'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        films: (json['films'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        url: json['url'] ?? '',
        imageUrl: imageUrl);
  }
  //to entity converter
  VehicleEntity toEntity() => VehicleEntity(
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
      imageUrl: imageUrl);
}
