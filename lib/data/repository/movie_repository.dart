import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/data/source/data_source.dart';

abstract class MovieRepository {
  getNowPlaying(
      int page, onSuccess(MovieResponse movieResponse), onFail(Exception e));

  getMovie(int id, onSuccess(Movie movie), onFail(Exception e));
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemote remote;
  static MovieRepositoryImpl _instance;

  factory MovieRepositoryImpl(MovieRemoteDataSource remote) {
    if (_instance == null) {
      _instance = MovieRepositoryImpl._internal(remote: remote);
    }
    return _instance;
  }

  MovieRepositoryImpl._internal({this.remote});

  @override
  getMovie(
      int id, Function(Movie movie) onSuccess, Function(Exception e) onFail) {
    try {
      remote.getMovie(id).then((response) {
        onSuccess(response);
      });
    } catch (e) {
      onFail(e);
    }
  }

  @override
  getNowPlaying(int page, Function(MovieResponse movieResponse) onSuccess,
      Function(Exception e) onFail) {
    try {
      remote.getNowPlaying(page).then((response) {
        onSuccess(response);
      });
    } catch (e) {
      onFail(e);
    }
  }
}
