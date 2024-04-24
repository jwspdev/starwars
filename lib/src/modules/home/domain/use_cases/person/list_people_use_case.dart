import 'package:star_wars_app/src/core/resources/data_state.dart';
import 'package:star_wars_app/src/core/use_cases/base_use_case.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';

class ListPeopleUseCase extends BaseUseCase<DataState<dynamic>, int> {
  final PeopleRepository _peopleRepository;

  ListPeopleUseCase(this._peopleRepository);

  @override
  Future<DataState> call({int? params}) {
    return _peopleRepository.listPeople(params!);
  }
}
