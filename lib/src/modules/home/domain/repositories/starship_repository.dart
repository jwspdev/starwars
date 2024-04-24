import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_starship_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

abstract class StarshipRepository {
  Future<DataState<StarshipEntity>> getCurrentStarship(int id);
  Future<DataState<ListStarshipsResponseEntity>> listStarships(int pageNumber);
}
