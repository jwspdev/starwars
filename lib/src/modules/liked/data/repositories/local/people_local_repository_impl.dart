import 'package:star_wars_app/src/modules/liked/data/data_sources/local/database.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/people_local_repository.dart';

class PeopleLocalRepositoryImpl implements PeopleLocalRepository {
  final AppDatabase database;

  PeopleLocalRepositoryImpl(this.database);
  @override
  Future<void> deletePerson(PersonEntity person) {
    return database.personDao.deletePerson(person);
  }

  @override
  Future<PersonEntity?> findPersonById(String uniqueId) {
    return database.personDao.findPersonById(uniqueId);
  }

  @override
  Future<List<PersonEntity>> getAllPeople() {
    return database.personDao.getAllPeople();
  }

  @override
  Future<void> insertPerson(PersonEntity person) {
    return database.personDao.insertPerson(person);
  }
}
