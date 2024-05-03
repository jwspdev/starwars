part of 'film_bloc.dart';

sealed class FilmEvent extends Equatable {
  const FilmEvent();

  @override
  List<Object> get props => [];
}

class OnGetFilms extends FilmEvent {
  @override
  List<Object> get props => [];
}

class OnGetFilmsByIds extends FilmEvent {
  final List<String> filmUrls;

  const OnGetFilmsByIds({required this.filmUrls});
  @override
  List<Object> get props => [filmUrls];
}
