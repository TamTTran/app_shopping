import 'package:data_mysql/widget/categ_widget.dart';
import 'package:flutter/material.dart';
import '../utilities/categ_list.dart';

class MenCategoryScreen extends StatefulWidget {
  const MenCategoryScreen({Key? key}) : super(key: key);

  @override
  _MenCategoryScreenState createState() => _MenCategoryScreenState();
}

class _MenCategoryScreenState extends State<MenCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CatagoryHeaderLabel(
                  lableHeader: 'men',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    children: List.generate(men.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: 'men',
                        subCategName: men[index + 1],
                        assetName: 'images/men/men$index.jpg',
                        subCategLabel: men[index + 1],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0,
            right: 0,
            child: SidelBar(
              mainCategName: 'men',
            ))
      ]),
    );
  }
}
