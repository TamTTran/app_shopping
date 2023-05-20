
import 'package:data_mysql/model/wishlist_modle.dart';
import 'package:data_mysql/provider/wish_provider.dart';
import 'package:data_mysql/widget/alert_dialog.dart';
import 'package:data_mysql/widget/appbar_widgets.dart';
//import 'package:data_mysql/widget/yellow_btn_widget.dart';
import 'package:flutter/material.dart';
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
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
            return WishListModel(product: product);
          },
        );
      },
    );
  }
}

