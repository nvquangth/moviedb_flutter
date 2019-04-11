class Company {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  Company._({this.id, this.logoPath, this.name, this.originCountry});

  factory Company.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Company._(
        id: json['id'],
        logoPath: json['logo_path'],
        name: json['name'],
        originCountry: json['origin_country']);
  }
}
