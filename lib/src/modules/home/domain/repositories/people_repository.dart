import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';

abstract class PeopleRepository {
  Future<DataState<ListPeopleResponseEntity>> listPeople(int pageNumber);
  Future<DataState<PersonEntity>> getCurrentPerson(int id);
}
