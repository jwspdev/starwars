import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

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
  });

  //from json mapper
  factory Film.fromJson(Map<String, dynamic> json) {
    String id = json['url'].toString().getIdFromUrl();
    String uniqueId = "$FILM_PATH$id";
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
        url: json['url'] ?? '');
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