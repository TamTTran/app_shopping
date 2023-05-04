import 'package:data_mysql/main_screens/category_screen.dart';
import 'package:data_mysql/main_screens/dashborad_screen.dart';
import 'package:data_mysql/main_screens/home_screen.dart';
import 'package:data_mysql/main_screens/stories_screen.dart';
import 'package:data_mysql/main_screens/upload_product.dart';
import 'package:flutter/material.dart';

class SuplierHomeScreen extends StatefulWidget {
  const SuplierHomeScreen({Key? key}) : super(key: key);

  @override
  _CSuplierHomeScreenState createState() => _CSuplierHomeScreenState();
}

class _CSuplierHomeScreenState extends State<SuplierHomeScreen> {
  int _selectionIndex = 0;
  final List<Widget> _tab = const [
    HomeScreen(),
    CategoryScreen(),
    StoriesScreen(),
    DashboradScreen(),
    UploadProduct()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tab[_selectionIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _selectionIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Stores"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Upload"),
        ],
        onTap: (index) {
          setState(() {
            _selectionIndex = index;
          });
        },
      ),
    );
  }
}
