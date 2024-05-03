part of 'starship_bloc.dart';

sealed class StarshipState extends Equatable {
  const StarshipState();

  @override
  List<Object> get props => [];
}

final class StarshipInitial extends StarshipState {}

final class StarshipLoading extends StarshipState {}

final class StarshipError extends StarshipState {
  final Exception exception;
  const StarshipError({required this.exception});
  @override
  List<Object> get props => [exception];
}

final class StarshipsByIdsLoaded extends StarshipState {
  final List<StarshipEntity> starships;

  const StarshipsByIdsLoaded({required this.starships});
  @override
  List<Object> get props => [starships];
}
