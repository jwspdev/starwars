// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';

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
  int? rank;

  FilmEntity(
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
}
