import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/list_response_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

class ListPeopleResponseEntity extends ListResponseBaseEntity {
  final List<PersonEntity> results;

  const ListPeopleResponseEntity(
      {required super.count,
      super.next,
      super.previous,
      required this.results});

  @override
  List<Object?> get props => super.props..add([results]);
}
