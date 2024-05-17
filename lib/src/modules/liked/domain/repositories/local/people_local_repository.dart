import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

abstract class PeopleLocalRepository {
  Future<List<PersonEntity>> getAllPeople();
  Future<void> insertPerson(PersonEntity person);
  Future<void> deletePerson(PersonEntity person);
  Future<PersonEntity?> findPersonById(String uniqueId);
}
