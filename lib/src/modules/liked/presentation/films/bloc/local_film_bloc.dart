// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/film_local_repository.dart';

part 'local_film_event.dart';
part 'local_film_state.dart';

class LocalFilmBloc extends Bloc<LocalFilmEvent, LocalFilmState> {
  final FilmLocalRepository _filmLocalRepository;
  LocalFilmBloc(
    this._filmLocalRepository,
  ) : super(LocalFilmInitial()) {
    on<LocalFilmEvent>((event, emit) {});
    on<OnGetOrderedFilms>(_onGetOrderedFilms);
    on<OnSaveOrUpdateFilms>(_onUpdateFilmsByRank);
  }

  _onGetOrderedFilms(
      OnGetOrderedFilms event, Emitter<LocalFilmState> emit) async {
    emit(LocalFilmLoading());
    List<FilmEntity> films =
        await _filmLocalRepository.getOrderedFilms(event.order);
    emit(LocalFilmsLoaded(films: films));
  }

  _onUpdateFilmsByRank(
      OnSaveOrUpdateFilms event, Emitter<LocalFilmState> emit) async {
    try {
      await _filmLocalRepository.updateFilmEntities(event.films);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
