import 'package:data_mysql/provider/product_provider.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;
    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
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
