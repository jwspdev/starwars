import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/film_widgets/film_carousel.dart';

class FilmContainer extends StatelessWidget {
  const FilmContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        if (state is FilmLoading) {
          return const CupertinoActivityIndicator();
        }
        if (state is ListOfFilmsLoaded) {
          List<FilmEntity> films = state.films.results;
          return FilmCarousel(films: films);
        }
        if (state is FilmError) {
          return Text('${state.exception}');
        }
        return Container(
          height: 80,
          color: Colors.grey,
        );
      },
    );
  }
}
