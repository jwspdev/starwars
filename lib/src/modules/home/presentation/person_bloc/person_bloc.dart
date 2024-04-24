// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';

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
  }

  _onPeoplePageChanged(
      OnPeoplePageChanged event, Emitter<PersonState> emit) async {
    emit(PersonLoading());
    debugPrint('usecase: $_getCurrentPersonUseCase');
    debugPrint('potek 1');
    final result = await _listPeopleUseCase.call(params: event.pageNumber);
    debugPrint('POTEK 2');
    if (result is DataSuccess) {
      debugPrint('${result.data}');
      emit(ListOfPeopleLoaded(result: result.data!));
    } else if (result is DataFailure) {
      emit(PersonError(exception: result.exception!));
    }
  }

  // _onCurrentPersonIdChanged(
  //     OnCurrentPersonIdChanged event, Emitter<PersonState> emit) async {}
}
