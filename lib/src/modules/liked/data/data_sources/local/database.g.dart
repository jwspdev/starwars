// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  // ignore: library_private_types_in_public_api
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  // ignore: library_private_types_in_public_api
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  FilmDao? _filmDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `person_table` (`uniqueId` TEXT, `name` TEXT NOT NULL, `height` TEXT NOT NULL, `mass` TEXT NOT NULL, `hairColor` TEXT NOT NULL, `skinColor` TEXT NOT NULL, `eyeColor` TEXT NOT NULL, `birthYear` TEXT NOT NULL, `gender` TEXT NOT NULL, `films` TEXT, `vehicles` TEXT, `starships` TEXT, `url` TEXT NOT NULL, `imageUrl` TEXT, PRIMARY KEY (`uniqueId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `film_table` (`uniqueId` TEXT, `title` TEXT NOT NULL, `episodeId` INTEGER NOT NULL, `openingCrawl` TEXT NOT NULL, `director` TEXT NOT NULL, `producer` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `characters` TEXT, `url` TEXT NOT NULL, `imageUrl` TEXT, `rank` INTEGER, PRIMARY KEY (`uniqueId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }

  @override
  FilmDao get filmDao {
    return _filmDaoInstance ??= _$FilmDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _personEntityInsertionAdapter = InsertionAdapter(
            database,
            'person_table',
            (PersonEntity item) => <String, Object?>{
                  'uniqueId': item.uniqueId,
                  'name': item.name,
                  'height': item.height,
                  'mass': item.mass,
                  'hairColor': item.hairColor,
                  'skinColor': item.skinColor,
                  'eyeColor': item.eyeColor,
                  'birthYear': item.birthYear,
                  'gender': item.gender,
                  'films': _stringListConverter.encode(item.films),
                  'vehicles': _stringListConverter.encode(item.vehicles),
                  'starships': _stringListConverter.encode(item.starships),
                  'url': item.url,
                  'imageUrl': item.imageUrl
                }),
        _personEntityDeletionAdapter = DeletionAdapter(
            database,
            'person_table',
            ['uniqueId'],
            (PersonEntity item) => <String, Object?>{
                  'uniqueId': item.uniqueId,
                  'name': item.name,
                  'height': item.height,
                  'mass': item.mass,
                  'hairColor': item.hairColor,
                  'skinColor': item.skinColor,
                  'eyeColor': item.eyeColor,
                  'birthYear': item.birthYear,
                  'gender': item.gender,
                  'films': _stringListConverter.encode(item.films),
                  'vehicles': _stringListConverter.encode(item.vehicles),
                  'starships': _stringListConverter.encode(item.starships),
                  'url': item.url,
                  'imageUrl': item.imageUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonEntity> _personEntityInsertionAdapter;

  final DeletionAdapter<PersonEntity> _personEntityDeletionAdapter;

  @override
  Future<List<PersonEntity>> getAllPeople() async {
    return _queryAdapter.queryList('SELECT * FROM person_table',
        mapper: (Map<String, Object?> row) => PersonEntity(
            uniqueId: row['uniqueId'] as String?,
            name: row['name'] as String,
            height: row['height'] as String,
            mass: row['mass'] as String,
            hairColor: row['hairColor'] as String,
            skinColor: row['skinColor'] as String,
            eyeColor: row['eyeColor'] as String,
            birthYear: row['birthYear'] as String,
            gender: row['gender'] as String,
            films: _stringListConverter.decode(row['films'] as String),
            vehicles: _stringListConverter.decode(row['vehicles'] as String),
            starships: _stringListConverter.decode(row['starships'] as String),
            url: row['url'] as String,
            imageUrl: row['imageUrl'] as String?));
  }

  @override
  Future<PersonEntity?> findPersonById(String uniqueId) async {
    return _queryAdapter.query('SELECT * FROM person_table WHERE uniqueId = ?1',
        mapper: (Map<String, Object?> row) => PersonEntity(
            uniqueId: row['uniqueId'] as String?,
            name: row['name'] as String,
            height: row['height'] as String,
            mass: row['mass'] as String,
            hairColor: row['hairColor'] as String,
            skinColor: row['skinColor'] as String,
            eyeColor: row['eyeColor'] as String,
            birthYear: row['birthYear'] as String,
            gender: row['gender'] as String,
            films: _stringListConverter.decode(row['films'] as String),
            vehicles: _stringListConverter.decode(row['vehicles'] as String),
            starships: _stringListConverter.decode(row['starships'] as String),
            url: row['url'] as String,
            imageUrl: row['imageUrl'] as String?),
        arguments: [uniqueId]);
  }

  @override
  Future<void> insertPerson(PersonEntity person) async {
    await _personEntityInsertionAdapter.insert(
        person, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePerson(PersonEntity person) async {
    await _personEntityDeletionAdapter.delete(person);
  }
}

class _$FilmDao extends FilmDao {
  _$FilmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _filmEntityInsertionAdapter = InsertionAdapter(
            database,
            'film_table',
            (FilmEntity item) => <String, Object?>{
                  'uniqueId': item.uniqueId,
                  'title': item.title,
                  'episodeId': item.episodeId,
                  'openingCrawl': item.openingCrawl,
                  'director': item.director,
                  'producer': item.producer,
                  'releaseDate': item.releaseDate,
                  'characters': _stringListConverter.encode(item.characters),
                  'url': item.url,
                  'imageUrl': item.imageUrl,
                  'rank': item.rank
                }),
        _filmEntityUpdateAdapter = UpdateAdapter(
            database,
            'film_table',
            ['uniqueId'],
            (FilmEntity item) => <String, Object?>{
                  'uniqueId': item.uniqueId,
                  'title': item.title,
                  'episodeId': item.episodeId,
                  'openingCrawl': item.openingCrawl,
                  'director': item.director,
                  'producer': item.producer,
                  'releaseDate': item.releaseDate,
                  'characters': _stringListConverter.encode(item.characters),
                  'url': item.url,
                  'imageUrl': item.imageUrl,
                  'rank': item.rank
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FilmEntity> _filmEntityInsertionAdapter;

  final UpdateAdapter<FilmEntity> _filmEntityUpdateAdapter;

  @override
  Future<List<FilmEntity>> getAllFilms() async {
    return _queryAdapter.queryList('SELECT * FROM film_table',
        mapper: (Map<String, Object?> row) => FilmEntity(
            uniqueId: row['uniqueId'] as String?,
            title: row['title'] as String,
            episodeId: row['episodeId'] as int,
            openingCrawl: row['openingCrawl'] as String,
            director: row['director'] as String,
            producer: row['producer'] as String,
            releaseDate: row['releaseDate'] as String,
            characters:
                _stringListConverter.decode(row['characters'] as String),
            url: row['url'] as String,
            imageUrl: row['imageUrl'] as String?,
            rank: row['rank'] as int?));
  }

  @override
  Future<FilmEntity?> findFilmById(String uniqueId) async {
    return _queryAdapter.query('SELECT * FROM film_table WHERE uniqueId = ?1',
        mapper: (Map<String, Object?> row) => FilmEntity(
            uniqueId: row['uniqueId'] as String?,
            title: row['title'] as String,
            episodeId: row['episodeId'] as int,
            openingCrawl: row['openingCrawl'] as String,
            director: row['director'] as String,
            producer: row['producer'] as String,
            releaseDate: row['releaseDate'] as String,
            characters:
                _stringListConverter.decode(row['characters'] as String),
            url: row['url'] as String,
            imageUrl: row['imageUrl'] as String?,
            rank: row['rank'] as int?),
        arguments: [uniqueId]);
  }

  @override
  Future<List<FilmEntity>> getOrderedFilms(String order) async {
    return _queryAdapter.queryList(
      'SELECT * FROM film_table order by rank $order',
      mapper: (Map<String, Object?> row) => FilmEntity(
          uniqueId: row['uniqueId'] as String?,
          title: row['title'] as String,
          episodeId: row['episodeId'] as int,
          openingCrawl: row['openingCrawl'] as String,
          director: row['director'] as String,
          producer: row['producer'] as String,
          releaseDate: row['releaseDate'] as String,
          characters: _stringListConverter.decode(row['characters'] as String),
          url: row['url'] as String,
          imageUrl: row['imageUrl'] as String?,
          rank: row['rank'] as int?),
    );
  }

  @override
  Future<void> deleteAllRecords() async {
    await _queryAdapter.queryNoReturn('DELETE FROM film_table');
  }

  @override
  Future<void> insertListOfPeople(List<FilmEntity> films) async {
    await _filmEntityInsertionAdapter.insertList(
        films, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFilmEntities(List<FilmEntity> films) async {
    await _filmEntityUpdateAdapter.updateList(
        films, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateFilm(FilmEntity film) async {
    await _filmEntityUpdateAdapter.update(film, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _doubleConverter = DoubleConverter();
final _stringListConverter = StringListConverter();
