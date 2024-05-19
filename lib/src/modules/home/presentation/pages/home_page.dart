import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/core/widgets/custom_top_nav/custom_navigation_tab.dart';
import 'package:star_wars_app/src/core/widgets/custom_top_nav/horizontal_container.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/people_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/starship_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/under_construction_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/vehicle_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  var titles = NAVIGATION_TABS;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilmBloc>(create: (context) => sl()..add(OnGetFilms())),
        BlocProvider<PersonBloc>(
            create: (context) =>
                sl()..add(const OnPeoplePageChanged(pageNumber: 1))),
        BlocProvider<VehicleBloc>(
            create: (context) => sl()..add(const OnVehiclePageChanged())),
        BlocProvider<StarshipBloc>(
            create: (context) =>
                sl()..add(const OnStarshipPageChanged(pageNumber: 1)))
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: HorizontalContainer(
              anyWidget: _topNavigationTab(),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: const [
                PeoplePage(),
                StarshipPage(),
                VehiclePage(),
                UnderConstructionPage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _topNavigationTab() {
    List<Widget> topNavigationTabs = [];
    for (var i = 0; i < NAVIGATION_TABS.length; i++) {
      topNavigationTabs.add(GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = i;
            _pageController.jumpToPage(_selectedIndex);
          });
        },
        child: CustomNavigationTab(
          title: NAVIGATION_TABS[i],
          isSelected: i == _selectedIndex,
        ),
      ));
    }
    return topNavigationTabs;
  }
}
