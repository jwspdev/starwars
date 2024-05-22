part of 'starship_bloc.dart';

sealed class StarshipState extends Equatable {
  final List<StarshipEntity> starships;
  const StarshipState({required this.starships});

  @override
  List<Object> get props => [starships];
}

final class StarshipInitial extends StarshipState {
  StarshipInitial() : super(starships: []);
}

final class StarshipLoading extends StarshipState {
  StarshipLoading() : super(starships: []);
}

final class StarshipError extends StarshipState {
  final Exception exception;
  StarshipError({required this.exception}) : super(starships: []);
  @override
  List<Object> get props => [exception];
}

final class StarshipsByIdsLoaded extends StarshipState {
  const StarshipsByIdsLoaded({required super.starships});
  @override
  List<Object> get props => [starships];
}

final class ListOfStarshipsLoaded extends StarshipState {
  const ListOfStarshipsLoaded({required super.starships});
  @override
  List<Object> get props => [starships];
}

final class LoadMoreStarships extends StarshipState {
  const LoadMoreStarships({required super.starships});
  @override
  List<Object> get props => [starships];
}
