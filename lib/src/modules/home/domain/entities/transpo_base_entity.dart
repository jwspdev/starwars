// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

abstract class TranspoBaseEntity extends Equatable {
  final String name;
  final String model;
  final String manufacturer;
  final double costInCredits;
  final double length;
  final double maxAtmosphericSpeed;
  final double crew;
  final double passengers;
  final double cargoCapacity;
  final double consumables;
  final List<PersonEntity> pilots;
  final List<FilmEntity> films;
  final String url;
  const TranspoBaseEntity({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmosphericSpeed,
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
        name,
        model,
        manufacturer,
        costInCredits,
        length,
        maxAtmosphericSpeed,
        crew,
        passengers,
        cargoCapacity,
        consumables,
        pilots,
        films,
        url
      ];
}
