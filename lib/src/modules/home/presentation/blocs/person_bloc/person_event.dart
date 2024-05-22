part of 'person_bloc.dart';

sealed class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class OnPeoplePageChanged extends PersonEvent {
  const OnPeoplePageChanged();
  @override
  List<Object> get props => [];
}

class OnCurrentPersonIdChanged extends PersonEvent {
  final int id;

  const OnCurrentPersonIdChanged({required this.id});

  @override
  List<Object> get props => [id];
}

class OnGetMultiplePeople extends PersonEvent {
  final List<String> urls;

  const OnGetMultiplePeople({required this.urls});
  @override
  List<Object> get props => [urls];
}

class OnLoadMorePeople extends PersonEvent {
  const OnLoadMorePeople();
}
