import 'package:flutter/material.dart';
import 'package:masakyuk/globals.dart';
import 'package:masakyuk/screens/home_screen.dart';

import '../screens/article_screen.dart';
import '../screens/search_screen.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({
    super.key,
  });

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.white,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        iconSize: 30,
        onTap: (value) {
          if (value == 0) {
            setState(() {
              index = 0;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          if (value == 1) {
            setState(() {
              index = 1;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          }
          if (value == 2) {
            setState(() {
              index = 2;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArticleScreen()));
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "icon"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: "icon"),
          BottomNavigationBarItem(icon: Icon(Icons.list_sharp), label: "icon"),
        ]);
  }
}
