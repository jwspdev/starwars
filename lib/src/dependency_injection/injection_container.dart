import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/service/remote_starship_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/service/remote_vehicle_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/source/remote_vehicle_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/starships_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/vehicle_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/starship_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/vehicle_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/list_people_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/get_current_vehicle_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/list_vehicles_use_case.dart';
import 'package:star_wars_app/src/modules/home/presentation/person_bloc/person_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton(Dio());

  //retrofit api services
  sl.registerSingleton(RemotePeopleApiService(sl()));
  sl.registerSingleton(RemoteStarshipApiService(sl()));
  sl.registerSingleton(RemoteVehicleApiService(sl()));

  //data sources
  sl.registerSingleton(RemotePeopleDataSourceImpl(apiService: sl()));
  sl.registerSingleton(RemoteStarshipDataSourceImpl(apiService: sl()));
  sl.registerSingleton(RemoteVehicleDataSourceImpl(apiService: sl()));

  //repositories
  sl.registerSingleton<PeopleRepository>(PeopleRepositoryImpl(sl()));
  sl.registerSingleton<StarshipRepository>(StarshipRepositoryImpl(sl()));
  sl.registerSingleton<VehicleRepository>(VehicleRepositoryImpl(sl()));

  //usecases
  //person/people
  sl.registerSingleton<GetCurrentPersonUseCase>(GetCurrentPersonUseCase(sl()));
  sl.registerSingleton<ListPeopleUseCase>(ListPeopleUseCase(sl()));
  //starship
  sl.registerSingleton<GetCurrentStarshipUseCase>(
      GetCurrentStarshipUseCase(sl()));
  sl.registerSingleton<ListStarshipUseCase>(ListStarshipUseCase(sl()));
  //vehicle
  sl.registerSingleton<GetCurrentVehicleUseCase>(
      GetCurrentVehicleUseCase(sl()));
  sl.registerSingleton<ListVehiclesUseCase>(ListVehiclesUseCase(sl()));

  //blocs
  sl.registerFactory(() => PersonBloc(sl(), sl()));
}
