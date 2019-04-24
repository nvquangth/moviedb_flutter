import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc extends BaseBloc {
  final _repository = injection.provideRepository();
  final _moviesFetcher = PublishSubject<List<Movie>>();
  List<Movie> _movies = [];

  Observable<List<Movie>> get movies => _moviesFetcher.stream;

  final PublishSubject<Movie> inFavoriteSubject = PublishSubject<Movie>();
  Sink<Movie> get inFavoriteMovie => inFavoriteSubject.sink;

  @override
  void dispose() async {
    await _moviesFetcher.drain();
    _moviesFetcher.close();
    print("favorite dispose");
  }

  getMovies() async {
    List<Movie> movies = await _repository.getMovies();
    _movies = movies;
    _moviesFetcher.sink.add(movies);
  }

  FavoriteBloc() {
    inFavoriteSubject.listen(_addOrRemoveFavorite);
  }

  _addOrRemoveFavorite(Movie movie) {
    for (int i = 0; i < _movies.length; i++) {
      if (movie.id == _movies[i].id) {
        _movies.removeAt(i);
        _moviesFetcher.sink.add(_movies);
        return;
      }
    }
    _movies.add(movie);
    _moviesFetcher.sink.add(_movies);
  }
}
