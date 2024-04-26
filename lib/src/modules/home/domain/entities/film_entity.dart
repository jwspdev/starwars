// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FilmEntity extends Equatable {
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

  const FilmEntity({
    this.uniqueId,
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    this.characters,
    required this.url,
    this.imageUrl,
  });

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
      ];
}
