import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/minor_screens/place_order_scrren.dart';
import 'package:data_mysql/widget/appbar_widgets.dart';
import 'package:data_mysql/widget/yellow_btn_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class PaymentScrren extends StatefulWidget {
  const PaymentScrren({Key? key}) : super(key: key);

  @override
  _PaymentScrrenState createState() => _PaymentScrrenState();
}

class _PaymentScrrenState extends State<PaymentScrren> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    double totalPaid = context.read<Cart>().totalPrice + 10.00;
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
                  title: const AppBarTitle(title: 'Payment'),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${totalPrice.toStringAsFixed(2)} USD',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total order',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    '${totalPrice.toStringAsFixed(2)} USD',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Cost',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    '10.00 USD',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                            child: Column(
                              children: [
                                RadioListTile(
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Cash on Delivery'),
                                  subtitle: const Text('Pay Cash At Home'),
                                ),
                                RadioListTile(
                                    value: 2,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    },
                                    title: const Text('Cash on Delivery'),
                                    subtitle: const Row(children: [
                                      Icon(
                                        FontAwesomeIcons.paypal,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(
                                          FontAwesomeIcons.ccMastercard,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.ccVisa,
                                        color: Colors.blue,
                                      ),
                                    ])),
                                RadioListTile(
                                  value: 3,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Cash on Delivery'),
                                  subtitle: const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.paypal,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(
                                          FontAwesomeIcons.ccPaypal,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: YellowBtn(
                    label: "Confirm ${totalPrice.toStringAsFixed(2)}",
                    onPressed: () {
                      if (selectedValue == 1) {
                        
                      } else if (selectedValue == 2) {
                        print('visa');
                      } else if (selectedValue == 3) {
                        print('paypal');
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

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.title,
    required this.widget,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final Widget widget;
  final int groupValue;
  final int value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: ListTile(
        leading: const Icon(
          Icons.attach_money,
          color: Colors.blue,
          size: 35,
        ),
        title: Text(title),
        subtitle: Radio<int>(
          groupValue: groupValue,
          value: value,
          onChanged: (int? newValue) {
            onChanged(newValue);
          },
        ),
      ),
    );
  }
}
