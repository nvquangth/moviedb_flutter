import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/data/source/data_source.dart';
import 'package:moviedb_flutter/data/source/local/local_data_source.dart';

abstract class MovieRepository {
  getNowPlaying(
      int page, onSuccess(MovieResponse movieResponse), onFail(Exception e));

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

  @override
  deleteMovie(Movie movie, Function() onSuccess, Function(Exception e) onFail) {
    try {
      local.deleteMovie(movie).then((result) {
        if (result) {
          onSuccess();
        } else {
          onFail(Exception("Delete failed!"));
        }
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
        if (result) {
          onSuccess();
        } else {
          onFail(Exception("Insert failed!"));
        }
      });
    } catch (e) {
      onFail(e);
    }
  }

  @override
  updateMovie(Movie movie, Function() onSuccess, Function(Exception e) onFail) {
    try {
      local.updateMovie(movie).then((result) {
        if (result) {
          onSuccess();
        } else {
          onFail(Exception("Update failed!"));
        }
      });
    } catch (e) {
      onFail(e);
    }
  }
}
