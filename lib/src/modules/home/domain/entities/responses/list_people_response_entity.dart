import 'package:equatable/equatable.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

class ListPeopleResponseEntity extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PersonEntity> results;

  const ListPeopleResponseEntity(
      {required this.count, this.next, this.previous, required this.results});

  @override
  List<Object?> get props => [count, next, previous, results];
}
