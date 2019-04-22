import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/data/source/local/local_data_source.dart';
import 'package:moviedb_flutter/data/source/remote/remote_data_source.dart';

abstract class MovieRepository {
  Future<MovieResponse> getNowPlaying(int page);

  Future<Movie> getMovie(bool fromServer, int id);

  Future<int> deleteMovie(Movie movie);

  Future<int> insertMovie(Movie movie);

  Future<List<Movie>> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemote remote;
  final MovieLocal local;
  static MovieRepositoryImpl _instance;

  factory MovieRepositoryImpl(
      MovieRemoteDataSource remote, MovieLocalDataSource local) {
    if (_instance == null) {
      _instance = MovieRepositoryImpl._internal(remote: remote, local: local);
    }
    return _instance;
  }

  MovieRepositoryImpl._internal({this.remote, this.local});

  @override
  Future<MovieResponse> getNowPlaying(int page) => remote.getNowPlaying(page);

  @override
  Future<Movie> getMovie(bool fromServer, int id) =>
      fromServer ? remote.getMovie(id) : local.getMovie(id);

  @override
  Future<int> deleteMovie(Movie movie) => local.deleteMovie(movie);

  @override
  Future<int> insertMovie(Movie movie) => local.insertMovie(movie);

  @override
  Future<List<Movie>> getMovies() => local.getMovies();
}
