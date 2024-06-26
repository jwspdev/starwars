import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/no_data_widget.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/starship_widgets/starship_card.dart';

class RelatedStarshipContainer extends StatelessWidget {
  const RelatedStarshipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Starships Used/Owned',
          style: openSansBoldText(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<StarshipBloc, StarshipState>(builder: (context, state) {
          if (state is StarshipLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is StarshipsByIdsLoaded && state.starships.isEmpty) {
            return const NoDataWidget(
                icon: CupertinoIcons.paperplane, message: 'No StarshipsFound');
          }
          if (state is StarshipsByIdsLoaded && state.starships.isNotEmpty) {
            List<StarshipEntity>? starships = state.starships;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: starships.length,
                itemBuilder: (context, index) {
                  var currentStarship = starships[index];
                  return StarshipCard(
                    starship: currentStarship,
                    isLarge: false,
                  );
                });
          }
          return Container();
        })
      ],
    );
  }
}
