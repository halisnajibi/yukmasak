import 'dart:convert';

import 'package:masakyuk/model/artikel.dart';
import 'package:http/http.dart' as http;

class ArtikelApi {
  final baseURL = "https://resep-hari-ini.vercel.app/api";
  Future<List<ArtikelModel>> fecthArtikel() async {
    try {
      final response = await http.get(Uri.parse('${baseURL}/articles/new'));
      List data = jsonDecode(response.body)['results'];
      return data.map((d) => ArtikelModel.fromJson(d)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
