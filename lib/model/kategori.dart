// ignore_for_file: public_member_api_docs, sort_constructors_first
class KategoriModel {
  String category;
  String url;
  String key;
  KategoriModel({
    required this.category,
    required this.url,
    required this.key,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
        category: json['category'], url: json['url'], key: json['key']);
  }

  @override
  String toString() =>
      'KategoriModel(category: $category, url: $url, key: $key)';
}
