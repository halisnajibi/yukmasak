// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArtikelModel {
  String title;
  String thumb;
  String key;
  ArtikelModel({
    required this.title,
    required this.thumb,
    required this.key,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
        title: json['title'], thumb: json['thumb'], key: json['key']);
  }

  @override
  String toString() => 'ArtikelModel(title: $title, thumb: $thumb, key: $key)';
}
