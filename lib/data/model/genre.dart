class Genre {
  final int id;
  final String name;

  Genre._({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Genre._(id: json['id'], name: json['name']);
  }
}
