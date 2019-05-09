import 'package:flutter/widgets.dart';
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc {
  MovieResponse _movieResponse;
  final _repository = injection.provideRepository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get movies => _moviesFetcher.stream;

  final PublishSubject<Movie> inFavoriteSubject = PublishSubject<Movie>();

  Sink<Movie> get inFavoriteMovie => inFavoriteSubject.sink;

  final _query = PublishSubject<String>();
  PublishSubject<String> get query => _query.stream;
  Sink<String> get querySink => query.sink;

  TextEditingController textEditingController = TextEditingController();

  SearchBloc() {
    inFavoriteSubject.listen(_updateFavorite);
    query.listen((data) {
      _searchMovies(data);
    });
  }

  @override
  void dispose() async {
    await _moviesFetcher.drain();
    await _query.drain();
    _moviesFetcher.close();
    _query.close();
  }

  clearQuery() {
    textEditingController.clear();
  }

  _searchMovies(String q) async {
    MovieResponse response = await _repository.searchRemoteMovies(q);
    _movieResponse = response;
    if (response.movies == null || response.movies.isEmpty) return;

    List<Movie> movies = response.movies;

    for (int i = 0; i < movies.length; i++) {
      Movie movie = await _repository.getMovie(false, movies[i].id);
      movie == null
          ? movies[i].isFavorite = false
          : movies[i].isFavorite = true;
    }
    response.movies = movies;
    _moviesFetcher.sink.add(response);
  }

  _updateFavorite(Movie movie) {
    for (int i = 0; i < _movieResponse.movies.length; i++) {
      if (movie.id == _movieResponse.movies[i].id) {
        _movieResponse.movies[i].isFavorite =
        !_movieResponse.movies[i].isFavorite;
        _moviesFetcher.sink.add(_movieResponse);
        return;
      }
    }
  }
}