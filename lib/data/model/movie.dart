import 'package:moviedb_flutter/data/model/cast_response.dart';
import 'package:moviedb_flutter/data/model/company.dart';
import 'package:moviedb_flutter/data/model/genre.dart';
import 'package:moviedb_flutter/data/model/video_response.dart';

class Movie {
  final int id;
  final String title;
  final dynamic vote;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final List<Genre> genres;
  final List<Company> companies;
  final CastResponse castResponse;
  final VideoResponse videoResponse;
  bool isFavorite;

  Movie(
      {this.id,
      this.title,
      this.vote,
      this.posterPath,
      this.backdropPath,
      this.overview,
      this.releaseDate,
      this.genres,
      this.companies,
      this.castResponse,
      this.videoResponse,
      this.isFavorite});

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Movie(
        id: json['id'],
        title: json['title'],
        vote: json['vote_average'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        genres: json['genres'] != null
            ? List<Genre>.from(json['genres'].map((obj) => Genre.fromJson(obj)))
            : null,
        companies: json['production_companies'] != null
            ? List<Company>.from(json['production_companies']
                .map((obj) => Company.fromJson(obj)))
            : null,
        castResponse:
            json['credits'] != null ? CastResponse.fromJson(json['credits']) : null,
        videoResponse: json['videos'] != null
            ? VideoResponse.fromJson(json['videos'])
            : null);
  }
}
