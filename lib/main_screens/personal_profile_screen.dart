import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/customer_screen/customer_order.dart';
import 'package:data_mysql/customer_screen/wishlist.dart';
import 'package:data_mysql/main_screens/cart_screen.dart';
import 'package:data_mysql/widget/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalProfileScreen extends StatefulWidget {
  final String documentId;
  PersonalProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final bool _pinned = true;
  final bool _floating = false;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
 
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anonymous.doc(widget.documentId).get()
          : customer.doc(widget.documentId).get(),
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
          return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(
                children: [
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.brown])),
                  ),
                  CustomScrollView(slivers: [
                    SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      expandedHeight: 150,
                      pinned: _pinned,
                      floating: _floating,
                      centerTitle: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, BoxConstraints constraints) {
                          return FlexibleSpaceBar(
                            centerTitle: true,
                            title: AnimatedOpacity(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.bounceIn,
                              opacity:
                                  constraints.biggest.height <= 130 ? 1 : 0,
                              child: const Text('Account',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            background: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.yellow, Colors.brown])),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 25),
                                child: Row(
                                  children: [
                                    data['profileImage'] == ''
                                        ? const CircleAvatar(
                                            radius: 60,
                                            backgroundImage: AssetImage(
                                                'images/inapp/guest.jpg'),
                                          )
                                        : CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                                data['profileImage']),
                                          ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        data['name'] == ''
                                            ? 'guest'.toUpperCase()
                                            : data['name'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Column(children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              child: SizedBox(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: TextButton(
                                    child: const Text(
                                      'Cart',
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CartScreen(
                                              back: BackButton(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ));
                                    },
                                  )),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(00),
                                      bottomLeft: Radius.circular(00))),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextButton(
                                  child: const Text(
                                    'Order',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomerOrder(),
                                        ));
                                  },
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextButton(
                                  child: const Text(
                                    'Wishlist',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WishListScreen(),
                                        ));
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(children: [
                        Container(
                          color: Colors.grey.shade300,
                          child: const SizedBox(
                              height: 150,
                              child: Image(
                                image: AssetImage('images/inapp/logo.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const ProfileHeaderLable(
                          headerLable: 'Account Info',
                        ),
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RepeatedLableTitle(
                                  labelTitle: 'Email Address',
                                  icon: Icons.email,
                                  onPressed: () {},
                                  subTitile: data['email'] == ''
                                      ? 'exampp@gmail.com'
                                      : data['email']),
                              const YellowDivder(),
                              RepeatedLableTitle(
                                  labelTitle: 'Phone Number',
                                  icon: Icons.phone,
                                  onPressed: () {},
                                  subTitile: data['phone'] == ''
                                      ? '09xxxxxxx'
                                      : data['phone']),
                              const YellowDivder(),
                              RepeatedLableTitle(
                                  labelTitle: 'Address',
                                  icon: Icons.place,
                                  onPressed: () {},
                                  subTitile: data['address'] == ''
                                      ? 'Example: HCM City'
                                      : data['addresss']),
                              const YellowDivder(),
                            ],
                          ),
                        ),
                        const ProfileHeaderLable(
                            headerLable: 'Account Setting'),
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              RepeatedLableTitle(
                                  labelTitle: 'Email Address',
                                  icon: Icons.email,
                                  onPressed: () {},
                                  subTitile: ''),
                              const YellowDivder(),
                              RepeatedLableTitle(
                                  labelTitle: 'Change Password',
                                  icon: Icons.lock,
                                  onPressed: () {},
                                  subTitile: ''),
                              const YellowDivder(),
                              RepeatedLableTitle(
                                  labelTitle: 'Log out',
                                  icon: Icons.logout,
                                  onPressed: () async {
                                    MyAlertDialog.showMyAlertDialog(
                                        context: context,
                                        title: 'Log out',
                                        router: '/welcome_come_screen',
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
                                  subTitile: ''),
                              const YellowDivder(),
                            ],
                          ),
                        ),
                      ]),
                    ]))
                  ])
                ],
              ));
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.lightGreenAccent,
          ),
        );
      },
    );
  }
}

class YellowDivder extends StatelessWidget {
  const YellowDivder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedLableTitle extends StatelessWidget {
  final String labelTitle;
  final String subTitile;
  final IconData icon;
  final Function() onPressed;
  const RepeatedLableTitle(
      {super.key,
      required this.labelTitle,
      required this.icon,
      required this.onPressed,
      required this.subTitile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(labelTitle),
        subtitle: Text(subTitile),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLable extends StatelessWidget {
  final String headerLable;
  const ProfileHeaderLable({super.key, required this.headerLable});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 40,
            width: 60,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLable,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
            width: 60,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          )
        ]),
      ),
    );
  }
}
