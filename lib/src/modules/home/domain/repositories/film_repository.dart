import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';

abstract class FilmRepository {
  Future<DataState<ListFilmsResponseEntity>> listFilms(int pageNumber);
  Future<DataState<FilmEntity>> getCurrentFilm(int id);
}
