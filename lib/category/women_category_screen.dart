
import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';

class WomenCategoryScreen extends StatefulWidget {
  const WomenCategoryScreen({Key? key}) : super(key: key);

  @override
  _WomenCategoryScreenState createState() => _WomenCategoryScreenState();
}
class _WomenCategoryScreenState extends State<WomenCategoryScreen> {

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
              const  CatagoryHeaderLabel(lableHeader: 'women',),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(men.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: 'women',
                        subCategName: men[index + 1],
                        assetName: 'images/women/women$index.jpg',
                        subCategLabel: men[index + 1],
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
          child: SidelBar(mainCategName: 'women',))
      ]),
    );
  }
}

