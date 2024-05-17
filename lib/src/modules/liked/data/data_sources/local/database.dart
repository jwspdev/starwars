import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:star_wars_app/src/modules/home/domain/entities/film_entity.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/film_dao.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/person_dao.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/type_converters/double_converter.dart';
import 'package:star_wars_app/src/modules/liked/data/data_sources/local/type_converters/string_list_converter.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';

part 'database.g.dart';

@TypeConverters([DoubleConverter, StringListConverter])
@Database(version: 1, entities: [PersonEntity, FilmEntity])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
  FilmDao get filmDao;
}
