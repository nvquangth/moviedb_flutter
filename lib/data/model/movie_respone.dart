import 'package:moviedb_flutter/data/model/movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final int page;
  final int totalPages;

  MovieResponse._({this.movies, this.page, this.totalPages});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return MovieResponse._(
        movies: json['results'] != null
            ? List<Movie>.from(
                json['results'].map((obj) => Movie.fromJson(obj)))
            : null,
        page: json['page'],
        totalPages: json['total_pages']);
  }
}
