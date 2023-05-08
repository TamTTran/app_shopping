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