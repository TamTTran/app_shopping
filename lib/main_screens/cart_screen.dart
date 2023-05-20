import 'package:data_mysql/minor_screens/place_order_scrren.dart';
import 'package:data_mysql/model/cart_model.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/widget/alert_dialog.dart';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({Key? key, this.back}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = context.read<Cart>().totalPrice;
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: widget.back,
            elevation: 0,
            title: const Text(
              'Cart',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Acme',
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
              context.watch<Cart>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyAlertDialog(
                            context: context,
                            title: 'Clear Cart',
                            content: 'Are you to clear cart',
                            tabYes: () {
                              context.read<Cart>().clearCart();
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
          body: context.watch<Cart>().getItems.isNotEmpty
              ? const CartItems()
              : const EmptyCart(),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text(
                    'Total:  \$',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.54,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: MaterialButton(
                    onPressed: total == 0.0
                        ? null
                        : () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const  PlaceOrderScrren();
                              },
                            ));
                          },
                    child: const Text('CHECK OUT'),
                  )),
              /* YellowBtn(
                label: 'Check out',
                onPressed: () {},
                width: 0.45,
              ) */
            ],
          ),
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
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Your Cart Is Empty!!!',
          style:
              TextStyle(color: Colors.black, fontFamily: 'Acme', fontSize: 30),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(50, 50),
              backgroundColor: Colors.lightBlueAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          onPressed: () {
            Navigator.canPop(context)
                ? Navigator.pop(context)
                : Navigator.pushReplacementNamed(context, '/customer_screen');
          },
          child: const Text(
            'continue shopping',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ]),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final product = cart.getItems[index];
            return CartModel(product: product, cart: context.read<Cart>());
          },
        );
      },
    );
  }
}
