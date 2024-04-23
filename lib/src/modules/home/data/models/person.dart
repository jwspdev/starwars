import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

class Person extends PersonEntity {
  const Person(
      {required String name,
      required double height,
      required double mass,
      required String hairColor,
      required String skinColor,
      required String eyeColor,
      required String birthYear,
      required String gender,
      List<String>? films,
      List<String>? vehicles,
      List<String>? starships,
      required String url})
      : super(
            name: name,
            height: height,
            mass: mass,
            hairColor: hairColor,
            skinColor: skinColor,
            eyeColor: eyeColor,
            birthYear: birthYear,
            gender: gender,
            films: films,
            vehicles: vehicles,
            starships: starships,
            url: url);
  factory Person.fromJson(Map<String, dynamic> json) => Person(
      name: json['name'],
      height: double.parse(json['height']),
      mass: double.parse(json['mass'] ?? '0'),
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      films:
          (json['films'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      starships: (json['starships'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      url: json['url']);

  PersonEntity toEntity() => PersonEntity(
      name: name,
      height: height,
      mass: mass,
      hairColor: hairColor,
      skinColor: skinColor,
      eyeColor: eyeColor,
      birthYear: birthYear,
      gender: gender,
      films: films,
      vehicles: vehicles,
      starships: starships,
      url: url);
}
