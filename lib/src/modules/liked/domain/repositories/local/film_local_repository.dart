import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

abstract class FilmLocalRepository {
  Future<List<FilmEntity>> getAllFilms();
  Future<void> insertListOfFilms(List<FilmEntity> films);
  Future<FilmEntity?> findFilmById(String uniqueId);
  Future<List<FilmEntity>> getOrderedFilms(String order);
  Future<void> updateFilmEntities(List<FilmEntity> films);
}
