import 'package:star_wars_app/src/modules/home/domain/entities/base_entities/list_response_base_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

class ListVehicleResponseEntity extends ListResponseBaseEntity {
  final List<VehicleEntity> results;
  const ListVehicleResponseEntity({
    required super.count,
    super.next,
    super.previous,
    required this.results,
  });

  @override
  List<Object?> get props => super.props..add([results]);
}
