import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/source/local/sqflite/db_helper.dart';
import 'package:sqflite/sqflite.dart';

abstract class MovieLocal {
  Future<int> insertMovie(Movie movie);

  Future<int> updateMovie(Movie movie);

  Future<int> deleteMovie(Movie movie);

  Future<Movie> getMovie(int movieId);

  Future<List<Movie>> getMovies();

  Future<List<Movie>> searchMovies(String q);
}

/// Movie Local Data Source
class MovieLocalDataSource implements MovieLocal {
  final DbHelper dbHelper;
  static MovieLocalDataSource _instance;

  factory MovieLocalDataSource(DbHelper dbHelper) {
    if (_instance == null) {
      _instance = MovieLocalDataSource._internal(dbHelper: dbHelper);
    }
    return _instance;
  }

  MovieLocalDataSource._internal({this.dbHelper});

  @override
  Future<int> deleteMovie(Movie movie) async {
    Database db = await dbHelper.open();
    int result = await db.delete('movie', where: 'id = ?', whereArgs: [movie.id]);
//    int result = await db.rawDelete('DELETE FROM movie WHERE id = ?', [movie.id]);
//    await dbHelper.close();
    return result;
  }

  @override
  Future<Movie> getMovie(int movieId) async {
    Database db = await dbHelper.open();
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM movie WHERE id = ?', [movieId]);
//    await dbHelper.close();
    if (results == null || results.length == 0) {
      return null;
    }
    var result = results[0];
    return _getMovieFromRaw(result);
  }

  @override
  Future<List<Movie>> getMovies() async {
    Database db = await dbHelper.open();
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM movie');
//    await dbHelper.close();
    List<Movie> movies = [];
    for (Map<String, dynamic> result in results) {
      movies.add(_getMovieFromRaw(result));
    }
    return movies;
  }

  @override
  Future<int> insertMovie(Movie movie) async {
    Database db = await dbHelper.open();
    var map = Map<String, dynamic>();
    map['id'] = movie.id;
    map['title'] = movie.title;
    map['vote'] = movie.vote;
    map['posterPath'] = movie.posterPath;
    map['backdropPath'] = movie.backdropPath;
    map['overview'] = movie.overview;
    map['releaseDate'] = movie.releaseDate;

    int result = await db.insert('movie', map,
        conflictAlgorithm: ConflictAlgorithm.replace);
//    await dbHelper.close();
    return result;
  }

  @override
  Future<List<Movie>> searchMovies(String q) async {
    Database db = await dbHelper.open();
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM movie WHERE title LIKE ?', [q]);
//    await dbHelper.close();
    List<Movie> movies = [];
    for (Map<String, dynamic> result in results) {
      movies.add(_getMovieFromRaw(result));
    }
    return movies;
  }

  @override
  Future<int> updateMovie(Movie movie) async {
    Database db = await dbHelper.open();
    var map = Map<String, dynamic>();
    map['id'] = movie.id;
    map['title'] = movie.title;
    map['vote'] = movie.vote;
    map['posterPath'] = movie.posterPath;
    map['backdropPath'] = movie.backdropPath;
    map['overview'] = movie.overview;
    map['releaseDate'] = movie.releaseDate;

    int result = await db.update('movie', map,
        conflictAlgorithm: ConflictAlgorithm.replace);
//    await dbHelper.close();
    return result;
  }

  Movie _getMovieFromRaw(Map<String, dynamic> raw) {
    return Movie(
        id: raw['id'],
        title: raw['title'],
        vote: raw['vote'],
        posterPath: raw['posterPath'],
        backdropPath: raw['backdropPath'],
        overview: raw['overview'],
        releaseDate: raw['releaseDate']);
  }
}
