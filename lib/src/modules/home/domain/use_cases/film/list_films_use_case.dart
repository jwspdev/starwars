import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/use_cases/base_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/film_repository.dart';

class ListFilmUseCase extends BaseUseCase<DataState<dynamic>, int> {
  final FilmRepository _filmRepository;

  ListFilmUseCase(this._filmRepository);

  @override
  Future<DataState> call({int? params}) {
    return _filmRepository.listFilms(params!);
  }
}
