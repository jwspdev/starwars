import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';

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
        BlocBuilder<StarshipBloc, StarshipState>(builder: (context, state) {
          if (state is StarshipLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is StarshipsByIdsLoaded && state.starships.isEmpty) {
            return const Center(
              child: Text('No Starships'),
            );
          }
          if (state is StarshipsByIdsLoaded && state.starships.isNotEmpty) {
            List<StarshipEntity>? starships = state.starships;
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: starships.length,
                itemBuilder: (context, index) {
                  var currentStarship = starships[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 88,
                              height: 88,
                              child: currentStarship.imageUrl == null
                                  ? Image.asset('assets/images/no_image.jpg')
                                  : Image.network(currentStarship.imageUrl!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        currentStarship.starshipClass,
                                        style: openSansMedium(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        currentStarship.model,
                                        style: openSansRegular(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        currentStarship.name,
                                        style: openSansBoldText(fontSize: 20),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        )),
                  );
                });
          }
          return Container();
        })
      ],
    );
  }
}
