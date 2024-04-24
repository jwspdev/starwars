import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/use_cases/base_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/starship_repository.dart';

class ListStarshipUseCase extends BaseUseCase<DataState<dynamic>, int> {
  final StarshipRepository _starshipRepository;

  ListStarshipUseCase(this._starshipRepository);

  @override
  Future<DataState> call({int? params}) {
    return _starshipRepository.listStarships(params!);
  }
}
