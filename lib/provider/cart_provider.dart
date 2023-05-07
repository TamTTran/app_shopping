import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  int qty = 1;
  int qnty;
  List imageUrl = [];
  String documentId;
  String supid;

  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.qnty,
    required this.imageUrl,
    required this.documentId,
    required this.supid,
  });
  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int get count {
   return _list.length;
  }

  void addItem(  
    String name,
     double price,
      int qty, 
      int qnty, 
      List imageUrl,
      String documentId, 
      String supid,      
      
      ) {
    final product = Product(
        name: name,
        price: price,
        qty: 1,
        qnty: qnty,
        imageUrl: imageUrl,
        documentId: documentId,
        supid: supid);

    _list.add(product);
    notifyListeners();
  }

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void reduceByone(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
