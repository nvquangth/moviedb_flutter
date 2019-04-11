class Cast {
  final int id;
  final int castId;
  final String name;
  final String character;
  final String profilePath;

  Cast._({this.id, this.castId, this.name, this.character, this.profilePath});

  factory Cast.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Cast._(
        id: json['id'],
        castId: json['cast_id'],
        name: json['name'],
        character: json['character'],
        profilePath: json['profile_path']);
  }
}
