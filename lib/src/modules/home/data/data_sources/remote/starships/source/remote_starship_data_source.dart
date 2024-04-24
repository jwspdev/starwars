// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:retrofit/dio.dart';

import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/service/remote_starship_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';

abstract class RemoteStarshipDataSource {
  Future<HttpResponse<ListStarshipsResponse>> listStarships(int pageNumber);
  Future<HttpResponse<Starship>> getCurrentStarship(int id);
}

class RemoteStarshipDataSourceImpl implements RemoteStarshipDataSource {
  RemoteStarshipApiService apiService;
  RemoteStarshipDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<HttpResponse<Starship>> getCurrentStarship(int id) {
    return apiService.getCurrentStarship(id);
  }

  @override
  Future<HttpResponse<ListStarshipsResponse>> listStarships(int pageNumber) {
    return apiService.listStarships(pageNumber);
  }
}
