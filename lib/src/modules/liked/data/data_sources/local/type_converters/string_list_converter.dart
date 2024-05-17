import 'package:floor/floor.dart';

class StringListConverter extends TypeConverter<List<String>?, String> {
  //convert String from sql to List<String>
  @override
  List<String> decode(String databaseValue) {
    if (databaseValue.isEmpty) {
      return [];
    }
    return databaseValue.split(',');
  }

  //convert List<String> value to String
  @override
  String encode(List<String>? value) {
    if (value == null) {
      return '';
    }
    return value.join(',');
  }
}
