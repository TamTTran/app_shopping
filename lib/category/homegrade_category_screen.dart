import 'package:data_mysql/utilities/categ_list.dart';
import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
class HomegradeCategoryScreen extends StatefulWidget {
  const HomegradeCategoryScreen({ Key? key }) : super(key: key);

  @override
  _HomegradeCategoryScreenState createState() => _HomegradeCategoryScreenState();
}

class _HomegradeCategoryScreenState extends State<HomegradeCategoryScreen> {
  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [ 
          Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width*0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatagoryHeaderLabel(lableHeader: 'Home & graden',),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(homeandgarden.length = 1, (index) {
                      return SubCategModel(
                        mainCategName: 'homeandgarden',
                        subCategName: homeandgarden[index + 1],
                        assetName: 'images/homegarden/home$index.jpg',
                        subCategLabel: homeandgarden[index + 1],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
   const  Positioned(
          bottom: 0,
          right: 0,
          child: SidelBar(mainCategName: 'homeandgarden',))
      ]),
    );
  }
}