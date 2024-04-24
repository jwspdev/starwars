import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/use_cases/base_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/vehicle_repository.dart';

class GetCurrentVehicleUseCase extends BaseUseCase<DataState<dynamic>, int> {
  final VehicleRepository _vehicleRepository;

  GetCurrentVehicleUseCase(this._vehicleRepository);
  @override
  Future<DataState> call({int? params}) {
    return _vehicleRepository.getCurrentVehicle(params!);
  }
}
