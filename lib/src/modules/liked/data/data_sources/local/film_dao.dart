import 'package:floor/floor.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

@dao
abstract class FilmDao {
  @Query('SELECT * FROM $FILM_TABLE_NAME')
  Future<List<FilmEntity>> getAllFilms();

  @Insert()
  Future<void> insertListOfPeople(List<FilmEntity> films);

  @Query('SELECT * FROM $FILM_TABLE_NAME WHERE uniqueId = :uniqueId')
  Future<FilmEntity?> findFilmById(String uniqueId);

  @Query('SELECT * FROM $FILM_TABLE_NAME order by rank :order}')
  Future<List<FilmEntity>> getOrderedFilms(String order);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFilmEntities(List<FilmEntity> films);

  @Query('DELETE FROM $FILM_TABLE_NAME')
  Future<void> deleteAllRecords();

  @update
  Future<void> updateFilm(FilmEntity film);
}
