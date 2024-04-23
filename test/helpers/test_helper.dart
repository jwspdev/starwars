import 'package:mockito/annotations.dart';
import 'package:star_wars_app/src/modules/home/domain/repositories/people_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([PeopleRepository],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
