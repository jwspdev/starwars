import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/film.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_films_response.dart';

part 'remote_film_api_service.g.dart';

@RestApi(baseUrl: STAR_WARS_ENDPOINT)
abstract class RemoteFilmApiService {
  factory RemoteFilmApiService(Dio dio) = _RemoteFilmApiService;

  //list films by page
  @GET(FILM_PATH)
  Future<HttpResponse<ListFilmsResponse>> listFilms(
      @Query('page') int pageNumber);
  //get current film by id
  @GET('$FILM_PATH{id}')
  Future<HttpResponse<Film>> getCurrentFilm(@Path() int id);
}
