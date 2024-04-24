import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
// import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
// import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/vehicle_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/responses/list_vehicle_response_entity.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

void main() {
  late VehicleRepositoryImpl vehicleRepositoryImpl;
  setUp(() {
    initializeDependencies();
    vehicleRepositoryImpl = VehicleRepositoryImpl(sl());
  });

  //test if api is being called
  //to avoid wasting time and move on with actual dev, just check if the datastate's
  //...data are the proper classes
  test(
      'should call api and data from data state should be list vehicle response entity',
      () async {
    //arrange
    int page = 1;
    //act
    final apiResponse = await vehicleRepositoryImpl.listVehicles(page);
    final data = apiResponse.data;
    //assert
    // expect(data, isA<ListVehicleResponse>());
    expect(data, isA<ListVehicleResponseEntity>());
  });
  test('should call api and data from data state should be vehicle entity',
      () async {
    //arrange
    int id = 4;
    //act
    final apiResponse = await vehicleRepositoryImpl.getCurrentVehicle(id);
    final data = apiResponse.data;
    //assert
    // expect(data, isA<Vehicle>());
    expect(data, isA<VehicleEntity>());
  });
}
