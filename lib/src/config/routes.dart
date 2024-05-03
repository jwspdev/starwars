import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';
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
  )
]);
