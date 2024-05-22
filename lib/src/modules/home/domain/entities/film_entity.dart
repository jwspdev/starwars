// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/film.dart';

@Entity(tableName: FILM_TABLE_NAME)
class FilmEntity extends Equatable {
  @PrimaryKey()
  final String? uniqueId;

  final String title;
  final int episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final String releaseDate;
  final List<String>? characters;
  final String url;
  final String? imageUrl;
  final int? rank;

  const FilmEntity(
      {this.uniqueId,
      required this.title,
      required this.episodeId,
      required this.openingCrawl,
      required this.director,
      required this.producer,
      required this.releaseDate,
      this.characters,
      required this.url,
      this.imageUrl,
      this.rank});

  @override
  List<Object?> get props => [
        uniqueId,
        title,
        episodeId,
        openingCrawl,
        director,
        producer,
        releaseDate,
        characters,
        url,
        rank,
      ];

  FilmEntity copyWith({String? imageUrl, int? rank}) {
    return FilmEntity(
        uniqueId: uniqueId,
        title: title,
        episodeId: episodeId,
        openingCrawl: openingCrawl,
        director: director,
        producer: producer,
        releaseDate: releaseDate,
        characters: characters,
        url: url,
        imageUrl: imageUrl ?? this.imageUrl,
        rank: rank ?? this.rank);
  }

  //used for some testing, not used again
  //good to have it here as a backup
  Film toModel() => Film(
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
        rank: rank,
      );
}
