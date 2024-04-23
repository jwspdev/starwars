import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';
// import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
part 'remote_people_api_service.g.dart';

@RestApi(baseUrl: STAR_WARS_ENDPOINT)
abstract class RemotePeopleApiService {
  factory RemotePeopleApiService(Dio dio) = _RemotePeopleApiService;

  //list people
  @GET(PEOPLE_PATH)
  Future<HttpResponse<ListPeopleResponse>> listPeople(
    @Query('page') int pageNumber,
  );

  //get current person
  @GET('$PEOPLE_PATH{id}')
  Future<HttpResponse<Person>> getCurrentPerson(@Path() int id);
}
