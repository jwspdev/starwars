import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

class FilmCarousel extends StatefulWidget {
  final List<FilmEntity> films;
  const FilmCarousel({super.key, required this.films});

  @override
  State<FilmCarousel> createState() => _FilmCarouselState();
}

class _FilmCarouselState extends State<FilmCarousel>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;
  int _pageNo = 0;
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageNo == widget.films.length) {
        _pageNo = 0;
      }
      _pageController.animateToPage(_pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      _pageNo++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Films',
            style: openSansBoldText(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 132,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _pageNo = index;
              });
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return child!;
                },
                child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("tapped: ${index + 1}")));
                    },
                    child: _buildFilmContainer(widget.films[index])),
              );
            },
            itemCount: widget.films.length,
          ),
        ),
      ],
    );
  }

  Widget _buildFilmContainer(FilmEntity film) {
    return Container(
        margin: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0), border: Border.all()),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/no_image.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                film.title,
                style: openSansBoldText(color: Colors.white)
                    .merge(customOutlinedTextStyle()),
              ),
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
