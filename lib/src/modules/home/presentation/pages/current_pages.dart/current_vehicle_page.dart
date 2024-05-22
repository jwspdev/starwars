import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/film_widgets/related_films_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/people_widgets/related_people_container.dart';

class CurrentVehiclePage extends StatefulWidget {
  static String routePath = '/vehicle';
  final VehicleEntity vehicle;
  const CurrentVehiclePage({
    super.key,
    required this.vehicle,
  });

  @override
  State<CurrentVehiclePage> createState() => _CurrentVehiclePageState();
}

class _CurrentVehiclePageState extends State<CurrentVehiclePage> {
  @override
  Widget build(BuildContext context) {
    VehicleEntity currentVehicle = widget.vehicle;
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilmBloc>(
            create: (context) => sl()
              ..add(OnGetFilmsByIds(filmUrls: currentVehicle.films ?? []))),
        BlocProvider<PersonBloc>(
            create: (context) => sl()
              ..add(OnGetMultiplePeople(urls: currentVehicle.pilots ?? []))),
      ],
      child: Stack(children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(40))),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Center(
                          child: currentVehicle.imageUrl == null
                              ? Image.asset(
                                  'assets/images/default_vehicle_image.png',
                                  scale: 6,
                                )
                              : Image.network(
                                  '${currentVehicle.imageUrl}',
                                  // scale: 4,
                                  // fit: BoxFit.fitHeight,
                                ),
                        ),
                        Positioned(
                          left: 8,
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: const Icon(
                              CupertinoIcons.back,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                _buildVehicleUi(currentVehicle),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(children: [
                    SizedBox(
                        width: double.infinity,
                        child: RelatedPeopleContainer(isTransportation: true)),
                    SizedBox(
                        width: double.infinity, child: RelatedFilmsContainer()),
                  ]),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight * 2,
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: kBottomNavigationBarHeight * 0.5,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price in Credits',
                              style: openSansMedium(),
                            ),
                            Text(
                              currentVehicle.costInCredits,
                              style: openSansBoldText(fontSize: 28),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            CupertinoIcons.heart,
                            size: 36,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }

  Widget _buildVehicleUi(VehicleEntity vehicle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vehicle.name,
            style: openSansBoldText(fontSize: 28),
          ),
          Text(
            vehicle.model,
            style: openSansBoldText(fontSize: 20),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Specs',
            style: openSansBoldText(fontSize: 16),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            children: [
              _buildSpecsCard('length', '${vehicle.length} meters'),
              _buildSpecsCard('crew', vehicle.crew),
              _buildSpecsCard('passengers', vehicle.crew),
              _buildSpecsCard('cargo capacity', vehicle.cargoCapacity),
              _buildSpecsCard('consumables', vehicle.consumables),
              _buildSpecsCard(
                  'max speed', '${vehicle.maxAtmospheringSpeed} km/h'),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(
            children: [
              Text(
                'Manufactured by: ',
                style: openSansBoldText(),
              ),
              Text(
                vehicle.manufacturer,
                style: openSansMedium(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecsCard(String header, String value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: openSansRegular(fontSize: 14),
            ),
            Text(
              value,
              style: openSansMedium(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
