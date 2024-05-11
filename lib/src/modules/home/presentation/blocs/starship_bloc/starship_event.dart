part of 'starship_bloc.dart';

sealed class StarshipEvent extends Equatable {
  const StarshipEvent();

  @override
  List<Object> get props => [];
}

class OnGetStarshipsByIds extends StarshipEvent {
  final List<String> starshipUrls;

  const OnGetStarshipsByIds({required this.starshipUrls});
  @override
  List<Object> get props => [starshipUrls];
}

class OnStarshipPageChanged extends StarshipEvent {
  final int pageNumber;

  const OnStarshipPageChanged({required this.pageNumber});
  @override
  List<Object> get props => [pageNumber];
}
