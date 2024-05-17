part of 'local_people_bloc.dart';

sealed class LocalPeopleState extends Equatable {
  const LocalPeopleState();

  @override
  List<Object> get props => [];
}

final class LocalPeopleInitial extends LocalPeopleState {}

final class LocalPeopleLoading extends LocalPeopleState {}

final class LocalPeopleLoaded extends LocalPeopleState {
  final List<PersonEntity> peopleList;

  const LocalPeopleLoaded({required this.peopleList});
  @override
  List<Object> get props => [peopleList];
}

final class IsPersonLiked extends LocalPeopleState {
  const IsPersonLiked();
  @override
  List<Object> get props => [];
}

final class IsPersonDisliked extends LocalPeopleState {
  const IsPersonDisliked();
  @override
  List<Object> get props => [];
}
