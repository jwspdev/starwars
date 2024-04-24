// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:retrofit/dio.dart';

import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';

abstract class RemotePeopleDataSource {
  Future<HttpResponse<ListPeopleResponse>> listPeople(int pageNumber);
  Future<HttpResponse<Person>> getCurrentPerson(int id);
}

class RemotePeopleDataSourceImpl implements RemotePeopleDataSource {
  RemotePeopleApiService apiService;
  RemotePeopleDataSourceImpl({
    required this.apiService,
  });
  @override
  Future<HttpResponse<Person>> getCurrentPerson(int id) {
    return apiService.getCurrentPerson(id);
  }

  @override
  Future<HttpResponse<ListPeopleResponse>> listPeople(int pageNumber) {
    return apiService.listPeople(pageNumber);
  }
}
