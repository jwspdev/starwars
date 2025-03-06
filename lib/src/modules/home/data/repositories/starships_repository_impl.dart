import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_starships_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/starship.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/starship_repository.dart';

class StarshipRepositoryImpl implements StarshipRepository {
  final RemoteStarshipDataSourceImpl _remoteStarshipDataSourceImpl;

  StarshipRepositoryImpl(this._remoteStarshipDataSourceImpl);
  @override
  Future<DataState<StarshipEntity>> getCurrentStarship(int id) async {
    try {
      final HttpResponse<Starship> response =
          await _remoteStarshipDataSourceImpl.getCurrentStarship(id);
      if (response.response.statusCode == HttpStatus.ok) {
        final starshipResponse = response.data;
        return DataSuccess(starshipResponse.toEntity());
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
  Future<DataState<ListStarshipsResponseEntity>> listStarships(
      int pageNumber) async {
    try {
      final HttpResponse<ListStarshipsResponse> response =
          await _remoteStarshipDataSourceImpl.listStarships(pageNumber);
      if (response.response.statusCode == HttpStatus.ok) {
        ListStarshipsResponse data = response.data;
        // await Future.forEach(data.results, (starship) async {
        //   var imageUrl =
        //       'https://firebasestorage.googleapis.com/v0/b/star-wars-project-deae7.appspot.com/o/${starship.uniqueId}.png?alt=media&token=5a6f2555-4e54-46e2-a76a-309266bb0e97';
        //   final response = await http.head(Uri.parse(imageUrl));
        //   if (response.statusCode == 200) {
        //     var updatedStarship = starship.copyWith(imageUrl: imageUrl);
        //     var index = data.results.indexOf(starship);
        //     if (index >= 0) {
        //       data.results[index] = updatedStarship;
        //     }
        //   }
        // });
        return DataSuccess(data.toEntity());
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
