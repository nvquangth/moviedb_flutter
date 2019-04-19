import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/data/source/local/local_data_source.dart';
import 'package:moviedb_flutter/data/source/remote/remote_data_source.dart';

abstract class MovieRepository {
  Future<MovieResponse> getNowPlaying(int page);

  Future<Movie> getMovie2(bool fromServer, int id);

  getMovie(
      bool fromServer, int id, onSuccess(Movie movie), onFail(Exception e));

  insertMovie(Movie movie, onSuccess(), onFail(Exception e));

  deleteMovie(Movie movie, onSuccess(), onFail(Exception e));

  updateMovie(Movie movie, onSuccess(), onFail(Exception e));

  getMovies(onSuccess(List<Movie> movies), onFail(Exception e));
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
  getMovie(bool fromServer, int id, Function(Movie movie) onSuccess,
      Function(Exception e) onFail) {
    try {
      if (fromServer) {
        remote.getMovie(id).then((response) {
          onSuccess(response);
        });
      } else {
        local.getMovie(id).then((results) {
          onSuccess(results);
        });
      }
    } catch (e) {
      onFail(e);
    }
  }

  @override
  deleteMovie(Movie movie, Function() onSuccess, Function(Exception e) onFail) {
    try {
      local.deleteMovie(movie).then((result) {
        onSuccess();
      });
    } catch (e) {
      onFail(e);
    }
  }

  @override
  getMovies(
      Function(List<Movie> movies) onSuccess, Function(Exception e) onFail) {
    try {
      local.getMovies().then((results) {
        onSuccess(results);
      });
    } catch (e) {
      onFail(e);
    }
  }

  @override
  insertMovie(Movie movie, Function() onSuccess, Function(Exception e) onFail) {
    try {
      local.insertMovie(movie).then((result) {
        onSuccess();
      });
    } on Exception catch (e) {
      onFail(e);
    }
  }

  @override
  updateMovie(Movie movie, Function() onSuccess, Function(Exception e) onFail) {
    try {
      local.updateMovie(movie).then((result) {
        onSuccess();
      });
    } catch (e) {
      onFail(e);
    }
  }

  @override
  Future<MovieResponse> getNowPlaying(int page) => remote.getNowPlaying(page);

  @override
  Future<Movie> getMovie2(bool fromServer, int id) =>
      fromServer ? remote.getMovie(id) : local.getMovie(id);
}
