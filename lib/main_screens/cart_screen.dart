import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/widget/yellow_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({Key? key, this.back}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
              IconButton(
                onPressed: () {
                 context.read<Cart>().clearCart();
                },
                icon: const Icon(Icons.delete_forever),
                color: Colors.black,
              )
            ],
          ),
          body:  context.watch<Cart>().getItems.isNotEmpty ? 
               Consumer<Cart>(builder: (context, cart, child) {
                  return ListView.builder(
                    itemCount: cart.count,
                    itemBuilder: (context, index) {
                      final product = cart.getItems[index];
                      return Padding( 
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: SizedBox(
                            height: 100,
                            child: Row(children: [
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: Image.network(cart.getItems[index].imageUrl.first),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  color: Colors.red)
                                            ), 
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Row(
                                                children: [
                                                product.qty == 1
                                                      ? IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 18,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            cart.reduceByone(
                                                                product);
                                                          },
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 18,
                                                          ),
                                                        ),
                                                  Text(
                                                    product.qty.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Acme'),
                                                  ),
                                                  IconButton(
                                                    onPressed: product.qty ==
                                                            product.qnty
                                                        ? null
                                                        : () {
                                                            cart.increment(
                                                                product);
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
                            ]),
                          ),
                        ),
                      );
                    },
                  );
                })
               : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Cart Is Empty!!!',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Acme',
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(50, 50),
                              backgroundColor: Colors.lightBlueAccent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          onPressed: () {
                            Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : Navigator.pushReplacementNamed(
                                    context, '/customer_screen');
                          },
                          child: const Text(
                            'continue shopping',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ]),
                ), 
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  Text(
                    'Total: \$ ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '00:00',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              YellowBtn(
                label: 'Check out',
                onPressed: () {},
                width: 0.45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
