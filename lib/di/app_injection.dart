import 'package:moviedb_flutter/data/repository/movie_repository.dart';
import 'package:moviedb_flutter/data/source/data_source.dart';

class AppInjection {
  MovieRepositoryImpl provideRepository() =>
      MovieRepositoryImpl(provideMovieRemoteDataSource());

  MovieRemoteDataSource provideMovieRemoteDataSource() =>
      MovieRemoteDataSource();
}
