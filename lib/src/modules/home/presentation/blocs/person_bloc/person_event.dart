part of 'person_bloc.dart';

sealed class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class OnPeoplePageChanged extends PersonEvent {
  final int pageNumber;

  const OnPeoplePageChanged({required this.pageNumber});
  @override
  List<Object> get props => [pageNumber];
}

class OnCurrentPersonIdChanged extends PersonEvent {
  final int id;

  const OnCurrentPersonIdChanged({required this.id});

  @override
  List<Object> get props => [id];
}

class OnGetMultiplePeople extends PersonEvent {
  final List<int>? ids;

  const OnGetMultiplePeople({this.ids});
  @override
  List<Object> get props => [ids ?? []];
}
