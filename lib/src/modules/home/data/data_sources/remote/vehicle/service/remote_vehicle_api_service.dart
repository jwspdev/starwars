import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/home/data/models/responses/list_vehicle_response.dart';
import 'package:star_wars_app/src/modules/home/data/models/vehicle.dart';
part 'remote_vehicle_api_service.g.dart';

@RestApi(baseUrl: STAR_WARS_ENDPOINT)
abstract class RemoteVehicleApiService {
  factory RemoteVehicleApiService(Dio dio) = _RemoteVehicleApiService;

  //list vehicles by page
  @GET(VEHICLE_PATH)
  Future<HttpResponse<ListVehicleResponse>> listVehicles(
    @Query('page') int pageNumber,
  );
  //get current vehicle by id
  @GET('$VEHICLE_PATH{id}')
  Future<HttpResponse<Vehicle>> getCurrentVehicle(@Path() int id);
}
