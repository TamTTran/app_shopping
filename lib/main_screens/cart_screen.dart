import 'package:flutter/material.dart';

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
          appBar: AppBar(
            leading: widget.back,
            elevation: 0,
            title: const Text(
              'Cart',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Acme',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.5),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_forever),
                color: Colors.black,
              )
            ],
          ),
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Your Cart Is Empty!!!',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Acme', fontSize: 30),
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

class YellowBtn extends StatelessWidget {
  final String label;
  final Function() onPressed;
  double width;
  YellowBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
