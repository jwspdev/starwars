import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_starship_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_vehicle_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/landing_page.dart';

final GoRouter router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: LandingPage.routePath,
      name: "landing_page",
      builder: (__, _) => const LandingPage()),
  GoRoute(
    path: CurrentPersonPage.routePath,
    name: "current_person",
    builder: (context, state) {
      PersonEntity entity = state.extra as PersonEntity;
      return CurrentPersonPage(person: entity);
    },
  ),
  GoRoute(
      path: CurrentStarshipPage.routePath,
      name: "starship_page",
      builder: (context, state) {
        StarshipEntity entity = state.extra as StarshipEntity;
        return CurrentStarshipPage(starship: entity);
      }),
  GoRoute(
      path: CurrentVehiclePage.routePath,
      name: "vehicle_page",
      builder: (context, state) {
        VehicleEntity entity = state.extra as VehicleEntity;
        return CurrentVehiclePage(vehicle: entity);
      })
]);
