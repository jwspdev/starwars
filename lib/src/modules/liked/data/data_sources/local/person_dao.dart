import 'package:floor/floor.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM $PERSON_TABLE_NAME')
  Future<List<PersonEntity>> getAllPeople();

  @Insert()
  Future<void> insertPerson(PersonEntity person);

  @delete
  Future<void> deletePerson(PersonEntity person);

  @Query('SELECT * FROM $PERSON_TABLE_NAME WHERE uniqueId = :uniqueId')
  Future<PersonEntity?> findPersonById(String uniqueId);
}
