import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/list_people_use_case.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  late RemotePeopleDataSourceImpl dataSource;
  late PeopleRepositoryImpl peopleRepositoryImpl;
  late Dio dio;
  late RemotePeopleApiService apiService;
  late GetCurrentPersonUseCase getCurrentPersonuseCase;
  late ListPeopleUseCase listPeopleUseCase;
  setUp(() {
    dio = Dio();
    apiService = RemotePeopleApiService(dio);
    dataSource = RemotePeopleDataSourceImpl(apiService: apiService);
    peopleRepositoryImpl = PeopleRepositoryImpl(dataSource);
    getCurrentPersonuseCase = GetCurrentPersonUseCase(peopleRepositoryImpl);
    listPeopleUseCase = ListPeopleUseCase(peopleRepositoryImpl);
  });

  group('people use cases', () {
    test('should call repository and return current person entity', () async {
      //arrange
      int id = 1;
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_person_response.json'));
      //act
      final jsonResult = Person.fromJson(jsonMap).toEntity();

      final result = await getCurrentPersonuseCase.call(params: id);
      //assert
      expect(result.data, equals(jsonResult));
    });
    test(
        '\nshould call repository from use case and return list of person entity',
        () async {
      //arrange
      int page = 1;
      final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_list_people_response.json'));
      // final Map<String, dynamic> personMap = json
      //     .decode(readJson('helpers/dummy_data/dummy_person_response.json'));
      //act
      final jsonResult = ListPeopleResponse.fromJson(jsonMap).toEntity();
      // final personResult = Person.fromJson(personMap).toEntity();

      final result = await listPeopleUseCase.call(params: page);
      debugPrint('JSON: ${result.data}');
      //assert
      ListPeopleResponseEntity data = result.data;

      expect(data.results, equals(jsonResult.results));
      // expect(result.data, isA<ListResponseBaseEntity>());
    });
  });
}
