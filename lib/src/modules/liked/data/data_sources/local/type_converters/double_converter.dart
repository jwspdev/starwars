import 'package:floor/floor.dart';

class DoubleConverter extends TypeConverter<double, String> {
  @override
  double decode(String databaseValue) {
    return double.tryParse(databaseValue) ?? 0.0;
  }

  @override
  String encode(double? value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }
}
