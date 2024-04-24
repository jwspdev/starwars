import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';

import '../../../../../../../helpers/json_reader.dart';

void main() {
  late Dio dio;
  late RemotePeopleApiService apiService;
  late RemotePeopleDataSourceImpl dataSource;

  setUp(() {
    dio = Dio();
    apiService = RemotePeopleApiService(dio);
    dataSource = RemotePeopleDataSourceImpl(apiService: apiService);
  });
  test('should call api and return an httpresponse of list people response',
      () async {
    //arrange
    int page = 1;
    //act
    final result = await dataSource.listPeople(page);
    debugPrint('COUNT: ${result.data.count}');
    debugPrint('NEXT: ${result.data.next}');
    debugPrint('PREVIOUS: ${result.data.previous}');
    for (var person in result.data.results) {
      debugPrint('$person');
    }
    //assert
    expect(result, isA<HttpResponse<ListPeopleResponse>>());
  });

  test('should call get current person', () async {
    //arrange
    int id = 1;
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_person_response.json'));
    //act
    final personResult = Person.fromJson(jsonMap);
    final apiResult = await dataSource.getCurrentPerson(id);
    final apiPersonResult = apiResult.data;
    debugPrint('${apiResult.data}');
    //assert
    expect(personResult, equals(apiPersonResult));
  });
}
