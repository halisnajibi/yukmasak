import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/model/resep.dart';

import '../globals.dart';
import 'package:http/http.dart' as http;

import '../screens/resep_screen.dart';

class ResultResep extends StatelessWidget {
  final searchInput;
  const ResultResep({super.key, required this.searchInput});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardResep(input: searchInput),
      ],
    );
  }
}

// ignore: must_be_immutable
class CardResep extends StatelessWidget {
  String input;
  CardResep({super.key, required this.input});
  Future<List<ResepModel>> getResep() async {
    final response = await http.get(
        Uri.parse("https://resep-hari-ini.vercel.app/api/search?q=${input}"));
    final jsonData = jsonDecode(response.body)['results'] as List<dynamic>;
    return jsonData.map((json) => ResepModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ResepModel>>(
        future: getResep(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("error... ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                ...List.generate(
                  snapshot.data!.length,
                  (index) {
                    final data = snapshot.data!.elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff063336)
                                  .withOpacity(0.10), // Warna bayangan
                              spreadRadius: 0, // Jangkauan bayangan
                              blurRadius: 16, // Keburaman bayangan
                              offset: Offset(0, 2), // Posisi bayangan (x, y)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Image.network("${data.thumb}"))),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "${data.title}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: darkColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${data.times}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: darkColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 60,
                                        child: Text(
                                          "${data.difficulty}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: darkColor,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResepScreen(keyData: data.key))),
                                child: Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: darkColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
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
        });
  }
}
