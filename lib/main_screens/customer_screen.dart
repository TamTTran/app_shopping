import 'package:data_mysql/main_screens/cart_screen.dart';
import 'package:data_mysql/main_screens/category_screen.dart';
import 'package:data_mysql/main_screens/home_screen.dart';
import 'package:data_mysql/main_screens/personal_profile_screen.dart';
import 'package:data_mysql/main_screens/stories_screen.dart';
import 'package:data_mysql/widget/Cart_badge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _selectionIndex = 0;
  final List<Widget> _tab =  [
    const HomeScreen(),
    const CategoryScreen(),
    const StoriesScreen(),
    const CartScreen(),
    PersonalProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
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
          BottomNavigationBarItem(icon: Cart_Badge(), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
