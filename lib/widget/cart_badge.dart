import 'package:data_mysql/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class Cart_Badge extends StatelessWidget {
  const Cart_Badge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
        showBadge:
            context.read<Cart>().getItems.isEmpty ? false : true,
        badgeStyle:
            const badges.BadgeStyle(badgeColor: Colors.yellow),
        position: badges.BadgePosition.topEnd(top: -10, end: -12),
        badgeContent: Text(
          context.watch<Cart>().getItems.length.toString(),
          style: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600),
        ),
        child: const Icon(Icons.shopping_cart));
  }
}