import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';
import '../model/kategori.dart';
import 'package:http/http.dart' as http;

class Kategori extends StatelessWidget {
  const Kategori({
    super.key,
  });

  Future<List<KategoriModel>> _getKategori() async {
    final response = await http.get(
        Uri.parse("https://resep-hari-ini.vercel.app/api/category/recipes"));
    final jsonData = jsonDecode(response.body)['results'] as List<dynamic>;
    return jsonData
        .map((json) => KategoriModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<KategoriModel>>(
          future: _getKategori(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text("errorr... ${snapshot.error}"),
              );
            }
            if (snapshot.hasData) {
              return Row(children: [
                ...List.generate(
                  snapshot.data!.length,
                  (index) {
                    final result = snapshot.data!.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: index == 0 ? primaryColor : secondaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("${result.category}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ]);
            }
            return Container();
          }),
    );
  }
}
