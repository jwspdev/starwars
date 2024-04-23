import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final String name;
  final double height;
  final double mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final List<String>? films;
  final List<String>? vehicles;
  final List<String>? starships;
  final String url;

  const PersonEntity(
      {required this.name,
      required this.height,
      required this.mass,
      required this.hairColor,
      required this.skinColor,
      required this.eyeColor,
      required this.birthYear,
      required this.gender,
      this.films,
      this.vehicles,
      this.starships,
      required this.url});
  @override
  List<Object?> get props => [
        name,
        height,
        mass,
        hairColor,
        eyeColor,
        birthYear,
        gender,
        films,
        vehicles,
        starships,
        url
      ];
}
