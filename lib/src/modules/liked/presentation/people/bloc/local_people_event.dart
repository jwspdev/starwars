part of 'local_people_bloc.dart';

sealed class LocalPeopleEvent extends Equatable {
  const LocalPeopleEvent();

  @override
  List<Object> get props => [];
}

final class OnGetLocalPeople extends LocalPeopleEvent {
  const OnGetLocalPeople();
  @override
  List<Object> get props => [];
}

final class OnLocalPeopleError extends LocalPeopleEvent {
  final Exception exception;

  const OnLocalPeopleError({required this.exception});
  @override
  List<Object> get props => [exception];
}

class OnTogglePersonLiked extends LocalPeopleEvent {
  final PersonEntity person;

  const OnTogglePersonLiked({required this.person});
  @override
  List<Object> get props => [person];
}

class OnCheckLikedPerson extends LocalPeopleEvent {
  final PersonEntity person;
  const OnCheckLikedPerson({required this.person});
  @override
  List<Object> get props => [person];
}
