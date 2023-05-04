import 'package:data_mysql/galleries/men_gallery.dart';
import 'package:data_mysql/galleries/shoes_gallery.dart';
import 'package:data_mysql/galleries/women_gallery.dart';
import 'package:flutter/material.dart';
import '../widget/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 9,
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const FakeScreen(),
            bottom: const TabBar(
                overlayColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 170, 130, 238)),
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 231, 229, 237)),
                isScrollable: true,
                indicatorColor: Colors.cyanAccent,
                indicatorWeight: 2,
                tabs: [
                  ReapeatedTab(label: 'Men'),
                  ReapeatedTab(label: 'Women'),
                  ReapeatedTab(label: 'Shoes'),
                  ReapeatedTab(label: 'Bags'),
                  ReapeatedTab(label: 'Electronics'),
                  ReapeatedTab(label: 'Accessor ise'),
                  ReapeatedTab(label: 'Hoem & Garden'),
                  ReapeatedTab(label: 'Kids'),
                  ReapeatedTab(label: 'Beaty'),
                ]),
          ),
          body: const TabBarView(
            children: [
              MenGallery(),
              WomenGallery(),
              ShoesGallery(),
              Center(
                child: Text('Bags screen'),
              ),
              Center(
                child: Text('Electronics screen'),
              ),
              Center(
                child: Text('Accessor ise screen'),
              ),
              Center(
                child: Text('Hoem & Garden screen'),
              ),
              Center(
                child: Text('Kids screen'),
              ),
              Center(
                child: Text('Beaty screen'),
              ),
            ],
          ),
        ));
  }
}

class ReapeatedTab extends StatelessWidget {
  final String label;
  const ReapeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
