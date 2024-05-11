// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_people_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/list_people_use_case.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final GetCurrentPersonUseCase _getCurrentPersonUseCase;
  final ListPeopleUseCase _listPeopleUseCase;
  PersonBloc(
    this._getCurrentPersonUseCase,
    this._listPeopleUseCase,
  ) : super(PersonInitial()) {
    on<PersonEvent>((event, emit) {});
    on<OnPeoplePageChanged>(_onPeoplePageChanged);
    on<OnGetMultiplePeople>(_onGetMultiplePeople);
  }

  _onPeoplePageChanged(
      OnPeoplePageChanged event, Emitter<PersonState> emit) async {
    emit(PersonLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _listPeopleUseCase.call(params: event.pageNumber);
    debugPrint('${result.data}');

    if (result is DataSuccess) {
      emit(ListOfPeopleLoaded(result: result.data!));
    }
    if (result is DataFailure) {
      emit(PersonError(exception: result.exception!));
    }
  }

  _onGetMultiplePeople(
      OnGetMultiplePeople event, Emitter<PersonState> emit) async {
    emit(PersonLoading());
    if (event.urls.isEmpty) {
      emit(const PeopleByIdsLoaded(peopleList: []));
      return;
    }
    List<int> ids = [];
    List<PersonEntity> peopleList = [];
    Exception? exception;

    for (var person in event.urls) {
      var currentId = int.parse(person.getIdFromUrl());
      ids.add(currentId);
    }
    for (var id in ids) {
      final result = await _getCurrentPersonUseCase.call(params: id);
      if (result is DataSuccess) {
        peopleList.add(result.data);
      }
      if (result is DataFailure) {
        exception = result.exception;
      }
    }
    if (exception != null) {
      emit(PersonError(exception: exception));
    }
    emit(PeopleByIdsLoaded(peopleList: peopleList));
  }
}
