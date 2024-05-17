import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_starship_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_vehicle_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/landing_page.dart';
import 'package:star_wars_app/src/modules/liked/presentation/films/bloc/local_film_bloc.dart';
import 'package:star_wars_app/src/modules/liked/presentation/films/pages/rate_films_page.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/bloc/local_people_bloc.dart';

final GoRouter router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: LandingPage.routePath,
      name: LandingPage.routePath,
      builder: (__, _) => const LandingPage()),
  GoRoute(
    path: CurrentPersonPage.routePath,
    name: CurrentPersonPage.routePath,
    builder: (context, state) {
      PersonEntity entity = state.extra as PersonEntity;
      return BlocProvider<LocalPeopleBloc>(
        create: (context) => sl()..add(OnCheckLikedPerson(person: entity)),
        child: CurrentPersonPage(
          person: entity,
          key: UniqueKey(),
        ),
      );
    },
  ),
  GoRoute(
      path: CurrentStarshipPage.routePath,
      name: CurrentStarshipPage.routePath,
      builder: (context, state) {
        StarshipEntity entity = state.extra as StarshipEntity;
        return CurrentStarshipPage(starship: entity);
      }),
  GoRoute(
      path: CurrentVehiclePage.routePath,
      name: CurrentVehiclePage.routePath,
      builder: (context, state) {
        VehicleEntity entity = state.extra as VehicleEntity;
        return CurrentVehiclePage(vehicle: entity);
      }),
  GoRoute(
    path: RateFilmsPage.routePath,
    name: RateFilmsPage.routePath,
    builder: (context, state) {
      return BlocProvider<LocalFilmBloc>(
        create: (context) => sl()..add(const OnGetOrderedFilms(order: 'asc')),
        child: const RateFilmsPage(),
      );
    },
  )
]);
