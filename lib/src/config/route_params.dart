import 'package:equatable/equatable.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

//Couldn't find a way to fix context.pop
// where it updates the list from local people page,
//so i did this

//enums for from page
enum FromPage {
  landingPage,
  likedPage,
}

//landing route params
class LandingRouteParams extends Equatable {
  final FromPage? fromPage;

  const LandingRouteParams({this.fromPage});

  @override
  List<Object?> get props => [fromPage];
}

class CurrentPersonRouteParams extends LandingRouteParams {
  final PersonEntity personEntity;

  const CurrentPersonRouteParams({super.fromPage, required this.personEntity});

  @override
  List<Object?> get props => [fromPage, personEntity];
}
