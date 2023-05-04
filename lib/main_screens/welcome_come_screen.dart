import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/main_screens/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeComeScreen extends StatefulWidget {
  const WelcomeComeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeComeScreenState createState() => _WelcomeComeScreenState();
}

class _WelcomeComeScreenState extends State<WelcomeComeScreen>
    with SingleTickerProviderStateMixin {
  late bool isProcessing = false;
  late AnimationController _controller;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  late String _uid;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/inapp/bgimage.jpg'), fit: BoxFit.cover),
      ),
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextAnimated(
                  label1: 'welcome'.toUpperCase(),
                  label2: 'chi chi store'.toUpperCase()),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(image: AssetImage('images/inapp/logo.jpg')),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Acme",
                        color: Colors.lightBlueAccent),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('BUY'),
                        RotateAnimatedText('SHOP'),
                        RotateAnimatedText('CHI CHI'),
                      ],
                      repeatForever: true,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Suppliers only',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white38.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimationLogo(controller: _controller),
                        YellowBtn(
                            label: 'log in'.toUpperCase(),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/supplier_login');
                            },
                            width: 0.25),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: YellowBtn(
                              label: 'sign up'.toUpperCase(),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/supplier_signup');
                              },
                              width: 0.25),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        YellowBtn(
                            label: 'log in'.toUpperCase(),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/customer_login');
                            },
                            width: 0.25),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: YellowBtn(
                              label: 'sign up'.toUpperCase(),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/customer_signup');
                              },
                              width: 0.25),
                        ),
                        AnimationLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white38,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GoogleFacebookLogin(
                      lable: 'Google',
                      onPressed: () {},
                      child: Image.asset('images/inapp/google.jpg'),
                    ),
                    GoogleFacebookLogin(
                      lable: 'Facebook',
                      onPressed: () {},
                      child: Image.asset('images/inapp/facebook.jpg'),
                    ),
                    isProcessing == true
                        ? const CircularProgressIndicator()
                        : GoogleFacebookLogin(
                            lable: 'Guest',
                            onPressed: () async {
                              setState(() {
                                isProcessing = true;
                              });
                              await FirebaseAuth.instance
                                  .signInAnonymously()
                                  .whenComplete(() async {
                                _uid = FirebaseAuth.instance.currentUser!.uid;    
                                await anonymous.doc(_uid).set({
                                  'name': '',
                                  'email': '',
                                  'profileImage': '',
                                  'phone': '',
                                  'address': '',
                                  'cid': _uid,
                                });
                              });

                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, '/customer_screen');
                            },
                            // ignore: prefer_const_constructors
                            child: Icon(
                              Icons.person,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                          )
                  ],
                ),
              )
            ]),
      ),
    ));
  }
}

class TextAnimated extends StatelessWidget {
  final String label1;
  final String label2;
  const TextAnimated({super.key, required this.label1, required this.label2});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(label1.toUpperCase(),
            // ignore: prefer_const_constructors
            textStyle: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontFamily: 'Acme',
            ),
            colors: [
              Colors.yellowAccent,
              Colors.red,
              Colors.blueAccent,
              Colors.teal
            ]),
        ColorizeAnimatedText(label2.toUpperCase(),
            // ignore: prefer_const_constructors
            textStyle: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontFamily: 'Acme',
            ),
            colors: [
              Colors.yellowAccent,
              Colors.red,
              Colors.blueAccent,
              Colors.teal
            ])
      ],
      isRepeatingAnimation: true,
      repeatForever: true,
    );
  }
}

class AnimationLogo extends StatelessWidget {
  const AnimationLogo({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(image: AssetImage('images/inapp/logo.jpg')),
    );
  }
}

// ignore: must_be_immutable
class GoogleFacebookLogin extends StatelessWidget {
  String lable;
  Function() onPressed;
  Widget child;
  GoogleFacebookLogin({
    super.key,
    required this.child,
    required this.lable,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 30, width: 30, child: child),
            Text(lable)
          ],
        ),
      ),
    );
  }
}
