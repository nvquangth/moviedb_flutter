class Movie {
  final int id;
  final String title;
  final dynamic vote;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;

  // private constructor
  Movie._(
      {this.id,
      this.title,
      this.vote,
      this.posterPath,
      this.backdropPath,
      this.overview,
      this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Movie._(
        id: json['id'],
        title: json['title'],
        vote: json['vote_average'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        overview: json['overview'],
        releaseDate: json['release_date']);
  }
}
