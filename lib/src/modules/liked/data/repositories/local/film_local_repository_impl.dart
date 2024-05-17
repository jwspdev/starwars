import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/database.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/film_local_repository.dart';

class FilmLocalRepositoryImpl extends FilmLocalRepository {
  final AppDatabase database;

  FilmLocalRepositoryImpl(this.database);
  @override
  Future<FilmEntity?> findFilmById(String uniqueId) {
    return database.filmDao.findFilmById(uniqueId);
  }

  @override
  Future<List<FilmEntity>> getAllFilms() {
    return database.filmDao.getAllFilms();
  }

  @override
  Future<void> insertListOfFilms(List<FilmEntity> films) {
    return database.filmDao.insertListOfPeople(films);
  }

  @override
  Future<List<FilmEntity>> getOrderedFilms(String order) {
    return database.filmDao.getOrderedFilms(order);
  }

  @override
  Future<void> updateFilmEntities(List<FilmEntity> films) {
    return database.filmDao.updateFilmEntities(films);
  }
}
