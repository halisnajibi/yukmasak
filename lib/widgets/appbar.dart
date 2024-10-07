import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/svg/matahari.svg"),
              Text("Selamat malam",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor)),
            ],
          ),
          Text("Halis Najibi",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold, color: darkColor)),
        ],
      ),
    );
  }
}
