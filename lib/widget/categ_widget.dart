import 'package:data_mysql/minor_screens/sub_categ_product_screen.dart';
import 'package:flutter/material.dart';

class SubCategModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;
  const SubCategModel({
    super.key,
    required this.assetName,
    required this.subCategName,
    required this.mainCategName,
    required this.subCategLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SubCategProductScreen(
                subCategName: subCategLabel,
                mainCategName: mainCategName,
              );
            },
          ));
        },
        child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Image(
              image: AssetImage(assetName),
            ),
          ),
          Center(
              child: Text(
            subCategLabel,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.visible,
          )),
        ]));
  }
}

class CatagoryHeaderLabel extends StatelessWidget {
  final String lableHeader;
  const CatagoryHeaderLabel({super.key, required this.lableHeader});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        lableHeader,
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}

class SidelBar extends StatelessWidget {
  final String mainCategName;
  const SidelBar({super.key, required this.mainCategName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.brown.withOpacity(0.21)),
          child: RotatedBox(
              quarterTurns: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    '<<',
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10),
                  ),
                  Text(
                    mainCategName.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10),
                  ),
                  const Text(
                    '>>',
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 10),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
