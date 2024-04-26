import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/film.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_films_response.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  Film testFilmModel = const Film(
      uniqueId: "${FILM_PATH}1",
      title: "A New Hope",
      episodeId: 4,
      openingCrawl:
          "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
      director: "George Lucas",
      producer: "Gary Kurtz, Rick McCallum",
      releaseDate: "1977-05-25",
      characters: [
        "https://swapi.py4e.com/api/people/1/",
        "https://swapi.py4e.com/api/people/2/",
        "https://swapi.py4e.com/api/people/3/",
        "https://swapi.py4e.com/api/people/4/",
        "https://swapi.py4e.com/api/people/5/",
        "https://swapi.py4e.com/api/people/6/",
        "https://swapi.py4e.com/api/people/7/",
        "https://swapi.py4e.com/api/people/8/",
        "https://swapi.py4e.com/api/people/9/",
        "https://swapi.py4e.com/api/people/10/",
        "https://swapi.py4e.com/api/people/12/",
        "https://swapi.py4e.com/api/people/13/",
        "https://swapi.py4e.com/api/people/14/",
        "https://swapi.py4e.com/api/people/15/",
        "https://swapi.py4e.com/api/people/16/",
        "https://swapi.py4e.com/api/people/18/",
        "https://swapi.py4e.com/api/people/19/",
        "https://swapi.py4e.com/api/people/81/"
      ],
      url: "https://swapi.py4e.com/api/films/1/");
  FilmEntity testFilmEntity = const FilmEntity(
      title: "A New Hope",
      episodeId: 4,
      openingCrawl:
          "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
      director: "George Lucas",
      producer: "Gary Kurtz, Rick McCallum",
      releaseDate: "1977-05-25",
      characters: [
        "https://swapi.py4e.com/api/people/1/",
        "https://swapi.py4e.com/api/people/2/",
        "https://swapi.py4e.com/api/people/3/",
        "https://swapi.py4e.com/api/people/4/",
        "https://swapi.py4e.com/api/people/5/",
        "https://swapi.py4e.com/api/people/6/",
        "https://swapi.py4e.com/api/people/7/",
        "https://swapi.py4e.com/api/people/8/",
        "https://swapi.py4e.com/api/people/9/",
        "https://swapi.py4e.com/api/people/10/",
        "https://swapi.py4e.com/api/people/12/",
        "https://swapi.py4e.com/api/people/13/",
        "https://swapi.py4e.com/api/people/14/",
        "https://swapi.py4e.com/api/people/15/",
        "https://swapi.py4e.com/api/people/16/",
        "https://swapi.py4e.com/api/people/18/",
        "https://swapi.py4e.com/api/people/19/",
        "https://swapi.py4e.com/api/people/81/"
      ],
      url: "https://swapi.py4e.com/api/films/1/");
  //film model test group
  group('film model test group', () {
    final Map<String, dynamic> jsonMap = json
        .decode(readJson('helpers/dummy_data/films/dummy_film_response.json'));
    final jsonResult = Film.fromJson(jsonMap);

    test('should follow inheritance and if isA', () {
      expect(testFilmModel, isA<Film>());
      expect(testFilmModel, isA<FilmEntity>());
      expect(testFilmEntity, isA<FilmEntity>());
    });
    test('should be equal to from json', () {
      debugPrint('$jsonResult');
      expect(testFilmModel, equals(jsonResult));
    });
  });

  group('list film response test group', () {
    final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/films/dummy_list_film_response.json'));
    final jsonResult = ListFilmsResponse.fromJson(jsonMap);
    test('should return proper values', () {
      debugPrint('$jsonResult');
      expect(jsonResult, isA<ListFilmsResponse>());
      expect(jsonResult.toEntity(), isA<ListFilmsResponseEntity>());
    });
  });
}
