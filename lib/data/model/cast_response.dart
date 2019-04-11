import 'package:moviedb_flutter/data/model/cast.dart';

class CastResponse {
  final List<Cast> casts;

  CastResponse._({this.casts});

  factory CastResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return CastResponse._(
        casts: json['cast'] != null
            ? List<Cast>.from(json['cast'].map((obj) => Cast.fromJson(obj)))
            : null);
  }
}
