import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';

class ListPeopleResponse extends ListPeopleResponseEntity {
  const ListPeopleResponse(
      {required int count,
      String? next,
      String? previous,
      required List<Person> results})
      : super(count: count, results: results, next: next, previous: previous);
  factory ListPeopleResponse.fromJson(Map<String, dynamic> json) {
    List<Person> results = [];
    for (var person in json['results']) {
      results.add(Person.fromJson(person));
    }
    return ListPeopleResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: results);
  }

  ListPeopleResponseEntity toEntity() => ListPeopleResponseEntity(
      count: count, results: results, next: next, previous: previous);
}
