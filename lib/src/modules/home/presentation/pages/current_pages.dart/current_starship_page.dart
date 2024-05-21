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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            backgroundColor: Colors.white,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                centerTitle: false,
                stretch: true,
                expandedHeight: MediaQuery.of(context).size.height / 2.5,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                    return SafeArea(
                      child: Image.asset(
                        'assets/images/default_vehicle_image.png',
                        fit: BoxFit.fitHeight,
                      ),
                    );
                  }),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                _buildStarshipDetails(currentStarship),
              ]))
            ])));
  }

  Widget _buildStarshipDetails(StarshipEntity starship) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          border: Border(top: BorderSide(color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 20, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Size: ',
                        style: openSansBoldText(),
                      ),
                      Text(
                        '${starship.length} meters',
                        style: openSansMedium(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Manufactured by: ',
                        style: openSansBoldText(),
                      ),
                      Text(
                        starship.manufacturer,
                        style: openSansMedium(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const RelatedPeopleContainer(isTransportation: true),
            const SizedBox(
              height: 12,
            ),
            const RelatedFilmsContainer(),
          ],
        ),
      ),
    );
  }

  Expanded _buildSpecsCard(IconData iconData, String header, String value) {
    return Expanded(
      child: Card(
        elevation: 6,
        color: Colors.white,
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
