import 'package:moviedb_flutter/data/repository/movie_repository.dart';
import 'package:moviedb_flutter/data/source/remote/remote_data_source.dart';
import 'package:moviedb_flutter/data/source/local/local_data_source.dart';
import 'package:moviedb_flutter/data/source/local/sqflite/db_helper.dart';

class AppInjection {
  DbHelper provideDbHelper() => DbHelper();

  MovieRepositoryImpl provideRepository() => MovieRepositoryImpl(
      provideMovieRemoteDataSource(), provideMovieLocalDataSource());

  MovieRemoteDataSource provideMovieRemoteDataSource() =>
      MovieRemoteDataSource();

  MovieLocalDataSource provideMovieLocalDataSource() =>
      MovieLocalDataSource(provideDbHelper());
}
