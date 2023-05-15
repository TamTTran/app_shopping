import 'package:collection/collection.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/provider/product_provider.dart';
import 'package:data_mysql/provider/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListModel extends StatelessWidget {
  const WishListModel({
    super.key,
    required this.product,
  });

  final Product product;

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
                child: Image.network(
                   product.imageUrl.first),
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
                                         context
                                                      .read<Cart>()
                                                      .getItems
                                                      .firstWhereOrNull(
                                                          (element) =>
                                                              element
                                                                  .documentId ==
                                                              product
                                                                  .documentId) !=
                                                  null
                                              ? print('in cart'):
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
  }
}
