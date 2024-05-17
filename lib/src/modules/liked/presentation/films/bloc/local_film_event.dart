part of 'local_film_bloc.dart';

sealed class LocalFilmEvent extends Equatable {
  const LocalFilmEvent();

  @override
  List<Object> get props => [];
}

final class OnGetOrderedFilms extends LocalFilmEvent {
  final String order;

  const OnGetOrderedFilms({required this.order});
  @override
  List<Object> get props => [order];
}

final class OnSaveOrUpdateFilms extends LocalFilmEvent {
  final List<FilmEntity> films;

  const OnSaveOrUpdateFilms({required this.films});
  @override
  List<Object> get props => [films];
}
