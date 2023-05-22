import 'package:data_mysql/utilities/categ_list.dart';
import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
class ElectronicCategoryScreen extends StatefulWidget {
  const ElectronicCategoryScreen({ Key? key }) : super(key: key);

  @override
  _ElectronicCategoryScreenState createState() => _ElectronicCategoryScreenState();
}

class _ElectronicCategoryScreenState extends State<ElectronicCategoryScreen> {
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
                const CatagoryHeaderLabel(lableHeader: 'electronics',),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(electronics.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: 'electronics',
                        subCategName: electronics[index + 1],
                        assetName: 'images/electronics/electronics$index.jpg',
                        subCategLabel: electronics[index + 1],
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
          child: SidelBar(mainCategName: 'electronics',))
      ]),
    );
  }
}