import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _instance;

  factory DbHelper() {
    if (_instance == null) {
      _instance = DbHelper._internal();
    }
    return _instance;
  }

  DbHelper._internal();

  final String createDatabase =
      "CREATE TABLE movie (id INTERGER PRIMARY KEY, title TEXT, vote REAL, posterPath TEXT, backdropPath TEXT, overview TEXT, relaseDate TEXT)";

  Database database;

  Future<Database> open() async {
    if (database == null) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'movie_database.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(createDatabase);
      });
    }

    return database;
  }

  Future<void> close() async {
    if (database != null) {
      database.close();
    }
  }

  Future<void> delete() async {
    if (database != null) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'movie_database.db');

      deleteDatabase(path);
    }
  }
}
