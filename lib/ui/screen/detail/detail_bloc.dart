import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/data/model/movie.dart';

import 'dart:async';

class DetailBloc extends BaseBloc {
  final _repository = injection.provideRepository();

  StreamController<Movie> _movieController = StreamController.broadcast();
  Stream<Movie> get movieStream => _movieController.stream;
  StreamSink<Movie> get _movieSink => _movieController.sink;

  StreamController<bool> _favoriteController = StreamController();
  Stream<bool> get favoriteStream => _favoriteController.stream;
  StreamSink<bool> get favoriteSink => _favoriteController.sink;


  @override
  void dispose() {
  }

  getMovie(bool fromServer, int id) async {
    Movie movie = await _repository.getMovie2(fromServer, id);
    _movieSink.add(movie);
  }

  checkFavorite(int id) async {
    Movie movie = await _repository.getMovie2(false, id);
    favoriteSink.add(movie == null ? false : true);
  }
}