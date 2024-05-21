import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/film_widgets/related_films_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/starship_widgets/related_starship_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/vehicle_widgets/related_vehicle_container.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/bloc/local_people_bloc.dart';

class CurrentPersonPage extends StatelessWidget {
  final PersonEntity person;
  const CurrentPersonPage({
    super.key,
    required this.person,
  });
  static const String routePath = '/current_person';
  @override
  Widget build(BuildContext context) {
    var currentPerson = person;
    Map<String, String> firstRow = {
      "Height": currentPerson.height,
      "Mass": currentPerson.mass
    };
    Map<String, String> secondRow = {
      "Hair Color": currentPerson.hairColor,
      "Skin Color": currentPerson.mass
    };

    Map<String, String> thirdRow = {
      "Eye Color": currentPerson.eyeColor,
      "Gender": currentPerson.gender
    };
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        debugPrint('$didPop');
        _onPopPage(context);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FilmBloc>(
              create: (context) =>
                  sl()..add(OnGetFilmsByIds(filmUrls: currentPerson.films!))),
          BlocProvider<VehicleBloc>(
              create: (context) => sl()
                ..add(
                    OnGetVehiclesByIds(vehicleUrls: currentPerson.vehicles!))),
          BlocProvider<StarshipBloc>(
              create: (context) => sl()
                ..add(OnGetStarshipsByIds(
                    starshipUrls: currentPerson.starships!))),
        ],
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  currentPerson.imageUrl == null
                      ? Image.asset(
                          'assets/images/no_image.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        )
                      : Image.network(
                          '${currentPerson.imageUrl}',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/no_image.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            );
                          },
                        ),
                  Positioned(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _onPopPage(context);
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 32,
                        shadows: [
                          Shadow(color: Colors.blue, blurRadius: 15),
                        ],
                      ),
                    ),
                  )),
                  Positioned(
                      bottom: 12,
                      right: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            context.read<LocalPeopleBloc>().add(
                                OnTogglePersonLiked(person: currentPerson));
                          },
                          child: BlocBuilder<LocalPeopleBloc, LocalPeopleState>(
                            builder: (context, state) {
                              if (state is IsPersonDisliked) {
                                return const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white,
                                  size: 32,
                                  shadows: [
                                    Shadow(color: Colors.blue, blurRadius: 15),
                                  ],
                                );
                              }
                              if (state is IsPersonLiked) {
                                return const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.white,
                                  size: 32,
                                  shadows: [
                                    Shadow(color: Colors.blue, blurRadius: 15),
                                  ],
                                );
                              }
                              return const Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                                size: 32,
                                shadows: [
                                  Shadow(color: Colors.blue, blurRadius: 15),
                                ],
                              );
                            },
                          ),
                        ),
                      ))
                ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        currentPerson.uniqueId!,
                        style: openSansExtraBoldText(fontSize: 24),
                      ),
                      Text(
                        currentPerson.name,
                        style: openSansExtraBoldText(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildVitalsRow(firstRow),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      _buildVitalsRow(secondRow),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      _buildVitalsRow(thirdRow),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      const RelatedFilmsContainer(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      const RelatedVehicleContainer(),
                      Container(
                        height: 12,
                      ),
                      const RelatedStarshipContainer(),
                      Container(
                        height: kBottomNavigationBarHeight,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  _onPopPage(BuildContext context) {
    context.read<LocalPeopleBloc>().add(OnCheckLikedPerson(person: person));
    // debugPrint('$x');
    final state = context.read<LocalPeopleBloc>().state;
    // debugPrint('${state}');
    if (state is IsPersonDisliked) {
      context.pop('disliked');
    } else {
      context.pop();
    }
  }

  ///height, mass, hair_color, skin_color,eye_color,gender, birth_year
  Widget _buildVitalsRow(Map<String, String> vitals) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: vitals.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                entry.key,
                style: openSansRegular(),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  entry.value,
                  style: openSansBoldText(fontSize: 16),
                ),
              )
            ],
          );
        }).toList());
  }
}
