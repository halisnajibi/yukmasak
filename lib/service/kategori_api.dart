import 'dart:convert';

import 'package:masakyuk/model/kategori.dart';
import 'package:http/http.dart' as http;

class KategoriApi {
  final baseURL = "https://resep-hari-ini.vercel.app/";
  Future<List<KategoriModel>> fetchKategori() async {
    try {
      final response =
          await http.get(Uri.parse("${baseURL}/api/category/recipes"));
      List data = jsonDecode(response.body)['results'];
      return data.map((d) => KategoriModel.fromJson(d)).toList();
    } catch (e) {
      throw Exception('error..: ${e}');
    }
  }
}
