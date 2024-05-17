import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';

@Entity(tableName: PERSON_TABLE_NAME)
class PersonEntity extends Equatable {
  @PrimaryKey()
  final String? uniqueId;

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
  final String? imageUrl;

  const PersonEntity({
    this.uniqueId,
    required this.name,
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
    required this.url,
    this.imageUrl,
  });
  @override
  List<Object?> get props => [
        uniqueId,
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
        url,
        imageUrl,
      ];
}
