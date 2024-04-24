import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';

part 'remote_starship_api_service.g.dart';

@RestApi(baseUrl: STAR_WARS_ENDPOINT)
abstract class RemoteStarshipApiService {
  factory RemoteStarshipApiService(Dio dio) = _RemoteStarshipApiService;

  //list starships by page
  @GET(STARSHIP_PATH)
  Future<HttpResponse<ListStarshipsResponse>> listStarships(
    @Query('page') int pageNumber,
  );
  //get current starship by id
  @GET('$STARSHIP_PATH{id}')
  Future<HttpResponse<Starship>> getCurrentStarship(@Path() int id);
}
