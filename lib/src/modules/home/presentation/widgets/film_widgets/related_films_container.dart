import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';

class RelatedFilmsContainer extends StatelessWidget {
  const RelatedFilmsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Films',
          style: openSansBoldText(fontSize: 16),
        ),
        BlocBuilder<FilmBloc, FilmState>(builder: (context, state) {
          if (state is FilmLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is FilmsByIdLoaded && state.films.isNotEmpty) {
            List<FilmEntity>? films = state.films;
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Stack(
                        children: [
                          films[index].imageUrl == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/no_image.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )
                              : Image.network(films[index].imageUrl!),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is FilmsByIdLoaded && state.films.isEmpty) {
            return const Center(
              child: Text('no films'),
            );
          }
          return Container();
        }),
      ],
    );
  }
}
