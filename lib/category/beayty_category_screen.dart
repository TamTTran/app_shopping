import 'package:data_mysql/utilities/categ_list.dart';
import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
class BeaytyCategoryScreen extends StatefulWidget {
  const BeaytyCategoryScreen({ Key? key }) : super(key: key);

  @override
  _BeaytyCategoryScreenState createState() => _BeaytyCategoryScreenState();
}

class _BeaytyCategoryScreenState extends State<BeaytyCategoryScreen> {
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
              const  CatagoryHeaderLabel(lableHeader: 'beauty',),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(beauty.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: 'beauty',
                        subCategName: beauty[index + 1],
                        assetName: 'images/beauty/beauty$index.jpg',
                        subCategLabel: beauty[index + 1],
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
          child: SidelBar(mainCategName: 'beauty',))
      ]),
    );
  }
}