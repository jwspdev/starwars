import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/people/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/service/remote_starship_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/starships/source/remote_starship_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/starships_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/starship_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/person/list_people_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/get_current_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/starship/list_starship_use_case.dart';
import 'package:star_wars_app/src/modules/home/presentation/person_bloc/person_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton(Dio());

  //retrofit api services
  sl.registerSingleton(RemotePeopleApiService(sl()));
  sl.registerSingleton(RemoteStarshipApiService(sl()));

  //data sources
  sl.registerSingleton(RemotePeopleDataSourceImpl(apiService: sl()));
  sl.registerSingleton(RemoteStarshipDataSourceImpl(apiService: sl()));

  //repositories
  sl.registerSingleton<PeopleRepository>(PeopleRepositoryImpl(sl()));
  sl.registerSingleton<StarshipRepository>(StarshipRepositoryImpl(sl()));

  //usecases
  sl.registerSingleton<GetCurrentPersonUseCase>(GetCurrentPersonUseCase(sl()));
  sl.registerSingleton<ListPeopleUseCase>(ListPeopleUseCase(sl()));
  sl.registerSingleton<GetCurrentStarshipUseCase>(
      GetCurrentStarshipUseCase(sl()));
  sl.registerSingleton<ListStarshipUseCase>(ListStarshipUseCase(sl()));

  //blocs
  sl.registerFactory(() => PersonBloc(sl(), sl()));
}
