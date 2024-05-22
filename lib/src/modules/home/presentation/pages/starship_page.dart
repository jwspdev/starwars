import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_starship_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/starship_widgets/starship_card.dart';

class StarshipPage extends StatefulWidget {
  const StarshipPage({super.key});

  @override
  State<StarshipPage> createState() => _StarshipPageState();
}

class _StarshipPageState extends State<StarshipPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    StarshipBloc bloc = context.read<StarshipBloc>();
    return BlocBuilder<StarshipBloc, StarshipState>(
      builder: (context, state) {
        if (state is StarshipLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is ListOfStarshipsLoaded || state is LoadMoreStarships) {
          final starships = state.starships;
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<StarshipBloc>(context).page = 1;
              BlocProvider.of<StarshipBloc>(context)
                  .add(const OnStarshipPageChanged());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: bloc.scrollController,
                  itemCount: state is LoadMoreStarships
                      ? starships.length + 1
                      : starships.length,
                  itemBuilder: (context, index) {
                    if (index < starships.length) {
                      StarshipEntity currentStarship = starships[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(CurrentStarshipPage.routePath,
                              extra: currentStarship);
                        },
                        child: StarshipCard(
                          starship: currentStarship,
                          isLarge: true,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
