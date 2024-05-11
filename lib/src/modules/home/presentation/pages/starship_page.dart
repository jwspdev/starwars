import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_starship_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/starship_widgets/starship_card.dart';

class StarshipPage extends StatelessWidget {
  const StarshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StarshipBloc, StarshipState>(
      builder: (context, state) {
        if (state is StarshipLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ListOfStarshipsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<StarshipBloc>(context)
                  .add(const OnStarshipPageChanged(pageNumber: 1));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildStarshipListView(state.result.results),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildStarshipListView(List<StarshipEntity> starships) {
    return ListView.builder(
        itemCount: starships.length,
        itemBuilder: (context, index) {
          StarshipEntity currentStarship = starships[index];
          return GestureDetector(
            onTap: () {
              context.push(CurrentStarshipPage.routePath,
                  extra: currentStarship);
            },
            child: StarshipCard(starship: currentStarship),
          );
        });
  }
}
