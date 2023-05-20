// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/wish_provider.dart';

class CartModel extends StatelessWidget {
  const CartModel({
    super.key,
    required this.product,
    required this.cart
  });

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
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
                child:
                    Image.network(product.imageUrl.first),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  product.qty == 1
                                      ? IconButton(
                                          onPressed: () {
                                            showCupertinoModalPopup<
                                                void>(
                                              context: context,
                                              builder: (BuildContext
                                                      context) =>
                                                  CupertinoActionSheet(
                                                title: const Text(
                                                    'RemoveItem'),
                                                message: const Text(
                                                    'Are you sure to move this item ?'),
                                                actions: <
                                                    CupertinoActionSheetAction>[
                                                  CupertinoActionSheetAction(
                                                    child: const Text(
                                                        'Move to Wishlist'),
                                                    onPressed:
                                                        () async {
                                                      context.read<Wish>().getWishItems.firstWhereOrNull((element) =>
                                                                  element
                                                                      .documentId ==
                                                                  product
                                                                      .documentId) !=
                                                              null
                                                          ? context
                                                              .read<
                                                                  Cart>()
                                                              .removeItem(
                                                                  product)
                                                          : await context
                                                              .read<
                                                                  Wish>()
                                                              .addWishItem(
                                                                product
                                                                    .name,
                                                                product
                                                                    .price,
                                                                product
                                                                    .qty,
                                                                product
                                                                    .qnty,
                                                                product
                                                                    .imageUrl,
                                                                product
                                                                    .documentId,
                                                                product
                                                                    .supid,
                                                              );
                                                     
                                                      context
                                                          .read<Cart>()
                                                          .removeItem(
                                                              product);
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                  ),
                                                  CupertinoActionSheetAction(
                                                    onPressed: () {
                                                      context.read<Cart>().removeItem(product);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'Delete item'),
                                                  ),
                                                ],
                                                cancelButton:
                                                    TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.red),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            size: 18,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            cart.reduceByone(product);
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.minus,
                                            size: 18,
                                          ),
                                        ),
                                  Text(
                                    product.qty.toString(),
                                    style: product.qty == product.qnty
                                        ? const TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontFamily: 'Acme')
                                        : const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Acme'),
                                  ),
                                  IconButton(
                                    onPressed:
                                        product.qty == product.qnty
                                            ? null
                                            : () {
                                                cart.increment(product);
                                              },
                                    icon: const Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
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
  }
}
