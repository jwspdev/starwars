part of 'local_film_bloc.dart';

sealed class LocalFilmState extends Equatable {
  const LocalFilmState();

  @override
  List<Object> get props => [];
}

final class LocalFilmInitial extends LocalFilmState {}

final class LocalFilmLoading extends LocalFilmState {}

final class LocalFilmsLoaded extends LocalFilmState {
  final List<FilmEntity> films;

  const LocalFilmsLoaded({required this.films});
  @override
  List<Object> get props => [films];
}

final class LocalFilmsUpdated extends LocalFilmState {}
