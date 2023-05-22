import 'package:data_mysql/minor_screens/payment_scrren.dart';
import 'package:data_mysql/provider/cart_provider.dart';
import 'package:data_mysql/widget/appbar_widgets.dart';
import 'package:data_mysql/widget/yellow_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class PlaceOrderScrren extends StatefulWidget {
  const PlaceOrderScrren({Key? key}) : super(key: key);

  @override
  _PlaceOrderScrrenState createState() => _PlaceOrderScrrenState();
}

CollectionReference customer =
    FirebaseFirestore.instance.collection('customer');

class _PlaceOrderScrrenState extends State<PlaceOrderScrren> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = context.read<Cart>().totalPrice;
    return FutureBuilder<DocumentSnapshot>(
      future: customer.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Material(
            color: Colors.grey.shade200,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade200,
                  leading: const AppBarBackButton(),
                  title: const AppBarTitle(title: 'Place Order'),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Name: ${data['name']}'),
                                Text('Phone: ${data['phone']}'),
                                Text('Address: ${data['address']}'),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:
                              Consumer<Cart>(builder: (context, cart, child) {
                            return ListView.builder(
                              itemCount: cart.count,
                              itemBuilder: (context, index) {
                                final order = cart.getItems[index];
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.3),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(
                                                order.imageUrl.first),
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                order.name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      order.price
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade800),
                                                    ),
                                                    Text(
                                                      'x ${order.qty}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade800),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: YellowBtn(
                    label: "Confirm ${totalPrice.toStringAsFixed(2)} USD",
                    onPressed: () {
                      if (totalPrice > 0) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const PaymentScrren();
                          },
                        ));
                      }
                    },
                    width: 1,
                  ),
                ),
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
