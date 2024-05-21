// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';

import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';

part 'starship_event.dart';
part 'starship_state.dart';

class StarshipBloc extends Bloc<StarshipEvent, StarshipState> {
  final GetCurrentStarshipUseCase _getCurrentStarshipUseCase;
  final ListStarshipUseCase _listStarshipUseCase;
  int page = 1;
  bool canLoadMore = true;
  ScrollController scrollController = ScrollController();

  StarshipBloc(
    this._getCurrentStarshipUseCase,
    this._listStarshipUseCase,
  ) : super(StarshipInitial()) {
    scrollController.addListener(() {
      add(const OnLoadMoreStarships());
    });
    on<StarshipEvent>((event, emit) {});
    on<OnGetStarshipsByIds>(_onGetStarshipsByIds);
    on<OnStarshipPageChanged>(_onStarshipPageChanged);
    on<OnLoadMoreStarships>(_onLoadMoreStarships);
  }
  _onStarshipPageChanged(
      OnStarshipPageChanged event, Emitter<StarshipState> emit) async {
    emit(StarshipLoading());
    final result = await _listStarshipUseCase.call(params: page);

    if (result is DataSuccess) {
      emit(ListOfStarshipsLoaded(starships: result.data.results));
    }
    if (result is DataFailure) {
      emit(StarshipError(exception: result.exception!));
    }
  }

  _onLoadMoreStarships(
      OnLoadMoreStarships event, Emitter<StarshipState> emit) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        canLoadMore) {
      emit(LoadMoreStarships(starships: state.starships));
      // await Future.delayed(const Duration(seconds: 2));
      page++;
      final result = await _listStarshipUseCase.call(params: page);

      if (result is DataSuccess) {
        ListStarshipsResponseEntity? listStarshipResponseEntity = result.data;

        List<StarshipEntity>? starshipList =
            listStarshipResponseEntity?.results ?? [];

        emit(ListOfStarshipsLoaded(
            starships: [...state.starships, ...starshipList]));
        canLoadMore = listStarshipResponseEntity?.next != null;
      }
    }
  }

  _onGetStarshipsByIds(
      OnGetStarshipsByIds event, Emitter<StarshipState> emit) async {
    emit(StarshipLoading());
    List<int> ids = [];
    List<StarshipEntity> starshipList = [];
    Exception? exception;

    if (event.starshipUrls.isEmpty) {
      emit(const StarshipsByIdsLoaded(starships: []));
      return;
    }
    for (var starship in event.starshipUrls) {
      var currentId = int.parse(starship.getIdFromUrl());
      ids.add(currentId);
    }
    for (var id in ids) {
      final result = await _getCurrentStarshipUseCase.call(params: id);
      if (result is DataSuccess) {
        starshipList.add(result.data);
      }
      if (result is DataFailure) {
        exception = result.exception;
      }
    }
    if (exception != null) {
      emit(StarshipError(exception: exception));
    }
    emit(StarshipsByIdsLoaded(starships: starshipList));
  }
}
