import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/list_response_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

class ListStarshipsResponseEntity extends ListResponseBaseEntity {
  final List<StarshipEntity> results;
  const ListStarshipsResponseEntity(
      {required super.count,
      super.next,
      super.previous,
      required this.results});
  @override
  List<Object?> get props => super.props..add([results]);
}
