import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/globals.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/result_resep.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String inputan = '';
  bool cari = false;
  TextEditingController searchInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Text("Search",
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.bold, color: darkColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: secondaryColor, strokeAlign: 1),
                ),
                child: TextField(
                  autofocus: false,
                  autocorrect: false,
                  controller: searchInput,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      hintText: "Search",
                      prefixIcon: GestureDetector(
                        onTap: () {
                          // print("${searchInput.text}");
                          setState(() {
                            inputan = searchInput.text;
                            cari = true;
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Resep ${inputan.isNotEmpty ? inputan : ''}",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  )),
              SizedBox(
                height: 12,
              ),
              cari == true
                  ? ResultResep(searchInput: searchInput.text)
                  : Center(child: Text("silahkan cari resep..")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
