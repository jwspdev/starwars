import 'package:star_wars_app/src/modules/home/data/models/starship.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

class ListStarshipsResponse extends ListStarshipsResponseEntity {
  const ListStarshipsResponse(
      {required super.count,
      super.next,
      super.previous,
      required super.results});
  //json mapper
  factory ListStarshipsResponse.fromJson(Map<String, dynamic> json) {
    List<StarshipEntity> results = [];
    for (var starship in json['results']) {
      results.add(Starship.fromJson(starship).toEntity());
    }

    return ListStarshipsResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: results,
    );
  }
  //to entity converter
  ListStarshipsResponseEntity toEntity() => ListStarshipsResponseEntity(
      count: count, next: next, previous: previous, results: results);
}
