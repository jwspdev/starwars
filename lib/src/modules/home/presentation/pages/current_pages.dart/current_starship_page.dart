// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/film_widgets/related_films_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/people_widgets/related_people_container.dart';

class CurrentStarshipPage extends StatefulWidget {
  static String routePath = '/starship';
  final StarshipEntity starship;
  const CurrentStarshipPage({
    super.key,
    required this.starship,
  });

  @override
  State<CurrentStarshipPage> createState() => _CurrentStarshipPageState();
}

class _CurrentStarshipPageState extends State<CurrentStarshipPage> {
  @override
  Widget build(BuildContext context) {
    StarshipEntity currentStarship = widget.starship;
    return MultiBlocProvider(
        providers: [
          BlocProvider<FilmBloc>(
              create: (context) => sl()
                ..add(OnGetFilmsByIds(filmUrls: currentStarship.films ?? []))),
          BlocProvider<PersonBloc>(
              create: (context) => sl()
                ..add(OnGetMultiplePeople(urls: currentStarship.pilots ?? []))),
        ],
        child: Scaffold(
            body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(children: [
            Positioned(
              child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: SafeArea(
                    child: Image.asset(
                      'assets/images/default_vehicle_image.png',
                    ),
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: _buildStarshipDetails(currentStarship),
              ),
            ),
          ]),
        )));
  }

  Widget _buildStarshipDetails(StarshipEntity starship) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  starship.name,
                  style: openSansExtraBoldText(fontSize: 24),
                ),
                // Icon(CupertinoIcons.coin)
              ],
            ),
            Text(
              starship.model,
              style: openSansBoldText(fontSize: 18),
            ),
            Text(
              starship.starshipClass,
              style: openSansBoldText(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.money_dollar,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      starship.costInCredits,
                      style: openSansBoldText(
                          fontSize: 18, color: Colors.deepPurple),
                    )
                  ],
                )
              ],
            ),
            Text(
              'Features',
              style: openSansBoldText(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  starship.length,
                  style: openSansBoldText(fontSize: 14),
                ),
                Text(
                  ' meters',
                  style: openSansMedium(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                _buildSpecsCard(
                  Icons.speed,
                  'Hyperdrive Rating',
                  starship.hyperdriveRating,
                ),
                _buildSpecsCard(
                    CupertinoIcons.light_max, 'MGLT', starship.mglt),
                _buildSpecsCard(CupertinoIcons.speedometer, 'Max Speed',
                    starship.maxAtmospheringSpeed)
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                _buildSpecsCard(
                  Icons.work_outline,
                  'Crew',
                  starship.crew,
                ),
                _buildSpecsCard(
                    CupertinoIcons.person, 'Passengers', starship.passengers),
                _buildSpecsCard(CupertinoIcons.cart, 'Cargo Capacity',
                    starship.cargoCapacity)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 12,
            ),
            const RelatedPeopleContainer(isTransportation: true),
            const SizedBox(
              height: 12,
            ),
            const RelatedFilmsContainer()
          ],
        ),
      ),
    );
  }

  Expanded _buildSpecsCard(IconData iconData, String header, String value) {
    return Expanded(
      child: Card(
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Icon(
                  iconData,
                  size: 20,
                ),
                Text(
                  header,
                  style: openSansRegular(fontSize: 10),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  value,
                  style: openSansMedium(fontSize: value.length > 10 ? 14 : 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
