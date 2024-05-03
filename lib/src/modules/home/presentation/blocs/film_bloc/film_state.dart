part of 'film_bloc.dart';

sealed class FilmState extends Equatable {
  const FilmState();

  @override
  List<Object> get props => [];
}

final class FilmInitial extends FilmState {}

final class FilmLoading extends FilmState {}

final class ListOfFilmsLoaded extends FilmState {
  final ListFilmsResponseEntity films;

  const ListOfFilmsLoaded({required this.films});
  @override
  List<Object> get props => [films];
}

final class CurrentFilmLoaded extends FilmState {
  final FilmEntity film;

  const CurrentFilmLoaded({required this.film});
  @override
  List<Object> get props => [film];
}

final class FilmError extends FilmState {
  final Exception exception;

  const FilmError({required this.exception});
  @override
  List<Object> get props => [exception];
}

final class FilmsByIdLoaded extends FilmState {
  final List<FilmEntity> films;

  const FilmsByIdLoaded({required this.films});
  @override
  List<Object> get props => [films];
}
