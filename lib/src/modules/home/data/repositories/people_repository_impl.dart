import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:http/http.dart' as http;

class PeopleRepositoryImpl implements PeopleRepository {
  final RemotePeopleDataSourceImpl _remotePeopleDataSourceImpl;
  PeopleRepositoryImpl(
    this._remotePeopleDataSourceImpl,
  );

  @override
  Future<DataState<PersonEntity>> getCurrentPerson(int id) async {
    try {
      final HttpResponse<Person> response =
          await _remotePeopleDataSourceImpl.getCurrentPerson(id);
      if (response.response.statusCode == HttpStatus.ok) {
        final personResponse = response.data;
        return DataSuccess(personResponse.toEntity());
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      debugPrint('$e');
      return DataFailure(e);
    }
  }

  @override
  Future<DataState<ListPeopleResponseEntity>> listPeople(int pageNumber) async {
    try {
      final HttpResponse<ListPeopleResponse> response =
          await _remotePeopleDataSourceImpl.listPeople(pageNumber);
      if (response.response.statusCode == HttpStatus.ok) {
        ListPeopleResponse data = response.data;

        // await Future.forEach(data.results, (person) async {
        //   var imageUrl =
        //       'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/${person.uniqueId}.jpeg?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
        //   // final response = await http.head(Uri.parse(imageUrl));
        //   // if (response.statusCode == 200) {
        //   var currentPerson = person.copyWith(imageUrl: imageUrl);
        //   var index = data.results.indexOf(person);
        //   if (index >= 0) {
        //     data.results[index] = currentPerson;
        //   }
        //   // }
        // });
        return DataSuccess(data.toEntity());
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      debugPrint('$e');
      return DataFailure(e);
    }
  }
}
