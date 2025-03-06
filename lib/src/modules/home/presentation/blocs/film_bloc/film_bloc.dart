import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/get_current_film_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/list_films_use_case.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/film_local_repository.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final GetCurrentFilmUseCase _getCurrentFilmUseCase;
  final ListFilmUseCase _listFilmUseCase;
  final FilmLocalRepository _filmLocalRepository;
  FilmBloc(this._getCurrentFilmUseCase, this._listFilmUseCase,
      this._filmLocalRepository)
      : super(FilmInitial()) {
    on<FilmEvent>((event, emit) {});
    on<OnGetFilms>(_onGetFilms);
    on<OnGetFilmsByIds>(_onGetFilmsByIds);
  }
  //Checks if cached films length is greater than api's films
  _onGetFilms(OnGetFilms event, Emitter<FilmState> emit) async {
    emit(FilmLoading());
    final apiResult = await _listFilmUseCase.call(params: 1);
    List<FilmEntity>? apiFilms = apiResult.data.results;
    final localResult = await _filmLocalRepository.getAllFilms();

    //TODO OPTIMIZE
    if (apiResult is DataSuccess) {
      if (apiFilms!.length > localResult.length) {
        for (int i = 0; i < apiFilms.length; i++) {
          FilmEntity currentFilm = apiFilms[i];
          currentFilm.copyWith(rank: currentFilm.rank ?? i + 1);
        }
        await _filmLocalRepository.insertListOfFilms(apiFilms);
      }
      final newLocalResult = await _filmLocalRepository.getAllFilms();

      emit(ListOfFilmsLoaded(films: newLocalResult));
    } else {
      emit(FilmError(exception: apiResult.exception!));
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
