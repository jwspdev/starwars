import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/presentation/films/bloc/local_film_bloc.dart';

class RateFilmsPage extends StatefulWidget {
  const RateFilmsPage({super.key});
  static const String routePath = '/film_page';
  @override
  State<RateFilmsPage> createState() => _RateFilmsPageState();
}

class _RateFilmsPageState extends State<RateFilmsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Films',
          style: starWarsFont(color: Colors.amber, fontSize: 16)
            ..merge(customOutlinedTextStyle()),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LocalFilmBloc, LocalFilmState>(
        builder: (context, state) {
          if (state is LocalFilmsLoaded) {
            var listOfFIlms = state.films;
            return _buildReorderableFilmList(listOfFIlms);
          }
          return const CupertinoActivityIndicator();
        },
      ),
    );
  }

  Widget _buildReorderableFilmList(List<FilmEntity> films) {
    return ReorderableListView(
        //
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = films.removeAt(oldIndex);

            films.insert(newIndex, item);
            for (int i = 0; i < films.length; i++) {
              FilmEntity currentFilm = films[i];
              currentFilm.rank = i + 1;
              debugPrint('${currentFilm.title} ${currentFilm.rank}');
            }
            _updateFilmListOrder(films);
          });
        },
        children: <Widget>[
          for (int i = 0; i < films.length; i++)
            ListTile(
              key: ValueKey('$i'),
              title: Text(films[i].title),
              trailing: ReorderableDragStartListener(
                index: i,
                child: const Icon(Icons.drag_handle),
              ),
            )
        ]);
  }

  void _updateFilmListOrder(List<FilmEntity> films) {
    LocalFilmBloc bloc = LocalFilmBloc(sl());
    bloc.add(OnSaveOrUpdateFilms(films: films));
  }
}
