import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

// ignore: must_be_immutable
class Person extends PersonEntity {
  const Person(
      {super.uniqueId,
      required super.name,
      required super.height,
      required super.mass,
      required super.hairColor,
      required super.skinColor,
      required super.eyeColor,
      required super.birthYear,
      required super.gender,
      super.films,
      super.vehicles,
      super.starships,
      required super.url,
      super.imageUrl});
  factory Person.fromJson(Map<String, dynamic> json) {
    String id = json['url'].toString().getIdFromUrl();
    String uniqueId = "person_$id";
    var imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/$uniqueId.jpeg?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
    return Person(
        uniqueId: uniqueId,
        name: json['name'],
        height: json['height'],
        mass: json['mass'] ?? '0',
        hairColor: json['hair_color'],
        skinColor: json['skin_color'],
        eyeColor: json['eye_color'],
        birthYear: json['birth_year'],
        gender: json['gender'],
        films: (json['films'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        vehicles: (json['vehicles'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        starships: (json['starships'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        url: json['url'],
        imageUrl: imageUrl);
  }
  PersonEntity toEntity() => PersonEntity(
      uniqueId: uniqueId,
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
      url: url,
      imageUrl: imageUrl);
}
