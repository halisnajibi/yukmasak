import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/globals.dart';

import '../model/artikel.dart';
import '../widgets/bottom_navigation.dart';
import 'package:http/http.dart' as http;

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});
  Future<List<ArtikelModel>> getData() async {
    final response = await http
        .get(Uri.parse("https://resep-hari-ini.vercel.app/api/articles/new"));
    final jsonData = jsonDecode(response.body)['results'] as List<dynamic>;
    return jsonData.map((json) => ArtikelModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Text("Artikel",
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.bold, color: darkColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<ArtikelModel>>(
              future: getData(),
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("error...${snapshot.error}"),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          final result = snapshot.data!.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              width: 327,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff063336)
                                        .withOpacity(0.10), // Warna bayangan
                                    spreadRadius: 0, // Jangkauan bayangan
                                    blurRadius: 16, // Keburaman bayangan
                                    offset:
                                        Offset(0, 2), // Posisi bayangan (x, y)
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network("${result.thumb}")),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${result.title}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: darkColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () => print('pindah halaman'),
                                        child: Container(
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text("Baca",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                }
                return Container();
              }),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
