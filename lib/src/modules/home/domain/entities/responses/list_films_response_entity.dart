import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/list_response_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';

class ListFilmsResponseEntity extends ListResponseBaseEntity {
  final List<FilmEntity> results;
  const ListFilmsResponseEntity({
    required super.count,
    super.next,
    super.previous,
    required this.results,
  });

  @override
  List<Object?> get props => super.props..add(results);
}
