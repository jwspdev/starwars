part of 'person_bloc.dart';

sealed class PersonState extends Equatable {
  final List<PersonEntity> people;
  const PersonState({required this.people});

  @override
  List<Object> get props => [people];
}

final class PersonInitial extends PersonState {
  PersonInitial() : super(people: []);
}

final class PersonLoading extends PersonState {
  PersonLoading() : super(people: []);
}

final class ListOfPeopleLoaded extends PersonState {
  const ListOfPeopleLoaded({required super.people});
  @override
  List<Object> get props => [people];
}

final class CurrentPersonLoaded extends PersonState {
  final PersonEntity result;

  CurrentPersonLoaded({required this.result}) : super(people: []);
  @override
  List<Object> get props => [result];
}

final class PeopleByIdsLoaded extends PersonState {
  const PeopleByIdsLoaded({required super.people});
  @override
  List<Object> get props => [people];
}

final class PersonError extends PersonState {
  final Exception exception;

  PersonError({required this.exception}) : super(people: []);

  @override
  List<Object> get props => [exception];
}

final class LoadMorePeople extends PersonState {
  const LoadMorePeople({required super.people});
  @override
  List<Object> get props => [people];
}

final class NoMorePeople extends PersonState {
  NoMorePeople() : super(people: []);
}
