import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/no_data_widget.dart';

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
            return SizedBox(
              height: 220,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 16,
                    );
                  },
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 140,
                            width: 140,
                            child: films[index].imageUrl == null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Image.asset(
                                      'assets/images/no_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.network(films[index].imageUrl!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              films[index].title,
                              style: openSansBoldText(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
          if (state is FilmsByIdLoaded && state.films.isEmpty) {
            return const Center(
                child: NoDataWidget(
                    icon: Icons.movie_filter, message: 'No Movie Found'));
          }
          return Container();
        }),
      ],
    );
  }
}
