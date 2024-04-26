// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:retrofit/retrofit.dart';

import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/service/remote_film_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/models/film.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_films_response.dart';

abstract class RemoteFilmDataSource {
  Future<HttpResponse<ListFilmsResponse>> listFilms(int pageNumber);
  Future<HttpResponse<Film>> getCurrentFilm(int id);
}

class RemoteFilmDataSourceImpl implements RemoteFilmDataSource {
  RemoteFilmApiService apiService;
  RemoteFilmDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<HttpResponse<Film>> getCurrentFilm(int id) {
    return apiService.getCurrentFilm(id);
  }

  @override
  Future<HttpResponse<ListFilmsResponse>> listFilms(int pageNumber) {
    return apiService.listFilms(pageNumber);
  }
}
