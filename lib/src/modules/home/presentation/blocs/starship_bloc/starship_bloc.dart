// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';

import 'package:star_wars_app/src/core/utils/extensions/string_extensions.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';

part 'starship_event.dart';
part 'starship_state.dart';

class StarshipBloc extends Bloc<StarshipEvent, StarshipState> {
  final GetCurrentStarshipUseCase _getCurrentStarshipUseCase;
  // ignore: unused_field
  final ListStarshipUseCase _listStarshipUseCase;
  StarshipBloc(
    this._getCurrentStarshipUseCase,
    this._listStarshipUseCase,
  ) : super(StarshipInitial()) {
    on<StarshipEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnGetStarshipsByIds>(_onGetStarshipsByIds);
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
