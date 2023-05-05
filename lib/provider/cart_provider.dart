import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  int qty = 1;
  int qnty;
  List imageUrl;
  String documentId;
  String supid;

  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.qnty,
    required this.documentId,
    required this.imageUrl,
    required this.supid,
  });
}

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int? get count {
    _list.length;
  }

  void addItem(String name, double price, int qty, int qnty, List imageUrl,
      String documentId, String supid) {
        final product = Product(name: name, price: price, qty: qty, qnty: qnty, documentId: documentId, imageUrl: imageUrl, supid: supid);
      }
}
