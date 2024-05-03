import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/get_current_film_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/list_films_use_case.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final GetCurrentFilmUseCase _getCurrentFilmUseCase;
  final ListFilmUseCase _listFilmUseCase;
  FilmBloc(this._getCurrentFilmUseCase, this._listFilmUseCase)
      : super(FilmInitial()) {
    on<FilmEvent>((event, emit) {});
    on<OnGetFilms>(_onGetFilms);
    on<OnGetFilmsByIds>(_onGetFilmsByIds);
  }
  _onGetFilms(OnGetFilms event, Emitter<FilmState> emit) async {
    emit(FilmLoading());
    final result = await _listFilmUseCase.call(params: 1);
    await Future.delayed(const Duration(seconds: 3));
    if (result is DataSuccess) {
      debugPrint('$result');
      emit(ListOfFilmsLoaded(films: result.data));
    } else {
      emit(FilmError(exception: result.exception!));
    }
  }

  _onGetFilmsByIds(OnGetFilmsByIds event, Emitter<FilmState> emit) async {
    emit(FilmLoading());
    List<int> ids = [];
    List<FilmEntity> peopleList = [];
    Exception? exception;
    if (event.filmUrls.isEmpty) {
      emit(const FilmsByIdLoaded(films: []));
      return;
    }
    for (var film in event.filmUrls) {
      var currentId = int.parse(film.getIdFromUrl());
      ids.add(currentId);
    }
    for (var id in ids) {
      final result = await _getCurrentFilmUseCase.call(params: id);
      if (result is DataSuccess) {
        peopleList.add(result.data);
      }
      if (result is DataFailure) {
        exception = result.exception!;
      }
    }
    if (exception != null) {
      emit(DataFailure(exception) as FilmState);
      return;
    }

    emit(FilmsByIdLoaded(films: peopleList));
  }
}
