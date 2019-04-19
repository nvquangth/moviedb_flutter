import 'package:moviedb_flutter/data/model/movie_respone.dart';
import 'package:moviedb_flutter/di/app_injection.dart';
import 'package:moviedb_flutter/ui/base/base_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc extends BaseBloc {
  final _repository = injection.provideRepository();
  final _moviesFetcher = PublishSubject<MovieResponse>();

  Observable<MovieResponse> get movies => _moviesFetcher.stream;

  @override
  void dispose() {
    _moviesFetcher.close();
  }

  fetchMovies(int page) async {
    MovieResponse response = await _repository.getNowPlaying(page);
    _moviesFetcher.sink.add(response);
  }
}
