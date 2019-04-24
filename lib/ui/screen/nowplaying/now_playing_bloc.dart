import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:moviedb_flutter/data/model/movie.dart';

class NowPlayingBloc extends BaseBloc {
  final _repository = injection.provideRepository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get movies => _moviesFetcher.stream;

  @override
  void dispose() async {
    await _moviesFetcher.drain();
    _moviesFetcher.close();
  }

  fetchMovies(int page) async {
    MovieResponse response = await _repository.getNowPlaying(page);
    if (response.movies == null || response.movies.isEmpty) return;

    List<Movie> movies = response.movies;

    for (int i = 0; i < movies.length; i++) {
      Movie movie = await _repository.getMovie(false, movies[i].id);
      movie == null ? movies[i].isFavorite = false : movies[i].isFavorite = true;
    }
    response.movies = movies;
    _moviesFetcher.sink.add(response);
  }
}
