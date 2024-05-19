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
    return Stack(children: [
      Image.asset(
        'assets/images/space_background.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            'Rank These Films',
            style: starWarsFont(color: Colors.amber, fontSize: 24)
                .merge(customOutlinedTextStyle()),
          ),
          centerTitle: true,
        ),
        // backgroundColor: Colors.grey,
        body: BlocBuilder<LocalFilmBloc, LocalFilmState>(
          builder: (context, state) {
            if (state is LocalFilmsLoaded) {
              var listOfFIlms = state.films;
              return _buildReorderableFilmList(listOfFIlms);
            }
            return const CupertinoActivityIndicator();
          },
        ),
      ),
    ]);
  }

  Widget _buildReorderableFilmList(List<FilmEntity> films) {
    return ReorderableListView(
        padding: const EdgeInsets.all(12),
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
            Card(
              color: Colors.grey.shade700.withOpacity(0.5),
              elevation: 12,
              key: ValueKey('$i'),
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Icon(
                        Icons.star,
                        size: 64,
                        color: _getStarColor(i),
                      ),
                      Text(
                        '${i + 1}',
                        style: openSansMedium(color: Colors.white, fontSize: 20)
                            .merge(customOutlinedTextStyle()),
                      )
                    ]),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                        width: 64,
                        height: 84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/no_image.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ))),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Text(
                      films[i].title,
                      style: openSansMedium(color: Colors.white, fontSize: 18),
                    )),
                    ReorderableDragStartListener(
                      index: i,
                      child: Icon(
                        CupertinoIcons.move,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ]);
  }

  void _updateFilmListOrder(List<FilmEntity> films) {
    LocalFilmBloc bloc = LocalFilmBloc(sl());
    bloc.add(OnSaveOrUpdateFilms(films: films));
  }

  Color _getStarColor(index) {
    if (index == 0) {
      return Colors.amber;
    }
    if (index == 1) {
      return Colors.blueGrey;
    }
    if (index == 2) {
      return Colors.brown.shade300;
    }
    if (index >= 6) {
      return Colors.red;
    }
    return Colors.grey;
  }

  // Widget _buildFilmCard(FilmEntity film) {

  // }
}
