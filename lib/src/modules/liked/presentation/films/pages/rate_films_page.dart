import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/utils/custom_colors.dart';
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
    List<FilmEntity> oldFilms = List.from(films);
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
              // debugPrint('${currentFilm.title} ${currentFilm.rank}');
            }

            _updateFilmListOrder(oldFilms, films);
          });
        },
        children: <Widget>[
          for (int i = 0; i < films.length; i++)
            Card(
              color: Colors.grey.shade700.withOpacity(0.5),
              elevation: 12,
              key: ValueKey('$i'),
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 8, top: 4, bottom: 4, left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReorderableDragStartListener(
                      index: i,
                      child: Icon(
                        Icons.drag_handle,
                        color: Colors.grey.shade400,
                      ),
                    ),
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
                          child: films[i].imageUrl == null
                              ? Image.asset(
                                  'assets/images/no_image.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Image.network(
                                  '${films[i].imageUrl}',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/no_image.jpg',
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    );
                                  },
                                ),
                        )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Text(
                      films[i].title,
                      style: openSansMedium(color: Colors.white, fontSize: 16),
                    )),
                    Row(children: [
                      Icon(
                        i == films.length - 1
                            ? CupertinoIcons.trash_fill
                            : Icons.star,
                        size: 24,
                        color: _getStarColor(i),
                      ),
                      Text(
                        '${i + 1}',
                        style: openSansMedium(color: Colors.white, fontSize: 16)
                            .merge(customOutlinedTextStyle()),
                      ),
                    ]),
                  ],
                ),
              ),
            )
        ]);
  }

  void _updateFilmListOrder(List<FilmEntity> oldFilms, List<FilmEntity> films) {
    bool isSame = true;
    for (var i = 0; i < oldFilms.length; i++) {
      if (oldFilms[i] != films[i]) {
        isSame = false;
        break;
      }
    }
    if (isSame == false) {
      LocalFilmBloc bloc = LocalFilmBloc(sl());
      bloc.add(OnSaveOrUpdateFilms(films: films));
    } else {
      debugPrint('parehas');
    }
  }

  Color _getStarColor(index) {
    if (index == 0) {
      return CustomColors.goldColor;
    }
    if (index == 1) {
      return CustomColors.silverColor;
    }
    if (index >= 6) {
      return CustomColors.trashColor;
    }
    return CustomColors.bronzeColor;
  }

  // Widget _buildFilmCard(FilmEntity film) {

  // }
}
