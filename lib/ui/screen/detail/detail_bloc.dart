import 'dart:async';

import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';

class DetailBloc extends BaseBloc {
  final _repository = injection.provideRepository();

  StreamController<Movie> _movieController = StreamController.broadcast();

  Stream<Movie> get movieStream => _movieController.stream;

  StreamSink<Movie> get _movieSink => _movieController.sink;

  StreamController<int> _favoriteController = StreamController.broadcast();

  Stream<int> get favoriteStream => _favoriteController.stream;

  StreamSink<int> get _favoriteSink => _favoriteController.sink;

  ///
  ///  1:  true: auto check
  /// 11:  true: event check
  ///  2: false: auto check
  /// 22: false: event check
  ///
  int _isFavorite = 2;
  Movie _movie;

  @override
  void dispose() {
    _movieController.close();
    _favoriteController.close();
  }

  getMovie(bool fromServer, Movie movie) async {
    _movie = movie;
    Movie m = await _repository.getMovie(fromServer, movie.id);
    _movieSink.add(m);
  }

  ///
  /// auto check favorite
  ///
  checkFavorite() async {
    Movie movie = await _repository.getMovie(false, _movie.id);
    _isFavorite = movie == null ? 2 : 1;
    _favoriteSink.add(_isFavorite);
  }

  ///
  /// event check favorite
  ///
  handleFavorite() async {
    if (_isFavorite == 1 || _isFavorite == 11) {
      await _repository.deleteMovie(_movie);
      _isFavorite = 22;
    } else if (_isFavorite == 2 || _isFavorite == 22) {
      await _repository.insertMovie(_movie);
      _isFavorite = 11;
    }
    _favoriteSink.add(_isFavorite);
  }
}
