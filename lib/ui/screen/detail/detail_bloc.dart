import 'dart:async';

import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';

class DetailBloc extends BaseBloc {
  final _repository = injection.provideRepository();

  StreamController<Movie> _movieController = StreamController.broadcast();

  Stream<Movie> get movieStream => _movieController.stream;

  StreamSink<Movie> get _movieSink => _movieController.sink;

  StreamController<bool> _favoriteController = StreamController();

  Stream<bool> get favoriteStream => _favoriteController.stream;

  StreamSink<bool> get _favoriteSink => _favoriteController.sink;

  bool _isFavorite;
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

  checkFavorite() async {
    Movie movie = await _repository.getMovie(false, _movie.id);
    _isFavorite = movie == null ? false : true;
    _favoriteSink.add(_isFavorite);
  }

  handleFavorite() async {
    if (_isFavorite) {
      await _repository.deleteMovie(_movie);
      _isFavorite = false;
    } else {
      await _repository.insertMovie(_movie);
      _isFavorite = true;
    }
    _favoriteSink.add(_isFavorite);
  }
}
