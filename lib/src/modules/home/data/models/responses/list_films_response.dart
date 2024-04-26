import 'package:star_wars_app/src/modules/home/data/models/film.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';

class ListFilmsResponse extends ListFilmsResponseEntity {
  const ListFilmsResponse(
      {required super.count,
      super.next,
      super.previous,
      required super.results});

  factory ListFilmsResponse.fromJson(Map<String, dynamic> json) {
    List<FilmEntity> results = [];
    for (var film in json['results']) {
      results.add(Film.fromJson(film));
    }
    return ListFilmsResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: results);
  }

  ListFilmsResponseEntity toEntity() => ListFilmsResponseEntity(
      count: count, next: next, previous: previous, results: results);
}
