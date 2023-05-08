import 'package:data_mysql/provider/product_provider.dart';
import 'package:flutter/foundation.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  int get count {
    return _list.length;
  }

  Future<void> addWishItem  (
    String name,
    double price,
    int qty,
    int qnty,
    List imageUrl,
    String documentId,
    String supid,
  ) async {
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

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishCart() {
    _list.clear();
    notifyListeners();
  }
  void removeThis(String id) {
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
    }
  
}
