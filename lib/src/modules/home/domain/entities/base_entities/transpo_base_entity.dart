// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class TranspoBaseEntity extends Equatable {
  final String? uniqueId;
  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String maxAtmospheringSpeed;
  final String crew;
  final String passengers;
  final String cargoCapacity;
  final String consumables;
  final List<String>? pilots;
  final List<String>? films;
  final String url;
  const TranspoBaseEntity({
    this.uniqueId,
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmospheringSpeed,
    required this.crew,
    required this.passengers,
    required this.cargoCapacity,
    required this.consumables,
    required this.pilots,
    required this.films,
    required this.url,
  });

  @override
  List<Object?> get props => [
        uniqueId,
        name,
        model,
        manufacturer,
        costInCredits,
        length,
        maxAtmospheringSpeed,
        crew,
        passengers,
        cargoCapacity,
        consumables,
        pilots,
        films,
        url
      ];
}
