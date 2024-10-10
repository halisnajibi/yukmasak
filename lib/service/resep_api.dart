import 'dart:convert';

import 'package:masakyuk/model/resep.dart';
import 'package:http/http.dart' as http;

class ResepApi {
  final baseUrl = "https://resep-hari-ini.vercel.app/api";
  Future<List<ResepModel>> fetchFavResep() async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}/recipes-length/?limit=5'));
      List data = jsonDecode(response.body)['results'];
      return data.map((d) => ResepModel.fromJson(d)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ResepModel>> fectSearchResep(String search) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}/search?q=${search}'));
      List data = jsonDecode(response.body)['results'];
      return data.map((d) => ResepModel.fromJson(d)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ResepModel> fetchDetailResep(String key) async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}/recipe/${key}"));
      final data = jsonDecode(response.body)['results'];
      return ResepModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
