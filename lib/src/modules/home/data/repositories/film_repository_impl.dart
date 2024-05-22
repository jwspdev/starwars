// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/source/remote_film_data_source.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_films_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/film_repository.dart';
import 'package:http/http.dart' as http;

class FilmRepositoryImpl implements FilmRepository {
  final RemoteFilmDataSource _remoteFilmDataSource;
  FilmRepositoryImpl({
    required RemoteFilmDataSource remoteFilmDataSource,
  }) : _remoteFilmDataSource = remoteFilmDataSource;

  @override
  Future<DataState<FilmEntity>> getCurrentFilm(int id) async {
    try {
      final response = await _remoteFilmDataSource.getCurrentFilm(id);
      if (response.response.statusCode == HttpStatus.ok) {
        final data = response.data.toEntity();

        return DataSuccess(data);
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }

  @override
  Future<DataState<ListFilmsResponseEntity>> listFilms(int pageNumber) async {
    try {
      final response = await _remoteFilmDataSource.listFilms(pageNumber);
      if (response.response.statusCode == HttpStatus.ok) {
        final data = response.data;

        await Future.forEach(data.results, (film) async {
          var imageUrl =
              'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/${film.uniqueId}.jpeg?alt=media&token=99bbd36a-e9b2-4244-b325-45e11ceadb9d';
          final response = await http.head(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            var updatedFilm = film.copyWith(imageUrl: imageUrl);
            var index = data.results.indexOf(film);
            if (index >= 0) {
              data.results[index] = updatedFilm;
            }
          }
        });
        return DataSuccess(data);
      } else {
        return DataFailure(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }
}
