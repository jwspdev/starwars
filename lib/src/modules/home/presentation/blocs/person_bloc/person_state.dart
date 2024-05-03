part of 'person_bloc.dart';

sealed class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

final class PersonInitial extends PersonState {}

final class PersonLoading extends PersonState {}

final class ListOfPeopleLoaded extends PersonState {
  final ListPeopleResponseEntity result;

  const ListOfPeopleLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

final class CurrentPersonLoaded extends PersonState {
  final PersonEntity result;

  const CurrentPersonLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

final class PersonError extends PersonState {
  final Exception exception;

  const PersonError({required this.exception});

  @override
  List<Object> get props => [exception];
}
