import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals.dart';
import '../widgets/appbar.dart';
import '../widgets/banner_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/favresep.dart';
import '../widgets/kategori.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Appbar(),
              const SizedBox(
                height: 24,
              ),
              const BannerCard(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kategori",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      )),
                  Text("Semua ",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      )),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Kategori(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Resep Populer",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      )),
                  Text("Semua ",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      )),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const PopulerResep(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
