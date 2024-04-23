import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/service/remote_people_api_service.dart';
import 'package:star_wars_app/src/modules/home/data/data_sources/remote/source/remote_people_data_source.dart';
import 'package:star_wars_app/src/modules/home/data/repositories/people_repository_impl.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/get_current_person_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/use_cases/list_people_use_case.dart';
import 'package:star_wars_app/src/modules/home/presentation/person_bloc/person_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton(Dio());

  //retrofit api services
  sl.registerSingleton(RemotePeopleApiService(sl()));

  //data sources
  sl.registerSingleton(RemotePeopleDataSourceImpl(apiService: sl()));

  //repositories
  sl.registerSingleton<PeopleRepository>(PeopleRepositoryImpl(sl()));

  //usecases
  sl.registerSingleton<GetCurrentPersonUseCase>(GetCurrentPersonUseCase(sl()));
  sl.registerSingleton<ListPeopleUseCase>(ListPeopleUseCase(sl()));

  //blocs
  sl.registerFactory(() => PersonBloc(sl(), sl()));
}
