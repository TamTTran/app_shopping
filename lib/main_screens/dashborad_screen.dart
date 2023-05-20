// ignore_for_file: use_build_context_synchronously

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/dashboard_component/edit_profile.dart';
import 'package:data_mysql/dashboard_component/manager_products.dart';
//import 'package:data_mysql/dashboard_component/my_store.dart';
import 'package:data_mysql/dashboard_component/suplier_order.dart';
import 'package:data_mysql/dashboard_component/supp_balance.dart';
import 'package:data_mysql/dashboard_component/supp_statics.dart';
import 'package:data_mysql/main_screens/visit_store.dart';
import 'package:data_mysql/widget/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage product',
  'balance',
  'statics'
];
List<IconData> icon = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];
List<Widget> pages = [
  VisitStore(supid: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrder(),
  const EditProfie(),
  const ManagerProdcuts(),
  const BalanceSceen(),
  const StaticseSceen(),
];

class DashboradScreen extends StatelessWidget {
  const DashboradScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style:
              TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Acme'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyAlertDialog(
                  context: context,
                  title: 'Log out',
                  content: 'Are you log out ?',
                  tabNo: () {
                    Navigator.pop(context);
                  },
                  tabYes: () async {
                    Navigator.pop(context);
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                        context, '/welcome_come_screen');
                  });
            },
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pages[index]));
                },
                child: Card(
                  elevation: 30,
                  shadowColor: Colors.purpleAccent.shade400,
                  color: Colors.blueAccent.withOpacity(0.7),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                            Icon(
                              icon[index],
                              size: 40,
                              color: Colors.yellowAccent,
                            ),
                        Text(
                          label[index].toUpperCase(),
                          style: const TextStyle(
                              fontFamily: 'Acme',
                              color: Colors.yellowAccent,
                              fontSize: 14,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              );
            })),
      ),
    );
  }
}
