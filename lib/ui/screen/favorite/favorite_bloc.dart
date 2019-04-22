import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc extends BaseBloc {
  final _repository = injection.provideRepository();
  final _moviesFetcher = PublishSubject<List<Movie>>();

  Observable<List<Movie>> get movies => _moviesFetcher.stream;

  @override
  void dispose() {
    _moviesFetcher.close();
  }

  getMovies() async {
    List<Movie> movies = await _repository.getMovies();
    _moviesFetcher.sink.add(movies);
  }
}
