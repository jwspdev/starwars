import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:star_wars_app/src/core/utils/constants.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/database.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/service/remote_film_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/films/source/remote_film_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/service/remote_starship_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/service/remote_vehicle_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/vehicle/source/remote_vehicle_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/film_repository_impl.dart';
import 'package:star_wars_app/src/modules/liked/data/repositories/local/film_local_repository_impl.dart';
import 'package:star_wars_app/src/modules/liked/data/repositories/local/people_local_repository_impl.dart';
// import 'package:star_wars_app/src/modules/home/data/repositories/local/people_local_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/starships_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/vehicle_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/film_repository.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/film_local_repository.dart';
import 'package:star_wars_app/src/modules/liked/domain/repositories/local/people_local_repository.dart';
// import 'package:star_wars_app/src/modules/home/domain/repositories/local/people_local_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/starship_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/vehicle_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/get_current_film_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/film/list_films_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/list_people_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/get_current_vehicle_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/vehicle/list_vehicles_use_case.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/film_bloc/film_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/starship_bloc/starship_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/liked/presentation/films/bloc/local_film_bloc.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/bloc/local_people_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton(Dio());
  // sl.registerSingleton<AppDatabase>(AppDatabase);

  //STUPID ISSUE: I FORGOT TO MAKE THE MAIN METHOD ASYNC TOOK ME 1 HOUR TO FIX ISSUE. THAT'S WHY THE ERROR MESSAGE WAS 'CANNOT EXECUTE BECAUSE THE APP DATABASE IS NOT READY' (-_-)
  // sl.registerSingletonAsync<AppDatabase>(
  //     () async => $FloorAppDatabase.databaseBuilder('app_database.db').build());
  final db = await $FloorAppDatabase.databaseBuilder(APP_DATABASE).build();
  sl.registerSingleton<AppDatabase>(db);
  //
  //retrofit api services
  sl.registerSingleton(RemotePeopleApiService(sl()));
  sl.registerSingleton(RemoteStarshipApiService(sl()));
  sl.registerSingleton(RemoteVehicleApiService(sl()));
  sl.registerSingleton(RemoteFilmApiService(sl()));

  //data sources
  sl.registerSingleton(RemotePeopleDataSourceImpl(apiService: sl()));
  sl.registerSingleton(RemoteStarshipDataSourceImpl(apiService: sl()));
  sl.registerSingleton(RemoteVehicleDataSourceImpl(apiService: sl()));
  sl.registerSingleton<RemoteFilmDataSource>(
      RemoteFilmDataSourceImpl(apiService: sl()));

  //remote repositories
  sl.registerSingleton<PeopleRepository>(PeopleRepositoryImpl(sl()));
  sl.registerSingleton<StarshipRepository>(StarshipRepositoryImpl(sl()));
  sl.registerSingleton<VehicleRepository>(VehicleRepositoryImpl(sl()));
  sl.registerSingleton<FilmRepository>(
      FilmRepositoryImpl(remoteFilmDataSource: sl()));

  //local repositories
  //STUPID ISSUE: I FORGOT TO MAKE THE MAIN METHOD ASYNC TOOK ME 1 HOUR TO FIX ISSUE. THAT'S WHY THE ERROR MESSAGE WAS CANNOT EXECUTE BECAUSE THE APP DATABASE IS NOT READY (-_-)
  // sl.registerSingletonWithDependencies<PeopleLocalRepository>(
  //     () => PeopleLocalRepositoryImpl(sl<AppDatabase>()),
  //     dependsOn: [AppDatabase]);
  sl.registerSingleton<PeopleLocalRepository>(PeopleLocalRepositoryImpl(sl()));
  sl.registerSingleton<FilmLocalRepository>(FilmLocalRepositoryImpl(sl()));
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
  //films
  sl.registerSingleton<GetCurrentFilmUseCase>(GetCurrentFilmUseCase(sl()));
  sl.registerSingleton<ListFilmUseCase>(ListFilmUseCase(sl()));

  //remote blocs
  sl.registerFactory(() => PersonBloc(sl(), sl()));
  sl.registerFactory(() => FilmBloc(sl(), sl(), sl()));
  sl.registerFactory(() => VehicleBloc(sl(), sl()));
  sl.registerFactory(() => StarshipBloc(sl(), sl()));

  //local blocs
  sl.registerFactory(() => LocalPeopleBloc(sl()));
  sl.registerFactory(() => LocalFilmBloc(sl()));
}
