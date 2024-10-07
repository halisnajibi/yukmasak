import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/widgets/bottom_navigation.dart';

import '../globals.dart';
import '../model/resep.dart';
import 'package:http/http.dart' as http;

import 'search_screen.dart';

class ResepScreen extends StatelessWidget {
  final keyData;
  ResepScreen({super.key, required this.keyData});
  @override
  Widget build(BuildContext context) {
    final String img;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            child: Icon(Icons.arrow_back)),
        title: Text("Resep",
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.bold, color: darkColor)),
      ),
      body: Stack(
        children: [
          FutureBuilder<ResepModel>(
              future: DetailResep(keyData: keyData)
                  .getData(), // Panggil getData di sini
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.hasData) {
                  final result = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage(result.thumb), // Gunakan NetworkImage
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return Container(); // Jika tidak ada data
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: DetailResep(keyData: keyData),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class DetailResep extends StatelessWidget {
  final keyData;
  DetailResep({super.key, required this.keyData});

  Future<ResepModel> getData() async {
    final response = await http.get(
        Uri.parse("https://resep-hari-ini.vercel.app/api/recipe/$keyData"));
    final jsonData = jsonDecode(response.body)['results'];
    return ResepModel.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 35),
      child: FutureBuilder<ResepModel>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text("error .... ${snapshot.error}");
            }
            if (snapshot.hasData) {
              final result = snapshot.data!;
              return ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          "${result.title}",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: darkColor,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.grey[500],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${result.difficulty}",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${result.desc}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconData1(
                          time: result.times, kalo: result.colories ?? '0'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IngredientSteap(result: result)
                ],
              );
            }

            return Container();
          }),
    );
  }
}

class IngredientSteap extends StatefulWidget {
  final ResepModel result;
  IngredientSteap({super.key, required this.result});

  @override
  State<IngredientSteap> createState() => _IngredientSteapState();
}

class _IngredientSteapState extends State<IngredientSteap> {
  bool bahan = true;
  bool steep = false;
  @override
  Widget build(BuildContext context) {
    List<String> ingredient = widget.result.ingredient!;
    List<String> step = widget.result.step!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 326,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    bahan = true;
                    steep = false;
                  });
                },
                child: Container(
                    width: 160,
                    height: 46,
                    decoration: BoxDecoration(
                      color: bahan ? darkColor : Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text("Bahan",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    bahan = false;
                    steep = true;
                  });
                },
                child: Container(
                    width: 160,
                    height: 46,
                    decoration: BoxDecoration(
                      color: steep ? darkColor : Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text("Steap",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        bahan
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (ingredient
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text("-${item}"),
                            ))
                        .toList() ??
                    []),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (step
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text("${item}"),
                            ))
                        .toList() ??
                    []),
              )
      ],
    );
  }
}

class IconData1 extends StatelessWidget {
  String time;
  String kalo;
  IconData1({
    super.key,
    required this.kalo,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    print(kalo);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.schedule, color: darkColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text("${time}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkColor,
                )),
          ],
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.linear_scale_outlined, color: darkColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text("${kalo}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: darkColor,
                )),
          ],
        )
      ],
    );
  }
}
