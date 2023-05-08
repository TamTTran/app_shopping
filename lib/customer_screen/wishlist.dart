import 'package:collection/collection.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/provider/wish_provider.dart';
import 'package:data_mysql/widget/alert_dialog.dart';
import 'package:data_mysql/widget/appbar_widgets.dart';
import 'package:data_mysql/widget/snackbar_widget.dart';
//import 'package:data_mysql/widget/alert_dialog.dart';
import 'package:data_mysql/widget/yellow_btn_widget.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  WishListScreenState createState() => WishListScreenState();
}

class WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: const AppBarBackButton(),
            elevation: 0,
            title: const Text(
              'WishList',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Acme',
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
               context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyAlertDialog(
                            context: context,
                            title: 'Clear Cart',
                            content: 'Are you to clear cart',
                            tabYes: () {
                              context.read<Wish>().clearWishCart();
                              Navigator.pop(context);
                            },
                            tabNo: () {
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(Icons.delete_forever),
                      color: Colors.black,
                    ) 
            ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? const CartWishItems()
              : const EmptyCart(),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  Text(
                    'Total:  \$',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '00.00',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              YellowBtn(
                label: 'Check out',
                onPressed: () {},
                width: 0.45,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Your Wish Is Empty!!!',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Acme', fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class CartWishItems extends StatelessWidget {
  const CartWishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
          itemCount: wish.count,
          itemBuilder: (context, index) {
            final product = wish.getWishItems[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.network(
                            wish.getWishItems[index].imageUrl.first),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      product.price.toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<Wish>()
                                                .removeItem(product);
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever),
                                        ),
                                        const SizedBox(width: 10),
                                        context
                                                    .watch<Cart>()
                                                    .getItems
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element
                                                                .documentId ==
                                                            product
                                                                .documentId) !=
                                                null
                                            ? const SizedBox()
                                            : IconButton(
                                                 onPressed: () {
                                           /*       context
                                                              .read<Cart>()
                                                              .getItems
                                                              .firstWhereOrNull(
                                                                  (element) =>
                                                                      element
                                                                          .documentId ==
                                                                      product
                                                                          .documentId) !=
                                                          null
                                                      ? print('in cart'): */
                                                      context
                                                          .read<Cart>()
                                                          .addItem(
                                                            product.name,
                                                            product.price,
                                                            product.qty,
                                                            product.qnty,
                                                            product.imageUrl,
                                                            product.documentId,
                                                            product.supid,
                                                          );
                                                },
                                                icon: const Icon(
                                                    Icons.add_shopping_cart),
                                              ),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
