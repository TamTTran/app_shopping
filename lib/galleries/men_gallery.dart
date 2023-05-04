import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../model/product_modle.dart';

class MenGallery extends StatefulWidget {
  const MenGallery({Key? key}) : super(key: key);

  @override
  _MenGalleryState createState() => _MenGalleryState();
}
class _MenGalleryState extends State<MenGallery> {
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'men')
      .snapshots();


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child:
          Text('This category \n\n ahs item yet !!!',
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 26,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontFamily: 'Acme',
            letterSpacing: 1.5
          ),));
        }

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return Productmodel(products:snapshot.data!.docs[index]);
            },
            staggeredTileBuilder: (context) {
              return const StaggeredTile.fit(1);
            },
          ),
        );
      },
    );
  }
}
