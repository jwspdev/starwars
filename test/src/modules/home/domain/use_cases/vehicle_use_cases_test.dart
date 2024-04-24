import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
// import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/get_current_vehicle_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/list_vehicles_use_case.dart';

void main() {
  late GetCurrentVehicleUseCase getCurrentVehicleUseCase;
  late ListVehiclesUseCase listVehiclesUseCase;
  setUp(() {
    initializeDependencies();
    getCurrentVehicleUseCase = GetCurrentVehicleUseCase(sl());
    listVehiclesUseCase = ListVehiclesUseCase(sl());
  });
  test('should call get current starship method from repository', () async {
    int id = 4;

    final result = await getCurrentVehicleUseCase.call(params: id);
    final data = result.data;

    // expect(data, isA<Vehicle>());
    expect(data, isA<VehicleEntity>());
  });
  test('should call list current starship method from repository', () async {
    int id = 4;

    final result = await listVehiclesUseCase.call(params: id);
    final data = result.data;

    expect(data, isA<ListVehicleResponseEntity>());
  });
}
