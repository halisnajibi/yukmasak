import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/model/resep.dart';
import 'package:masakyuk/service/resep_api.dart';

import '../globals.dart';

class PopulerResep extends StatelessWidget {
  PopulerResep({
    super.key,
  });
  final serviceResep = ResepApi();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<ResepModel>>(
          future: serviceResep.fetchFavResep(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("error... ${snapshot.error}"),
              );
            }
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(snapshot.data!.length, (index) {
                    final result = snapshot.data!.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ResepItem(
                          title: "${result.title}",
                          img: "${result.thumb}",
                          time: "${result.times}",
                          difficulty: "${result.difficulty}"),
                    );
                  })
                ],
              );
            }
            return Container();
          }),
    );
  }
}

// ignore: must_be_immutable
class ResepItem extends StatelessWidget {
  String title;
  String img;
  String time;
  String difficulty;
  ResepItem({
    super.key,
    required this.title,
    required this.img,
    required this.time,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff063336).withOpacity(0.10), // Warna bayangan
            spreadRadius: 0, // Jangkauan bayangan
            blurRadius: 16, // Keburaman bayangan
            offset: Offset(0, 2), // Posisi bayangan (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), // Border radius
              ),
              clipBehavior:
                  Clip.hardEdge, // Agar gambar tetap berada di dalam radius
              child: Image.network(
                img,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${time}",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                Text("${difficulty}",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
