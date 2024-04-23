import 'dart:convert';
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/list_people_use_case.dart';
import 'package:star_wars_app/src/modules/home/presentation/person_bloc/person_bloc.dart';

import '../../../../../helpers/json_reader.dart';

class MockListPeopleUseCase implements ListPeopleUseCase {
  final Map<String, dynamic> listOfPeopleJson = json
      .decode(readJson('helpers/dummy_data/dummy_list_people_response.json'));

  @override
  Future<DataState> call({int? params}) async {
    ListPeopleResponseEntity listOfPeopleEntity =
        ListPeopleResponse.fromJson(listOfPeopleJson).toEntity();
    return DataSuccess(listOfPeopleEntity);
  }
}

void main() {
  late RemotePeopleDataSourceImpl dataSource;
  late PeopleRepositoryImpl peopleRepositoryImpl;
  late Dio dio;
  late RemotePeopleApiService apiService;
  late GetCurrentPersonUseCase getCurrentPersonuseCase;
  late ListPeopleUseCase listPeopleUseCase;
  late PersonBloc _personBloc;
  late MockListPeopleUseCase mockListPeopleUseCase;
  final Map<String, dynamic> listOfPeopleJson = json
      .decode(readJson('helpers/dummy_data/dummy_list_people_response.json'));
  final Map<String, dynamic> currentPersonJson =
      json.decode(readJson('helpers/dummy_data/dummy_person_response.json'));

  ListPeopleResponseEntity listOfPeopleEntity =
      ListPeopleResponse.fromJson(listOfPeopleJson).toEntity();
  PersonEntity currentPersonEntity =
      Person.fromJson(currentPersonJson).toEntity();

  setUp(() {
    mockListPeopleUseCase = MockListPeopleUseCase();
    dio = Dio();
    apiService = RemotePeopleApiService(dio);
    dataSource = RemotePeopleDataSourceImpl(apiService: apiService);
    peopleRepositoryImpl = PeopleRepositoryImpl(dataSource);
    getCurrentPersonuseCase = GetCurrentPersonUseCase(peopleRepositoryImpl);
    listPeopleUseCase = ListPeopleUseCase(peopleRepositoryImpl);
    _personBloc = PersonBloc(getCurrentPersonuseCase, mockListPeopleUseCase);
  });

  int page = 1;
  int id = 1;
  group('person/people bloc', () {
    test('should be person initial as the initial state', () {
      debugPrint('${_personBloc.state}');
      expect(_personBloc.state, PersonInitial());
    });
    blocTest<PersonBloc, PersonState>(
        'should emit [PersonLoading and ListOfPeopleLoaded] when data is gotten',
        build: () {
          return _personBloc;
        },
        act: (bloc) {
          bloc.add(OnPeoplePageChanged(pageNumber: page));
        },
        expect: () =>
            [PersonLoading(), ListOfPeopleLoaded(result: listOfPeopleEntity)]);
  });
}
