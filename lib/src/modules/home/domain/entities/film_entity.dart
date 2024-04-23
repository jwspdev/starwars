import 'package:equatable/equatable.dart';

class FilmEntity extends Equatable {
  final String title;
  final int episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final DateTime releaseDate;

  const FilmEntity(
      {required this.title,
      required this.episodeId,
      required this.openingCrawl,
      required this.director,
      required this.producer,
      required this.releaseDate});

  @override
  List<Object?> get props =>
      [title, episodeId, openingCrawl, director, producer, releaseDate];
}
