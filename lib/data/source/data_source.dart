import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviedb_flutter/data/model/movie.dart';
import 'package:moviedb_flutter/data/model/movie_respone.dart';

abstract class MovieRemote {
  Future<MovieResponse> getNowPlaying(int page);

  Future<Movie> getMovie(int id);
}

abstract class MovieLocal {}

class MovieRemoteDataSource implements MovieRemote {
  static const String API_KEY = "3956f50a726a2f785334c24759b97dc6";
  static const String BASE_URL = "api.themoviedb.org";
  static const String NOW_PLAYING_PATH = "/3/movie/now_playing";
  static const String MOVIE_PATH = "movie";
  static const String PAGE_PARAM = "page";
  static const String API_KEY_PARAM = "api_key";

  static MovieRemoteDataSource _instance;

  factory MovieRemoteDataSource() {
    if (_instance == null) {
      _instance = MovieRemoteDataSource._internal();
    }
    return _instance;
  }

  MovieRemoteDataSource._internal();

  @override
  Future<Movie> getMovie(int id) {
    return null;
  }

  @override
  Future<MovieResponse> getNowPlaying(int page) async {
    var url = Uri.https(BASE_URL, NOW_PLAYING_PATH,
        {API_KEY_PARAM: API_KEY, PAGE_PARAM: page.toString()});

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Load data movie failed');
    }
  }
}
