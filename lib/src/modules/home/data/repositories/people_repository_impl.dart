// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/person.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_people_response.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';

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
        final data = response.data;
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
