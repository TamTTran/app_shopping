import 'package:data_mysql/category/accessories.category_screen.dart';
import 'package:data_mysql/category/bags_category_screen.dart';
import 'package:data_mysql/category/beayty_category_screen.dart';
import 'package:data_mysql/category/electronic_category_screen.dart';
import 'package:data_mysql/category/homegrade_category_screen.dart';
import 'package:data_mysql/category/kid_category_screen.dart';
import 'package:data_mysql/category/men_category_screen.dart';
import 'package:data_mysql/category/shoes_category_screen.dart';
import 'package:data_mysql/category/women_category_screen.dart';

import 'package:data_mysql/widget/fake_Search.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();   
  List<ItemData> item = [
    ItemData(lable: 'men'),       
    ItemData(lable: 'women'),
    ItemData(lable: 'shoes'),
    ItemData(lable: 'bages'),
    ItemData(lable: 'electronics'),
    ItemData(lable: 'accessor'),
    ItemData(lable: 'hoem & garden'),
    ItemData(lable: 'kids'),
    ItemData(lable: 'beauty'),  
  ];
  @override
  void initState() {
    super.initState();
    for (var element in item) {
              element.isSelected = false;
            }
            setState(() {
              item[0].isSelected = true;
            });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const FakeScreen(),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
          Positioned(bottom: 0, right: 0, child: categView(size))
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(index, duration: const Duration(milliseconds: 1000), curve: Curves.linear);
              for (var element in item) {
                element.isSelected = false;
              }
              setState(() {
                item[index].isSelected = true;
              });
            },
            child: Container(
                color: item[index].isSelected == true
                    ? Colors.white
                    : Colors.grey.shade300,
                child: SizedBox(
                    height: 100,
                    child: Center(child: Text(item[index].lable)))),
          );
        },
      ),
    );
  }

  Widget categView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
              for (var element in item) {
              element.isSelected = false;
            }
            setState(() {
              item[value].isSelected = true;
            });
          },
          scrollDirection: Axis.vertical,
          children: const [
            MenCategoryScreen(),
            WomenCategoryScreen(),
            ShoesCategoryScreen(),
            BagsCategoryScreen(),
            ElectronicCategoryScreen(),
            AccessoriesCategoryScreen(),
            HomegradeCategoryScreen(),
            KidCategoryScreen(),
            BeaytyCategoryScreen(),
            
          ]),
    );
  }
}

class ItemData {
  String lable = '';
  bool isSelected = false;
  ItemData({required this.lable, this.isSelected = false});
}
