import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/main_screens/cart_screen.dart';
import 'package:data_mysql/main_screens/visit_store.dart';
import 'package:data_mysql/minor_screens/full_screen_view.dart';
import 'package:data_mysql/model/product_modle.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/widget/appbar_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailScreen({Key? key, required this.proList})
      : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();
    late List<dynamic> imageList = widget.proList['proImage'];
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FullScreenView(imageList: imageList);
                      },
                    ));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Swiper(
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.fraction),
                          itemBuilder: (context, index) {
                            return Image(
                                image: NetworkImage(
                                    imageList[index].toString() +
                                        ('/') +
                                        (imageList.length.toString())));
                          },
                          itemCount: imageList.length,
                        ),
                      ),
                      Positioned(
                          left: 15,
                          top: 25,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                )),
                          )),
                      Positioned(
                          right: 15,
                          top: 25,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                )),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.proList['proname'],
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'USD  ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.proList['price']
                                    .toStringAsFixed(2)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.pink,
                              )),
                        ],
                      ),
                      Text(
                        widget.proList['instock'].toString() +
                            (' pieces available in stock'),
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const ProductDivider(
                          producItemDescription: '  Item Description  '),
                      Text(
                        'Ullamco cillum laboris quis cillum. Fugiat sint in dolore culpa ex culpa nisi ex culpa duis dolor elit cillum. Ut cillum ut duis deserunt nostrud tempor sunt culpa esse. Magna consectetur officia pariatur excepteur enim amet ad minim et dolor mollit non.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey.shade800),
                      ),
                    ],
                  ),
                ),
                const ProductDivider(
                    producItemDescription: 'Recommended Items'),
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: productStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text(
                          'This category \n\n ahs item yet !!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Acme',
                              letterSpacing: 1.5),
                        ));
                      }
                      return SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return Productmodel(
                                products: snapshot.data!.docs[index]);
                          },
                          staggeredTileBuilder: (context) {
                            return const StaggeredTile.fit(1);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return VisitStore(supid: widget.proList['sid']);
                        },
                      ));
                    },
                    icon: const Icon(Icons.store)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const CartScreen(
                          back: AppBarBackButton(),
                        );
                      },
                    ));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                YellowBtn(
                    label: 'add to cart'.toUpperCase(),
                    onPressed: () {
                      context.read<Cart>().addItem(
                            widget.proList['proname'],
                            widget.proList['price'],
                            1,
                            widget.proList['instock'],
                            widget.proList['proImage'],
                            widget.proList['proId'],
                            widget.proList['sid'],
                          );
                    },
                    width: 0.55)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDivider extends StatelessWidget {
  final String producItemDescription;
  const ProductDivider({super.key, required this.producItemDescription});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 40,
            width: 60,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            producItemDescription,
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
            width: 60,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          )
        ]),
      ),
    );
  }
}
