import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

// ignore: must_be_immutable
class Film extends FilmEntity {
  const Film({
    super.uniqueId,
    required super.title,
    required super.episodeId,
    required super.openingCrawl,
    required super.director,
    required super.producer,
    required super.releaseDate,
    super.characters,
    required super.url,
    super.imageUrl,
    super.rank,
  });

  //from json mapper
  factory Film.fromJson(Map<String, dynamic> json) {
    String id = json['url'].toString().getIdFromUrl();
    String uniqueId = "film_$id";
    var imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/$uniqueId.jpeg?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
    return Film(
        uniqueId: uniqueId,
        title: json['title'] ?? '',
        episodeId: json['episode_id'] ?? 0,
        openingCrawl: json['opening_crawl'] ?? '',
        director: json['director'] ?? '',
        producer: json['producer'] ?? '',
        releaseDate: json['release_date'] ?? '',
        characters: (json['characters'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        url: json['url'] ?? '',
        imageUrl: imageUrl);
  }
  //to entity converter
  FilmEntity toEntity() => FilmEntity(
        uniqueId: uniqueId,
        title: title,
        episodeId: episodeId,
        openingCrawl: openingCrawl,
        director: director,
        producer: producer,
        releaseDate: releaseDate,
        characters: characters,
        url: url,
        imageUrl: imageUrl,
      );
}
