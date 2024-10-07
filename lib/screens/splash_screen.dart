import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masakyuk/globals.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          SvgPicture.asset("assets/svg/pattern.svg"),
          Center(child: SvgPicture.asset("assets/svg/ilustration.svg")),
          Positioned(
              top: 550,
              right: 0,
              left: 0,
              child: Text(
                "Yuk\n Masak..",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
