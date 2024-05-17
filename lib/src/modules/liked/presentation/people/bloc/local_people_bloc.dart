// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/people_local_repository.dart';

part 'local_people_event.dart';
part 'local_people_state.dart';

class LocalPeopleBloc extends Bloc<LocalPeopleEvent, LocalPeopleState> {
  final PeopleLocalRepository _peopleLocalRepository;
  LocalPeopleBloc(
    this._peopleLocalRepository,
  ) : super(LocalPeopleInitial()) {
    on<LocalPeopleEvent>((event, emit) {});
    on<OnGetLocalPeople>(_onGetLocalPeople);
    on<OnCheckLikedPerson>(_onCheckLikedPerson);
    on<OnTogglePersonLiked>(_onTogglePersonLiked);
  }

  _onGetLocalPeople(
      OnGetLocalPeople event, Emitter<LocalPeopleState> emit) async {
    emit(LocalPeopleLoading());
    List<PersonEntity> result = await _peopleLocalRepository.getAllPeople();
    emit(LocalPeopleLoaded(peopleList: result));
  }

  _onCheckLikedPerson(
      OnCheckLikedPerson event, Emitter<LocalPeopleState> emit) async {
    emit(LocalPeopleLoading());
    PersonEntity personEntity = event.person;
    final result =
        await _peopleLocalRepository.findPersonById(personEntity.uniqueId!);
    if (result == null) {
      emit(const IsPersonDisliked());
    } else {
      emit(const IsPersonLiked());
    }
  }

  _onTogglePersonLiked(
      OnTogglePersonLiked event, Emitter<LocalPeopleState> emit) async {
    PersonEntity person = event.person;
    final result =
        await _peopleLocalRepository.findPersonById(person.uniqueId!);
    if (result == null) {
      await _peopleLocalRepository.insertPerson(person);
    } else {
      await _peopleLocalRepository.deletePerson(person);
    }
    add(OnCheckLikedPerson(person: person));
  }
}
