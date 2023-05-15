import 'package:collection/collection.dart';
import 'package:data_mysql/minor_screens/product_detail_screen.dart';
import 'package:data_mysql/provider/wish_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productmodel extends StatefulWidget {
  final dynamic products;
  const Productmodel({super.key, required this.products});

  @override
  State<Productmodel> createState() => _ProductmodelState();
}

class _ProductmodelState extends State<Productmodel> {
  
  @override
  Widget build(BuildContext context) {
    late var exitingItemWishList = context
      .read<Wish>()
      .getWishItems
      .firstWhereOrNull(
          (product) => product.documentId == widget.products['proId']);
  late var exitingItemCart = context
      .watch<Wish>()
      .getWishItems
      .firstWhereOrNull(
          (product) => product.documentId == widget.products['proId']);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(proList: widget.products);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 250,
                  ),
                  child: Image(
                      image: NetworkImage(widget.products['proImage'][0])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(widget.products['proname'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.products['price'].toStringAsFixed(2) + (' \$'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        widget.products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.pink,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  exitingItemWishList != null
                                      ? context
                                          .read<Wish>()
                                          .removeThis(widget.products['proId'])
                                      : context.read<Wish>().addWishItem(
                                            widget.products['proname'],
                                            widget.products['price'],
                                            1,
                                            widget.products['instock'],
                                            widget.products['proImage'],
                                            widget.products['proId'],
                                            widget.products['sid'],
                                          );
                                },
                                icon: exitingItemCart != null
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
