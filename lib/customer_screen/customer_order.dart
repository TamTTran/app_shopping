import 'package:flutter/material.dart';
class CustomerOrder extends StatelessWidget {
const CustomerOrder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Customer Order', style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Acme'

        ),),
      ),
    );
  }
}