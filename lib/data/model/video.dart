class Video {
  final String id;
  final String key;
  final String name;
  final String type;

  Video._({this.id, this.key, this.name, this.type});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Video._(
        id: json['id'],
        key: json['key'],
        name: json['name'],
        type: json['type']);
  }
}
