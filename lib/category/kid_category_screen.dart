import 'package:data_mysql/utilities/categ_list.dart';
import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
class KidCategoryScreen extends StatefulWidget {
  const KidCategoryScreen({ Key? key }) : super(key: key);

  @override
  _KidCategoryScreenState createState() => _KidCategoryScreenState();
}

class _KidCategoryScreenState extends State<KidCategoryScreen> {
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
                const CatagoryHeaderLabel(lableHeader: 'kids',),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(kids.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: 'kids',
                        subCategName: electronics[index + 1],
                        assetName: 'images/kids/kids$index.jpg',
                        subCategLabel: kids[index + 1],
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
          child: SidelBar(mainCategName: 'kids',))
      ]),
    );
  }
}